# frozen_string_literal: true

require 'node'
require 'merge_sort'

class Tree
  include MergeSort
  attr_accessor :root

  def initialize(array)
    sorted = merge_sort(array)
    p sorted
    p sorted.uniq
    tree = build_tree(sorted.uniq) # rubocop:disable Style/RedundantAssignment
    tree # rubocop:disable Lint/Void
  end

  def build_tree(array)
    divider = (array.length - 1) / 2
    return nil if array.empty?
    return Node.new(array[0]) if array.length == 1
    return Node.new(array[1], nil, Node.new(array[0])) if array.length == 2

    node_array = [build_tree(array[0..divider - 1]), build_tree(array[divider + 1..array.length - 1])]
    self.root = Node.new(array[divider], node_array.min, node_array.max)
    root
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order(&block)
    queue = [root]
    result = []
    until queue.empty?
      leaf = queue.shift
      block.call(leaf.value) if leaf&.value && block_given?
      result << leaf.value unless block_given? || leaf.nil?
      queue << leaf.left_node if leaf&.left_node
      queue << leaf.right_node if leaf&.right_node
    end
    result unless block_given?
  end

  def inorder(leaf = root, result = [], &block)
    return if leaf.nil?

    preorder(leaf.left_node, result, &block)
    block.call(leaf.value) if block_given?
    result << leaf.value unless block_given?
    preorder(leaf.right_node, result, &block)

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

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end
end
