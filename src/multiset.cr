# Multiset implements a collection of unordered elements with duplicates.
# Also known as Bag.
#
# Multiset uses `Hash` as storage.
#
# ### Examples
# ```
# ms1 = Multiset.new [1, 2]
# ms2 = Multiset{2, 1}
# ms1 == ms2          # => true
# ms1.add(2)          # => Multiset{1, 2, 2}
# ms1.merge([2, 6])   # => Multiset{1, 2, 2, 2, 6}
# ms1.multiplicity(2) # => 3
# ms1.subset? ms2     # => false
# ms2.subset? ms1     # => true
# ```
struct Multiset(T)
  include Enumerable(T)
  include Iterable

  VERSION = "0.1.2"

  # creates a new empty multiset
  #
  # if `initial_capacity` is given, it will determine the initial capacity of
  # the `Hash` used internally
  #
  # ### Example
  # ```
  # ms = Multiset(Int32).new
  # ms.empty # => true
  # ```
  def initialize(initial_capacity = nil)
    @hash = Hash(T, Int32).new(
      default_value: 0,
      initial_capacity: initial_capacity
    )
  end

  # returns a new multiset with elements from the given `Enumerable`
  #
  # ### Example
  # ```
  # Multiset.new([1, 2, 3, 1]) # => Multiset{1, 1, 2, 3}
  # ```
  def self.new(enumerable : Enumerable(T))
    Multiset(T).new.merge(enumerable)
  end

  # returns the number of elements
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3}.size       # => 3
  # Multiset{1, 1, 1, 2, 3}.size # => 5
  # ```
  def size
    @hash.values.sum
  end

  # returns `true` if the multiset has no elements
  #
  # ### Example
  # ```
  # Multiset(Int32).new.empty? # => true
  # Multiset{1, 2, 3}.empty?   # => false
  # ```
  def empty?
    @hash.empty?
  end

  # returns `true` if given `Object` is an element in the multiset
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3}.includes?(3)   # => true
  # Multiset{1, 2, 3}.includes?(4)   # => false
  # Multiset{1, 2, 3}.includes?('a') # => false
  # ```
  def includes?(object)
    @hash.has_key?(object)
  end

  # calls the given block for each element, yielding the element as a parameter.
  # Returns `self`
  def each
    @hash.each do |elem, count|
      count.times { yield elem }
    end
    self
  end

  # returns an iterator over each element
  def each
    MultiEntryIterator(typeof(@hash.each), T).new(@hash.each)
  end

  # increments multiplicity of the given `Object` by `count` and returns self
  #
  # ### Example
  # ```
  # Multiset{4, 5}.add(6, 2) # => Multiset{1, 2, 6, 6}
  # ```
  def add(object : T, count : Int32)
    raise ArgumentError.new("attempt to add negative count") if count < 0
    @hash[object] += count if count > 0
    self
  end

  # increments multiplicity of the given `Object` and returns `self`
  #
  # ## Example
  # ```
  # Multiset{1, 2, 3}.add(4) # => Multiset{1, 2, 3, 4}
  # ```
  def add(object : T)
    @hash[object] += 1
    self
  end

  # increments multiplicity of the given `Object` and returns `self`
  #
  # ### Example
  # ```
  # ms = Multiset{1, 2, 3}
  # ms << 4 # => Multiset{1, 2, 3, 4}
  # ```
  def <<(object : T)
    add object
  end

  # adds all elements from the given multiset and returns `self`
  #
  # ### Example
  # ```
  # ms = Multiset{3, 4, 5}
  # Multiset{1, 2, 3}.merge(ms) # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def merge(elems : Multiset(T))
    elems.@hash.each { |elem, count| @hash[elem] += count }
    self
  end

  # adds `#each` element and returns `self`
  #
  # ### Example
  # ```
  # ary = [3, 4, 5]
  # Multiset{1, 2, 3}.merge(ary) # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def merge(elems)
    elems.each { |elem| add(elem) }
    self
  end

  # adds all objects in the given `Enumerable` to a copy of `self`
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3} + Multiset{3, 4, 5} # => Multiset{1, 2, 3, 3, 4, 5}
  # Multiset{1, 2, 3} + [3, 4, 5]         # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def +(other)
    dup.merge(other)
  end

  # decrements multiplicity of the given `Object` and returns `self`
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3}.delete(2) # => Multiset{1, 3}
  # Multiset{4, 4, 5}.delete(4) # => Multiset{4, 5}
  # ```
  def delete(object)
    @hash.delete(object) if (@hash[object] -= 1) < 1
    self
  end

  # decrements multiplicity of the given `Object` by `count` and returns `self`
  def delete(object, count : Int32)
    raise ArgumentError.new("attempt to add negative count") if count < 0
    @hash.delete(object) if (@hash[object] -= count) < 1
    self
  end

  # returns count of the given `Object` in the multiset
  #
  # ### Example
  # ```
  # ms = Multiset{1, 2, 2}
  # ms.multiplicity(1) # => 1
  # ms.multiplicity(2) # => 2
  # ```
  def multiplicity(object : T)
    @hash[object]
  end

  # returns 0
  def multiplicity(object : U)
    0
  end

  # returns a duplicate of `self`
  def dup
    Multiset(T).new.merge(self)
  end

  # returns `true` if both multisets contain the same elements
  def ==(other : Multiset)
    same?(other) || @hash == other.@hash
  end

  # returns `true` if both sets contain the same elements
  def ==(other : Set)
    size == other.size && other.all? { |o| includes?(o) }
  end

  # removes all elements in given `Enumerable` from multiset and returns `self`
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3}.subtract([1, 3]) # => Multiset{2}
  # ```
  def subtract(other : Multiset)
    other.@hash.each { |elem, count| delete(elem, count) }
    self
  end

  def subtract(other : Enumerable)
    other.each { |e| delete(e) }
    self
  end

  # returns a new multiset with all elements in given `Enumerable` removed
  #
  # ### Example
  # ```
  # Multiset{1, 2, 3} - [1, 3] # => Multiset{2}
  # ```
  def -(other : Enumerable)
    dup.subtract(other)
  end

  # returns a new multiset built by performing multiset intersection with the
  # given `Enumerable`
  #
  # For each element, new multiplicity is minimum multiplicity in either
  # multiset
  #
  # ### Example
  # ```
  # ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}
  # ms2 = Multiset{1, 1, 3, 3, 6}
  # ms3 = Multiset{'a', 1, 1}
  #
  # ms1 & ms2 # => Multiset{1, 1, 3}
  # ms1 & ms3 # => Multiset{1, 1}
  # ```
  def &(other : Multiset)
    n = Multiset(T).new
    @hash.each do |elem, count|
      oc = other.multiplicity(elem)
      n.add(elem, oc < count ? oc : count)
    end
    n
  end

  def &(other : Enumerable)
    n = Multiset(T).new
    other.each do |elem|
      next unless elem.is_a? T
      count = multiplicity(elem)
      n.add(elem) if count > 0 && n.multiplicity(elem) < count
    end
    n
  end

  # returns a new multiset built by performing mutiset union with the given
  # `Enumerable`
  #
  # For each element, new multiplicity is maximum multiplicity in either
  # multiset.
  #
  # ### Example
  # ```
  # ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}
  # ms2 = Multiset{1, 1, 3, 3, 6}
  # ms3 = Multiset{'a', 1, 1}
  #
  # ms1 | ms2 # => Multiset{1, 1, 1, 3, 3, 6, 2, 2, 4, 5}
  # ms1 | ms3 # => Multiset{'a', 1, 1, 1, 2, 2, 3, 4, 5}
  # ```
  def |(other : Enumerable)
    union_merge(other) { |v1, v2| v1 < v2 ? v2 : v1 }
  end

  # returns a new multiset built by performing symmetric difference with the
  # given `Enumerable`
  #
  # For each element, new multiplicity is absolute difference between
  # multiplicity in either multiset.
  #
  # ### Example
  # ```
  # ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}
  # ms2 = Multiset{1, 1, 3, 3, 6}
  # ms3 = Multiset{'a', 1, 1}
  #
  # ms1 ^ ms2 # => Multiset{1, 2, 2, 3, 4, 5, 6}
  # ms1 ^ ms3 # => Multiset{'a', 1, 2, 2, 3, 4, 5}
  # ```
  def ^(other : Enumerable)
    union_merge(other) { |v1, v2| (v1 - v2).abs }
  end

  # removes all elements and returns `self`
  def clear
    @hash.clear
    self
  end

  # returns an `Array` containing unique elements from the multiset
  def uniq
    @hash.keys
  end

  # scales the multiplicity of all elements and returns `self`
  #
  # ```
  # Multiset{1, 2, 2} * 2 # => Multiset{1, 1, 2, 2, 2, 2}
  # ```
  def *(sf)
    raise ArgumentError.new("negative argument") if sf < 0
    sf == 0 ? clear : @hash.merge!(@hash) { |_, v| sf * v }
    self
  end

  # returns `true` if the multiset has any element in common with `other`
  def intersects?(other : Multiset)
    if @hash.size < other.@hash.size
      any? { |o| other.includes?(o) }
    else
      other.any? { |o| includes?(o) }
    end
  end

  # returns `true` if the multiset is a superset of given multiset
  #
  # ### Example
  # ```
  # Mutiset{1, 2, 3}.superset? Multiset{1, 2} # => true
  # Mutiset{1, 1, 2}.superset? Multiset{1, 2} # => true
  # Mutiset{1, 2}.superset? Multiset{1, 2}    # => true
  # ```
  def superset?(other : Multiset)
    return false if size < other.size
    other.all? { |o| multiplicity(o) >= other.multiplicity(o) }
  end

  # returns `true` if the multiset is a proper superset of given multiset
  #
  # ### Example
  # ```
  # Mutiset{1, 2, 3}.proper_superset? Multiset{1, 2} # => true
  # Mutiset{1, 1, 2}.proper_superset? Multiset{1, 2} # => true
  # Mutiset{1, 2}.proper_superset? Multiset{1, 2}    # => false
  # ```
  def proper_superset?(other : Multiset)
    return false if size <= other.size
    other.all? { |o| multiplicity(o) >= other.multiplicity(o) }
  end

  # returns `true` if the multiset is a subset of given multiset
  #
  # ### Example
  # ```
  # Mutiset{1, 2}.subset? Multiset{1, 2, 3} # => true
  # Mutiset{1, 2}.subset? Multiset{1, 1, 2} # => true
  # Mutiset{1, 2}.subset? Multiset{1, 2}    # => true
  # ```
  def subset?(other : Multiset)
    return false if size > other.size
    all? { |o| multiplicity(o) <= other.multiplicity(o) }
  end

  # returns `true` if the multiset is a proper subset of given multiset
  #
  # ### Example
  # ```
  # Mutiset{1, 2}.proper_subset? Multiset{1, 2, 3} # => true
  # Mutiset{1, 2}.proper_subset? Multiset{1, 1, 2} # => true
  # Mutiset{1, 2}.proper_subset? Multiset{1, 2}    # => false
  # ```
  def proper_subset?(other : Multiset)
    return false if size >= other.size
    all? { |o| multiplicity(o) <= other.multiplicity(o) }
  end

  # returns a `String` representation of the multiset
  def to_s(io)
    io << "Multiset{"
    join ", ", io, &.inspect(io)
    io << "}"
  end

  # see `#to_s`
  def inspect(io)
    to_s(io)
  end

  # :nodoc:
  def hash
    @hash.hash
  end

  # :nodoc:
  def object_id
    @hash.object_id
  end

  # :nodoc:
  def same?(other : Multiset)
    @hash.same?(other.@hash)
  end

  # :nodoc:
  private def cast_merge(other : Multiset(U))
    Multiset(T | U).new.tap { |ms| ms.@hash.merge!(other.@hash) }
  end

  # :nodoc:
  private def cast_merge(other : Enumerable(U))
    Multiset(T | U).new.merge(other)
  end

  # :nodoc:
  private def union_merge(other : Enumerable(U), &block : Int32, Int32 -> Int32)
    ms = cast_merge(other)
    oh = ms.@hash
    @hash.each do |elem, m|
      count = yield(oh[elem], m)
      if count > 0
        oh[elem] = count
      else
        oh.delete(elem)
      end
    end
    ms
  end

  # :nodoc:
  private class MultiEntryIterator(I, T)
    include Iterator(T)

    @val : T | Stop
    @count : Int32

    def initialize(@iterator : I)
      @val, @count = next_tuple
    end

    def next
      value = @val
      return value if value.is_a?(Stop)

      if (@count -= 1) <= 0
        @val, @count = next_tuple
      end
      value
    end

    def rewind
      @iterator.rewind
      @val, @count = next_tuple
      self
    end

    protected def next_tuple : Tuple(T | Stop, Int32)
      if (value = @iterator.next).is_a?(Stop)
        {Iterator.stop, 0}
      else
        value
      end
    end
  end
end
