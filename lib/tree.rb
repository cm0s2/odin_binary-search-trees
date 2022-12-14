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

    return find(root.left, key)
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

  def height(node)
    return -1 if node.nil?

    left_height = height(node.left)
    right_height = height(node.right)
    # puts "Node #{node.data} has LH #{left_height} and RH #{right_height}"

    answer = [left_height, right_height].max + 1

    return answer
  end

  def depth(node, root=@root)
    return -1 if root.nil?

    distance = -1

    # Check to see if we found the node
    return distance + 1 if node == root

    # Recursively search left subtree
    distance = depth(node, root.left)
    return distance + 1 if distance >= 0

    # Recursively search right subtree
    distance = depth(node, root.right)
    return distance + 1 if distance >= 0

    return distance
  end

  def balanced?
    (height(@root.left) - height(@root.right)).abs <= 1
  end

  def rebalance
    @root = build_tree(inorder)
  end

  def level_order(root=@root)
    return if root.nil?

    result = []

    queue = []
    queue.push(root)

    until queue.empty? do
      current = queue.shift
      result.push current.data
      yield current if block_given?

      queue.push current.left unless current.left.nil?
      queue.push current.right unless current.right.nil?
    end

    return result unless block_given?
  end

  def preorder(node=@root, &block)
    return if node.nil?

    if block_given?
      yield node
      preorder(node.left, &block)
      preorder(node.right, &block)
    else
      [node.data] + preorder(node.left).to_a + preorder(node.right).to_a
    end
  end

  def inorder(node=@root, &block)
    return if node.nil?

    if block_given?
      inorder(node.left, &block)
      yield node unless node.nil?
      inorder(node.right, &block)
    else
      # Convert to array for nil children
      inorder(node.left).to_a + [node.data] + inorder(node.right).to_a
    end
  end

  def postorder(node=@root, &block)
    return if node.nil?

    if block_given?
      postorder(node.left, &block)
      postorder(node.right, &block)
      yield node
    else
      postorder(node.left).to_a + postorder(node.right).to_a + [node.data]
    end
  end

  def pretty_print(node = @root, prefix = '', is_left = true)
    pretty_print(node.right, "#{prefix}#{is_left ? '???   ' : '    '}", false) if node.right
    puts "#{prefix}#{is_left ? '????????? ' : '????????? '}#{node.data}"
    pretty_print(node.left, "#{prefix}#{is_left ? '    ' : '???   '}", true) if node.left
  end
end