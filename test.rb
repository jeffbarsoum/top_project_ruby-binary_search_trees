# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'tree'

array = (Array.new(40) { rand(1..500) })
p array
test = Tree.new(array)
puts test.root

# puts 'test preorder:'
# test.preorder { |leaf| p leaf.value }
# p test.preorder
# puts 'test inorder:'
# test.inorder { |leaf| p leaf }
# p test.inorder
# puts 'test postorder:'
# test.postorder { |leaf| p leaf }
# p test.postorder
# puts 'test levelorder:'
# test.level_order { |leaf| p leaf }
# p test.level_order

# p "find first item: #{test.find(array[0])}"
# p "test finding nonexistent item: #{test.find('cat')}"
p "delete #{array[0]}"

test.delete(array[0])
puts test.root
# test.inorder { |leaf| p leaf if leaf.right_node.nil? || leaf.left_node.nil? }

# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order
# Unbalance the tree by adding several numbers > 100
# Confirm that the tree is unbalanced by calling #balanced?
# Balance the tree by calling #rebalance
# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order.
