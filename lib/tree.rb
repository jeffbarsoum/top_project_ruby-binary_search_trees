# frozen_string_literal: true

require 'node'
require 'merge_sort'

class Tree
  include MergeSort
  attr_accessor :root

  def initialize(array)
    sorted = merge_sort(array)
    build_tree(sorted)
  end

  def build_tree(array)
    divider = array.length / 2
    return array if array.length == 1

    left_array = array[0..divider - 1]
    right_array = array[divider + 1..array.length - 1]
    self.root = Node.new(root, build_tree(left_array), build_tree(right_array))
    root
  end

  def insert(value); end

  def delete(value); end

  def find(value); end

  def level_order(&block); end

  def inorder(&block); end

  def preorder(&block); end

  def postorder(&block); end

  def height(node); end

  def depth(node); end

  def balanced?; end

  def rebalance; end
end
tree = Tree.new([1, 2, 3, 4, 5])
puts tree.root
