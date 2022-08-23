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

  def find(root=@root, key)
    return root if root.nil? or root.data == key

    return find(root.right, key) if root.data < key

    return search(root.left, key)
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

  # Find lowest value in the tree
  def min_value_node(node)
    current = node
    until current.left.nil? do
      current = current.left
    end

    return current
  end

  def delete(root=@root, key)
    return root if root.nil?

    if key < root.data
      root.left = delete(root.left, key)
    elsif key > root.data
      root.right = delete(root.right, key)
    else
      if root.left.nil?
        temp = root.right
        root = nil
        return temp
      elsif root.right.nil?
        temp = root.right
        root = nil
        return temp
      end

      # Node with two children:
      # Get the inorder successor (smallest in the right subtree)
      temp = min_value_node(root.right)

      # Copy the inorder successor's content to this node
      root = Node.new(temp.data, temp.left, temp.right)

      # Delete the inorder successor
      root.right = delete(root.right, temp.data)
    end

    return root
  end

  def print_inorder(node=@root)
    return if node.nil?

    preorder(node.left)
    puts node.data
    preorder(node.right)
  end

  def print_preorder(node=@root)
    return if node.nil?

    puts node.data
    print_preorder(node.left)
    print_preorder(node.right)
  end

  def print_postorder(node=@root)
    return if node.nil?
    
    preorder(node.left)
    preorder(node.right)
    puts node.data
  end
end