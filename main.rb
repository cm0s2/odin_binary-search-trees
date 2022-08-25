# frozen_string_literal: true

require_relative "lib/node"
require_relative "lib/tree"

array = (Array.new(15) { rand(1..100) })
tree = Tree.new(array)

puts "Balanced:  #{tree.balanced?}"
puts "Preorder:  #{tree.preorder}"
puts "Inorder:   #{tree.inorder}"
puts "Postorder: #{tree.postorder}"
puts "Adding random numbers > 100..."
tree.insert(rand(100..200))
tree.insert(rand(100..200))
tree.insert(rand(100..200))
puts "Balanced:  #{tree.balanced?}"
puts "Rebalancing..."
tree.rebalance
puts "Balanced:  #{tree.balanced?}"
puts "Preorder:  #{tree.preorder}"
puts "Inorder:   #{tree.inorder}"
puts "Postorder: #{tree.postorder}"
