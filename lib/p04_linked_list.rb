class Link
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
end

class LinkedList
  include Enumerable

  def initialize
    @head = Link.new(:head)
    @tail = @head
    @head.next = @tail
    @tail.prev = @head
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
    @tail.prev == @head
  end

  def get_link(key)
    each { |link| return link if link.key == key }
    nil
  end

  def get(key)
    node = get_link(key)
    return node.val if node
    nil
  end

  def include?(key)
    !get_link(key).nil?
  end

  def insert(key, val)
    link = Link.new(key, val)

    link.prev = @tail.prev
    link.prev.next = link

    link.next = @tail
    @tail.prev = link
  end

  def remove(key)
    removed = get_link(key)
    return nil unless removed

    removed.next.prev = removed.prev

    removed.prev.next = removed.next

    removed
  end

  def each(&block)
    i = @head.next
    until i == @tail
      block.call(i)
      i = i.next
    end

    self
  end

  # uncomment when you have `each` working and `Enumerable` included
  def to_s
    inject([]) { |acc, link| acc << "[#{link.key}, #{link.val}]" }.join(", ")
  end
end
