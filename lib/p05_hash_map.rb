require_relative 'p02_hashing'
require_relative 'p04_linked_list'

class HashMap
  include Enumerable

  attr_reader :count

  def initialize(num_buckets = 8)
    @store = Array.new(num_buckets) { LinkedList.new }
    @count = 0
  end

  def include?(key)
    bucket(key).include?(key)
  end

  def set(key, val)
    if bucket(key).include?(key)
      bucket(key).remove(key)
    end
    bucket(key).insert(key, val)
    @count += 1
    resize! if @count > num_buckets
  end

  def get(key)
    bucket(key).get(key)
  end

  def delete(key)
    bucket(key).remove(key)
    @count -= 1 unless @count == 0
  end

  def each(&block)
    @store.each do |bucket|
      bucket.each do |k_v|
        block.call(k_v.key, k_v.val)
      end
    end
  end

  # uncomment when you have Enumerable included
  # def to_s
  #   pairs = inject([]) do |strs, (k, v)|
  #     strs << "#{k.to_s} => #{v.to_s}"
  #   end
  #   "{\n" + pairs.join(",\n") + "\n}"
  # end

  alias_method :[], :get
  alias_method :[]=, :set

  private

  def num_buckets
    @store.length
  end

  def resize!
    new_size = @store.length * 2
    new_arr = Array.new(new_size) { LinkedList.new }
    each do |k, v|
      new_arr[k.hash % new_size].insert(k, v)
    end
    @store = new_arr
  end

  def bucket(key)
    @store[key.hash % num_buckets]
    # optional but useful; return the bucket corresponding to `key`
  end
end
