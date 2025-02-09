# frozen_string_literal: true

$LOAD_PATH.unshift "#{File.dirname(__FILE__)}/lib"

require 'tree'

array = (Array.new(40) { rand(1..500) })
p array
test = Tree.new(array)
puts test.root

# insert_plus = array[10] + 1
# insert_minus = array[10] - 1
# p "insert #{insert_minus}, #{insert_plus}"

# test.insert(insert_plus)
# test.insert(insert_minus)
# puts test.root

# p "height #{array[0]}: #{test.height(test.find(array[0]))}"
# p "depth #{array[0]}: #{test.depth(test.find(array[0]))}"

p "balanced? #{test.balanced?}"

p 'Print out all elements in level, pre, post, and in order'

puts 'test preorder:'
test.preorder { |leaf| p leaf.value }
p test.preorder
puts 'test inorder:'
test.inorder { |leaf| p leaf.value }
p test.inorder
puts 'test postorder:'
test.postorder { |leaf| p leaf.value }
p test.postorder
puts 'test levelorder:'
test.level_order { |leaf| p leaf.value }
p test.level_order

p 'unbalance tree, insert numbers > 500...'
test.insert(501)
test.insert(502)
test.insert(505)
test.insert(503)
test.insert(504)
p 'tree should be unbalanced now...'
p "balanced? #{test.balanced?}"
puts test.root

p 'rebalance time...'
test.rebalance
p 'tree should be balanced now...'
p "balanced? #{test.balanced?}"
puts test.root

p "find first item: #{test.find(array[0])}"
p "test finding nonexistent item: #{test.find('cat')}"

p "delete #{array[0]}"
test.delete(array[0])
puts test.root
