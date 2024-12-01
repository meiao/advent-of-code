class Node
  def initialize(value)
    @next = nil
    @value = value
  end

  attr_accessor :next
  attr_reader :value

  def insert(node)
    old_next = @next
    @next = node
    n = node
    n = n.next until n.next.nil?
    n.next = (old_next)
  end
end
