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
    k = bucket(key)
    @store[k].include?(key)
  end

  def set(key, val)
    k = bucket(key)
    if @store[k].include?(key)
      @store[k].update(key,val)
    else
      @store[k].append(key,val)
      @count += 1
      resize! if @count >= num_buckets
    end
  end

  def get(key)
    k = bucket(key)
    @store[k].get(key)
  end

  def delete(key)
    k = bucket(key)
    if @store[k].include?(key)
      @store[k].remove(key)
      @count -= 1
    end
  end

  def each(&prc)
    @store.each do |el|
      el.each do |node|
        prc.call(node.key, node.val)
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
    store2 = @store
    @store = Array.new(num_buckets * 2) {LinkedList.new}
    @count = 0

    store2.each do |link|
      link.each do |node|
        set(node.key, node.val)
      end
    end
  end

  def bucket(key)
    # optional but useful; return the bucket corresponding to `key`
    key.hash % num_buckets
  end
end
