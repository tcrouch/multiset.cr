# A `Multiset` (or **bag**) is a collection of unordered elements that is
# similar to a set, but allows duplicate values.
#
# Multiset uses `Hash` as storage.
#
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
  include Iterable(T)

  VERSION = {{ `shards version #{__DIR__}`.chomp.stringify }}

  # Create a new empty `Multiset`.
  #
  # If an `initial_capacity` is given, it will set the initial capacity
  # of the internal `Hash`.
  #
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

  protected def initialize(*, using_hash @hash : Hash(T, Int32))
  end

  # Creates a new multiset from the elements in **enumerable**.
  #
  # ```
  # Multiset.new([1, 2, 3, 1]) # => Multiset{1, 1, 2, 3}
  # ```
  def self.new(enumerable : Enumerable(T))
    Multiset(T).new.merge(enumerable)
  end

  # Returns the number of elements in the multiset.
  #
  # ```
  # Multiset{1, 2, 3}.size       # => 3
  # Multiset{1, 1, 1, 2, 3}.size # => 5
  # ```
  def size
    @hash.values.sum
  end

  # Returns `true` if the multiset has no elements.
  #
  # ```
  # Multiset(Int32).new.empty? # => true
  # Multiset{1, 2, 3}.empty?   # => false
  # ```
  def empty?
    @hash.empty?
  end

  # Returns `true` if **object** is an element in the multiset.
  #
  # ```
  # Multiset{1, 2, 3}.includes?(3)   # => true
  # Multiset{1, 2, 3}.includes?(4)   # => false
  # Multiset{1, 2, 3}.includes?('a') # => false
  # ```
  def includes?(object)
    @hash.has_key?(object)
  end

  # Yields each element of the multiset, and returns `self`.
  def each
    @hash.each do |elem, count|
      count.times { yield elem }
    end
    self
  end

  # Returns an iterator for each element of the multiset.
  def each
    MultiEntryIterator(typeof(@hash.each), T).new(@hash.each)
  end

  # Increments multiplicity of **object** by **count** and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms.add(4, 2) # => Multiset{1, 2, 3, 4, 4}
  # ```
  def add(object : T, count : Int32)
    raise ArgumentError.new("attempt to add negative count") if count < 0
    @hash[object] += count if count > 0
    self
  end

  # Increments multiplicity of **object** and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms.add(4) # => Multiset{1, 2, 3, 4}
  # ```
  def add(object : T)
    @hash[object] += 1
    self
  end

  # Alias for `add`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms << 4 # => Multiset{1, 2, 3, 4}
  # ```
  def <<(object : T)
    add object
  end

  # Adds each element of **other** and returns `self`.
  #
  # ```
  # ms = Multiset{3, 4, 5}
  # Multiset{1, 2, 3}.merge(ms) # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def merge(other : Multiset(T))
    other.@hash.each { |elem, count| @hash[elem] += count }
    self
  end

  # Adds each element of **elems** and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms.merge([3, 4, 5]) # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def merge(elems)
    elems.each { |elem| add(elem) }
    self
  end

  # Returns a new multiset containing the elements from both `self` and
  # **other**.
  #
  # ```
  # Multiset{1, 2, 3} + Multiset{3, 4, 5} # => Multiset{1, 2, 3, 3, 4, 5}
  # Multiset{1, 2, 3} + [3, 4, 5]         # => Multiset{1, 2, 3, 3, 4, 5}
  # ```
  def +(other)
    dup.merge(other)
  end

  # Decrements multiplicity of **object** and returns `self`.
  #
  # ```
  # Multiset{1, 2, 3}.delete(2) # => Multiset{1, 3}
  # Multiset{4, 4, 5}.delete(4) # => Multiset{4, 5}
  # ```
  def delete(object)
    @hash.delete(object) if (@hash[object] -= 1) < 1
    self
  end

  # Decrements multiplicity of **object** by **count** and returns `self`.
  #
  # ```
  # Multiset{1, 2, 3}.delete(2, 1) # => Multiset{1, 3}
  # Multiset{4, 4, 5}.delete(4, 2) # => Multiset{5}
  # ```
  def delete(object, count : Int32)
    raise ArgumentError.new("attempt to add negative count") if count < 0
    @hash.delete(object) if (@hash[object] -= count) < 1
    self
  end

  # Returns count of **object** in the multiset.
  #
  # ```
  # ms = Multiset{1, 2, 2}
  # ms.multiplicity(1) # => 1
  # ms.multiplicity(2) # => 2
  # ```
  def multiplicity(object : T)
    @hash[object]
  end

  # Returns `0`.
  def multiplicity(object : U) forall U
    0
  end

  # Returns a new `Multiset` with the same elements.
  def dup
    Multiset(T).new(using_hash: @hash.dup)
  end

  # Returns `true` if both multisets contain the same elements.
  def ==(other : Multiset)
    same?(other) || @hash == other.@hash
  end

  # Returns `true` if both sets contain the same elements.
  def ==(other : Set)
    size == other.size && other.all? { |o| includes?(o) }
  end

  # Removes all elements in **other** and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms.subtract(Multiset{1, 3}) # => Multiset{2}
  # ```
  def subtract(other : Multiset)
    other.@hash.each { |elem, count| delete(elem, count) }
    self
  end

  # Removes all elements in **other** and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 3}
  # ms.subtract([1, 3]) # => Multiset{2}
  # ```
  def subtract(other : Enumerable)
    other.each { |e| delete(e) }
    self
  end

  # Returns a new multiset with all elements in **other** removed.
  #
  # ```
  # Multiset{1, 2, 3} - [1, 3] # => Multiset{2}
  # ```
  def -(other : Enumerable)
    dup.subtract(other)
  end

  # Returns a new multiset by performing multiset intersection with **other**.
  #
  # For each element, new multiplicity is minimum multiplicity in either
  # multiset
  #
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

  # Returns a new multiset by performing mutiset union with **other**.
  #
  # For each element, new multiplicity is maximum multiplicity in either
  # multiset.
  #
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

  # Returns a new multiset by performing symmetric difference with **other**.
  #
  # For each element, new multiplicity is absolute difference between
  # multiplicity in either multiset.
  #
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

  # Removes all elements and returns `self`.
  #
  # ```
  # ms = Multiset{1, 2, 2}
  # ms.clear
  # ms.empty? # => true
  # ```
  def clear
    @hash.clear
    self
  end

  # Returns an `Array` containing unique elements from the multiset.
  def uniq
    @hash.keys
  end

  # Scales the multiplicity of all elements by **sf** and returns `self`.
  #
  # ```
  # Multiset{1, 2, 2} * 2 # => Multiset{1, 1, 2, 2, 2, 2}
  # ```
  def *(sf : Int32)
    raise ArgumentError.new("negative argument") if sf < 0
    sf == 0 ? clear : @hash.merge!(@hash) { |_, v| sf * v }
    self
  end

  # Returns `true` if the multiset has any element in common with **other**.
  def intersects?(other : Multiset)
    if @hash.size < other.@hash.size
      any? { |o| other.includes?(o) }
    else
      other.any? { |o| includes?(o) }
    end
  end

  # Returns `true` if the multiset is a superset of **other**.
  #
  # ```
  # Mutiset{1, 2, 3}.superset? Multiset{1, 2} # => true
  # Mutiset{1, 1, 2}.superset? Multiset{1, 2} # => true
  # Mutiset{1, 2}.superset? Multiset{1, 2}    # => true
  # ```
  def superset?(other : Multiset)
    return false if size < other.size
    other.all? { |o| multiplicity(o) >= other.multiplicity(o) }
  end

  # Returns `true` if the multiset is a proper superset of **other**.
  #
  # ```
  # Mutiset{1, 2, 3}.proper_superset? Multiset{1, 2} # => true
  # Mutiset{1, 1, 2}.proper_superset? Multiset{1, 2} # => true
  # Mutiset{1, 2}.proper_superset? Multiset{1, 2}    # => false
  # ```
  def proper_superset?(other : Multiset)
    return false if size <= other.size
    other.all? { |o| multiplicity(o) >= other.multiplicity(o) }
  end

  # Returns `true` if the multiset is a subset of **other**.
  #
  # ```
  # Mutiset{1, 2}.subset? Multiset{1, 2, 3} # => true
  # Mutiset{1, 2}.subset? Multiset{1, 1, 2} # => true
  # Mutiset{1, 2}.subset? Multiset{1, 2}    # => true
  # ```
  def subset?(other : Multiset)
    return false if size > other.size
    all? { |o| multiplicity(o) <= other.multiplicity(o) }
  end

  # Returns `true` if the multiset is a proper subset of **other**.
  #
  # ```
  # Mutiset{1, 2}.proper_subset? Multiset{1, 2, 3} # => true
  # Mutiset{1, 2}.proper_subset? Multiset{1, 1, 2} # => true
  # Mutiset{1, 2}.proper_subset? Multiset{1, 2}    # => false
  # ```
  def proper_subset?(other : Multiset)
    return false if size >= other.size
    all? { |o| multiplicity(o) <= other.multiplicity(o) }
  end

  # Writes a string representation of the multiset to **io**.
  def to_s(io : IO) : Nil
    io << "Multiset{"
    join io, ", ", &.inspect(io)
    io << "}"
  end

  # Alias of `#to_s`.
  def inspect(io : IO) : Nil
    to_s(io)
  end

  # See `Object#hash(hasher)`
  def_hash @hash

  # :nodoc:
  def object_id
    @hash.object_id
  end

  # :nodoc:
  def same?(other : Multiset)
    @hash.same?(other.@hash)
  end

  # :nodoc:
  private def cast_merge(other : Multiset(U)) forall U
    Multiset(T | U).new.tap { |ms| ms.@hash.merge!(other.@hash) }
  end

  # :nodoc:
  private def cast_merge(other : Enumerable(U)) forall U
    Multiset(T | U).new.merge(other)
  end

  # :nodoc:
  private def union_merge(other : Enumerable(U), &block : Int32, Int32 -> Int32) forall U
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

    protected def next_tuple : Tuple(T | Stop, Int32)
      if (value = @iterator.next).is_a?(Stop)
        {Iterator.stop, 0}
      else
        value
      end
    end
  end
end
