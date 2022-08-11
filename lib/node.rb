# frozen_string_literal: true

class Node
  include Comparable

  attr_reader :data
  attr_accessor :left, :right

  def <=> (other_node)
    data <=> other_node.data
  end

  def initialize(data, left=nil, right=nil)
    @data = data
    @left = left
    @right = right
  end

  def to_s
    @data.to_s
  end
end