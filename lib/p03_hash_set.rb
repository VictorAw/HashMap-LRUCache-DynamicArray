require_relative 'p02_hashing'

class HashSet
  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { Array.new }
    @count = 0
  end

  def insert(num)
    if !self[num].include?(num)
      self[num] << num
      @count += 1

      if @count > num_buckets
        resize!
      end

      true
    end
  end

  def remove(num)
    if include?(num)
      self[num].delete(num)
      @count -= 1
    end
  end

  def include?(num)
    self[num].include?(num)
  end

  private

  def [](num)
    # optional but useful; return the bucket corresponding to `num`
    @store[num.hash % num_buckets]
  end

  def num_buckets
    @store.length
  end

  def resize!
    new_size = num_buckets * 2
    new_arr = Array.new(new_size) { Array.new }
    @store.each do |bucket|
      bucket.each do |el|
        new_arr[el % new_size] << el
      end
    end

    @store = new_arr
  end
end
