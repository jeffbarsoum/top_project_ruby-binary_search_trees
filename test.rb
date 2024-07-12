# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'tree'

array = (Array.new(15) { rand(1..100) })
p array
test = Tree.new(array)
puts test.root

# puts 'test preorder:'
# test.preorder { |leaf| p leaf }
# p test.preorder
# puts 'test inorder:'
# test.inorder { |leaf| p leaf }
# p test.inorder
# puts 'test postorder:'
# test.postorder { |leaf| p leaf }
# p test.postorder
puts 'test levelorder:'
test.level_order { |leaf| p leaf }
p test.level_order

# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order
# Unbalance the tree by adding several numbers > 100
# Confirm that the tree is unbalanced by calling #balanced?
# Balance the tree by calling #rebalance
# Confirm that the tree is balanced by calling #balanced?
# Print out all elements in level, pre, post, and in order.
