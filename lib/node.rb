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

  def to_s
    "[ ( #{left_node.value} ) <-- { #{value} } --> ( #{right_node.value} )  ]"
  end
end
