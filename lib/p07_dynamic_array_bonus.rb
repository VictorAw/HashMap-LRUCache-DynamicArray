class StaticArray
  def initialize(capacity)
    @store = Array.new(capacity) { nil }
  end

  def [](i)
    validate!(i)
    @store[i]
  end

  def []=(i, val)
    validate!(i)
    @store[i] = val
  end

  def length
    @store.length
  end

  private

  def validate!(i)
    raise "Overflow error" unless i.between?(0, @store.length - 1)
  end
end

class DynamicArray
  include Enumerable

  attr_reader :count

  def initialize(capacity = 8)
    @store = StaticArray.new(capacity)
    @count = 0
  end

  def [](i)
    return nil if i >= capacity
    if i < 0
      return nil if (-1 * i) > @count
      i = @count + i
    end

    @store[i]
  end

  def []=(i, val)
    if i < 0
      i = @count + i
    end

    resize! if i >= capacity

    @store[i] = val
    @count = i+1 if i >= @count
  end

  def capacity
    @store.length
  end

  def include?(val)
    i = 0
    while i < capacity
      return true if @store[i] == val
      i += 1
    end
    false
  end

  def push(val)
    self[@count] = val
  end

  def unshift(val)
    i = @count-1
    while i >= 0
      @store[i+1] = @store[i]
      i -= 1
    end
    @store[0] = val
  end

  def pop
    item = nil
    if @count > 0
      item = @store[@count-1]

      @store[@count-1] = nil
      @count -= 1
    end
    item
  end

  def shift
    item = @store[0]
    i = 0
    while i < @count-1
      @store[i] = @store[i+1]
      i += 1
    end

    if count > 0
      @store[@count-1] = nil
      @count -= 1
    end

    item
  end

  def first
    @store[0]
  end

  def last
    @store[@count-1]
  end

  def each(&block)
    i = 0
    while i < @count
      block.call(@store[i])
      i += 1
    end

    self
  end

  def to_s
    "[" + inject([]) { |acc, el| acc << el }.join(", ") + "]"
  end

  def ==(other)
    # puts "DynamicArray#== called"
    return false unless [Array, DynamicArray].include?(other.class)

    return false if size != other.size
    i = 0
    while i < size
      return false if self[i] != other[i]
      i += 1
    end

    true
  end

  alias_method :<<, :push
  [:length, :size].each { |method| alias_method method, :count }

  private

  def resize!
    new_size = (4.2 / 2) * capacity
    new_arr = StaticArray.new(new_size)
    i = 0
    while i < @count
      new_arr[i] = @store[i]
      i += 1
    end
    @store = new_arr
  end
end

if __FILE__ == $PROGRAM_NAME
  # d = DynamicArray.new(3)
  # d[4] = 1
  # r = [nil, nil, nil, nil, 1]
  # p d == r
  #
  # d[0] = 1
  # r[0] = 1
  # p d == r

  d = DynamicArray.new
  a = []
  a << nil
  d << nil
  puts "d == a" # DynamicArray#== called
  p d == a # Evaluates to true since DynamicArrays can handle Arrays
  puts
  puts "a == d" # DynamicArray#== not called
  p a == d # Array can't equal DynamicArray since it doesn't know how to handle DynamicArrays
  puts

  a[3] = 1
  d[3] = 1
  puts "d == a" # DynamicArray#== called
  p d == a
  puts
  puts "a == d" # DynamicArray#== not called
  p a == d
  puts

  a[10] = 2
  d[10] = 2
  puts "d == a" # DynamicArray#== called
  p d == a
  puts
  puts "a == d" # DynamicArray#== not called
  p a == d
  puts

end
