require 'byebug'

class Node
  attr_accessor :key, :val, :next, :prev

  def initialize(key = nil, val = nil)
    @key = key
    @val = val
    @next = nil
    @prev = nil
  end

  def to_s
    "#{@key}: #{@val}"
  end

  def remove
    # optional but useful, connects previous link to next link
    # and removes self from list.

    @prev.next = @next
    @next.prev = @prev
    @next = nil
    @prev = nil

  end
end

class LinkedList
  include Enumerable

  attr_reader :head, :tail


  def initialize
    @head = Node.new
    @tail = Node.new

    @head.next = @tail
    @tail.prev = @head

    @size = 0

  end

  def [](i)
    each_with_index { |link, j| return link if i == j }
    nil
  end

  def first
    @head.next
  end

  def last
    @tail.prev
  end

  def empty?
    @size == 0
  end

  def get(key)
    current = first
    until current == @tail
      if key == current.key
        return current.val
        break
      end
      current = current.next
    end
    nil
  end

  def include?(key)
    current = first
    until current == @tail
      return true if key == current.key
      current = current.next
    end
    false
  end

  def append(key, val)
    node = Node.new(key, val)

    if empty?
      @head.next = node
      node.next = @tail
      @tail.prev = node
      node.prev = @head
    else
      last.next = node
      node.prev = last
      node.next = @tail
      @tail.prev = node

    end
    @size += 1
    node
  end

  def update(key, val)
    current = first
    until current == @tail
      if key == current.key
        current.val = val
        break
      end
      current = current.next
    end
  end

  def remove(key)
    current = first
    until current == @tail
      if key == current.key
        current.remove
        @size -= 1
        break
      end
      current = current.next
    end
  end

  def each(&prc)

    current = first
    until current == @tail
      prc.call(current)
      current = current.next
    end

  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
