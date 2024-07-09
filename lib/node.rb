# frozen_string_literal: true

# Parent Node class, for Hashes and LinkedLists, keys and values are added by children
class Node
  include Comparable
  # setters and getters for "value" and "next_node"
  attr_accessor :left_node, :right_node, :value

  def <=>
    left_node <=> right_node
  end

  def initialize(value, left_node, right_node)
    self.value = value
    self.left_node = left_node
    self.right_node = right_node
  end

  def to_s(node = self, prefix = '', is_left = true)
    to_s(node.right_node, "#{prefix}#{is_left ? '│   ' : '    '}", false) if node.right_node
    puts "#{prefix}#{is_left ? '└── ' : '┌── '}#{node.value}"
    to_s(node.left_node, "#{prefix}#{is_left ? '    ' : '│   '}", true) if node.left_node
    # "[ ( #{left_node} ) <-- { #{value} } --> ( #{right_node} )  ]"
  end
end
