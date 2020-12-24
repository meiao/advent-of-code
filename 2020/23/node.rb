class Node
  def initialize(value)
    @next = nil
    @value = value
  end

  def value
    @value
  end

  def next
    @next
  end

  def next=(node)
    @next = node
  end

  def insert(node)
    old_next = @next
    @next = node
    n = node
    while (n.next != nil)
      n = n.next
    end
    n.next=(old_next)
  end
end
