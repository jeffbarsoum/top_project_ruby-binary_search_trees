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

  def level_order(&block); end

  def inorder(&block); end

  def preorder(leaf = root, &block)
    result = []
    return if leaf.nil?

    block.call(leaf.value) if block_given? && leaf.value
    result << leaf.value unless block_given? || !leaf.value
    preorder(leaf.left_node, &block)
    preorder(leaf.right_node, &block)

    result unless block_given?
  end

  def postorder(&block); end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end
end
