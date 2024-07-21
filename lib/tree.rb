# frozen_string_literal: true

require 'node'
require 'merge_sort'

# Binary search tree
class Tree
  include MergeSort
  attr_accessor :root

  def initialize(array)
    build_tree(merge_sort(array).uniq)
  end

  def build_tree(array) # rubocop:disable Metrics/AbcSize
    divider = (array.length - 1) / 2
    return nil if array.empty?
    return Node.new(array[0]) if array.length == 1
    return Node.new(array[1], Node.new(array[0])) if array.length == 2

    left_node = build_tree(array[0..divider - 1])
    right_node = build_tree(array[divider + 1..array.length - 1])
    self.root = Node.new(array[divider], left_node, right_node)
  end

  def insert(value)
    return false if find(value)

    node = Node.new(value)
    parent_node = nil
    insert_node = root
    while insert_node
      parent_node = insert_node
      insert_node = insert_node < node ? insert_node.right_node : insert_node.left_node
    end
    parent_node.right_node = node if parent_node < node
    parent_node.left_node = node if parent_node > node
  end

  def delete(value)
    delete_node = find(value)
    return nil unless delete_node
    return set_node(delete_node) if leaf?(delete_node)

    replace_node = next_largest(delete_node)
    replace_value = replace_node.value
    delete(replace_value)
    set_node(delete_node, replace_value)

    value
  end


  def set_node(node, new_value = nil)
    return nil if node.nil?
    return nil if new_value && find(new_value)

    parent_node = parent(node)
    if parent_node.left_node == node
      parent_node.left_node.value = new_value if new_value
      parent_node.left_node = nil unless new_value
    else
      parent_node.right_node.value = new_value if new_value
      parent_node.right_node = nil unless new_value
    end
    parent_node
  end

  def leaf?(node)
    node.left_node.nil? && node.right_node.nil?
  end

  def parent?(parent_node, child_node)
    return parent_node if parent_node.left_node?(child_node) || parent_node.right_node?(child_node)

    false
  end

  def next_largest(node)
    return nil unless node

    n = node.value
    node = parent(node) until node.right_node && node.value >= n
    result = node.right_node
    result = result.left_node until result.left_node.nil?
    result
  end

  def parent(node)
    return nil unless node&.value

    preorder { |leaf| return leaf if parent?(leaf, node) }
  end

  def find(value)
    preorder { |leaf| return leaf if leaf.value == value }
    false
  end

  def level_order(&block)
    queue = [root]
    result = []
    until queue.empty?
      leaf = queue.shift
      block.call(leaf) if block_given?
      result << leaf.value unless block_given?
      queue << leaf.left_node if leaf.left_node
      queue << leaf.right_node if leaf.right_node
    end
    result unless block_given?
  end

  def inorder(leaf = root, result = [], &block)
    return if leaf.nil?

    inorder(leaf.left_node, result, &block)
    block.call(leaf) if block_given?
    result << leaf.value unless block_given?
    inorder(leaf.right_node, result, &block)

    result unless block_given?
  end

  def preorder(leaf = root, result = [], &block)
    return if leaf.nil?

    block.call(leaf) if block_given?
    result << leaf.value unless block_given?
    preorder(leaf.left_node, result, &block)
    preorder(leaf.right_node, result, &block)

    result unless block_given?
  end

  def postorder(leaf = root, result = [], &block)
    return if leaf.nil?

    postorder(leaf.left_node, result, &block)
    postorder(leaf.right_node, result, &block)
    block.call(leaf) if block_given?
    result << leaf.value unless block_given?

    result unless block_given?
  end

  def height(node)
    branch_cnt = []
    inorder(node) do |nd|
      if leaf?(nd)
        branch_cnt << 0
        until nd == node
          nd = parent(nd)
          branch_cnt[-1] += 1
        end
      end
    end
    branch_cnt.max
  end

  def depth(node)
    branch_cnt = 0
    parent_node = node
    until parent_node == root
      parent_node = parent(parent_node)
      branch_cnt += 1
    end
    branch_cnt
  end

  def balanced?
    (-1..1).member?(height(root.left_node) - height(root.right_node))
  end

  def rebalance
    build_tree(inorder)
  end
end
