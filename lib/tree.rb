# frozen_string_literal: true

require_relative "node"

class Tree
  def initialize(array)
    @root = build_tree(array)
  end

  def build_tree(array)
    return nil if array.empty?

    # Sort array and remove duplicates
    array_uniq_sorted = array.sort.uniq

    # Find middle index
    mid = array_uniq_sorted.length / 2

    # Make the middle element the root
    root = Node.new(array_uniq_sorted[mid])
    root.left = build_tree(array_uniq_sorted[...mid])
    root.right = build_tree(array_uniq_sorted[mid+1...])

    return root
  end

  def insert(root=@root, data)
    return Node.new(data) if root.nil?

    if root.data == data
      return root
    elsif root.data < data
      root.right = insert(root.right, data)
    else
      root.left = insert(root.left, data)
    end

    return root
  end

  def inorder(node=@root)
    return if node.nil?

    preorder(node.left)
    puts node.data
    preorder(node.right)
  end

  def preorder(node=@root)
    return if node.nil?

    puts node.data
    preorder(node.left)
    preorder(node.right)
  end

  def postorder(node=@root)
    return if node.nil?
    
    preorder(node.left)
    preorder(node.right)
    puts node.data
  end
end