require_relative 'p05_hash_map'
require_relative 'p04_linked_list'

class LRUCache
  attr_reader :count
  def initialize(max, prc)
    @map = HashMap.new
    @store = LinkedList.new
    @max = max
    @prc = prc
  end

  def count
    @map.count
  end

  def get(key)
    if @map[key].nil?
      @store.insert(key, @prc.call(key))
      @map.set(key, @store.last)
    else
      @store.insert(key, @store.remove(key).val)
    end
    eject! if count > @max
    @map.get(key).val
  end

  def to_s
    "Map: " + @map.to_s + "\n" + "Store: " + @store.to_s
  end

  private

  def calc!(key)
    # suggested helper method; insert an (un-cached) key

  end

  def update_link!(link)
    # suggested helper method; move a link to the end of the list

  end

  def eject!
    node = @store.remove(@store.first.key)
    @map.delete(node.key) if node
  end
end
