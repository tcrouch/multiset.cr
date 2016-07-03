require "./spec_helper"

describe "Multiset" do
  describe "empty set" do
    it "has size 0" do
      Multiset(Nil).new.size.should eq(0)
    end

    it "is empty" do
      Multiset(Nil).new.empty?.should be_true
    end

    it "returns multiplicity of 0 for an object" do
      Multiset(Nil).new.multiplicity(nil).should eq(0)
    end
  end

  describe "#new" do
    it "returns a new multiset with elements from a given array" do
      ms = Multiset.new([2, 4, 6, 4])
      ms.size.should eq(4)
      ms.to_a.sort.should eq([2, 4, 4, 6])
    end

    it "returns a new multiset with elements from a given tuple" do
      ms = Multiset.new({1, "foo", 'x'})
      ms.size.should eq(3)
      ms.includes?(1).should be_true
      ms.includes?("foo").should be_true
      ms.includes?('x').should be_true
    end
  end

  describe "#add" do
    it "returns self" do
      set = Multiset(Int32).new
      set.add(1).should eq(set)
    end

    it "includes a given object" do
      set = Multiset(Int32).new
      set.add 1
      set.includes?(1).should be_true
    end

    it "increments multiset size" do
      set = Multiset(Int32).new
      set.size.should eq 0
      set.add 1
      set.size.should eq 1
      set.add 1
      set.size.should eq 2
    end

    it "increments multiset size by a given count" do
      set = Multiset(Int32).new
      set.size.should eq 0
      set.add(1, 2)
      set.size.should eq(2)
    end

    it "adds nothing when given a count of 0" do
      set = Multiset(Int32).new
      set.add(1, 0)
      set.includes?(1).should be_false
    end

    it "raises argument error when given a count less than 0" do
      set = Multiset{1, 2, 3}
      expect_raises(ArgumentError) { set.add(1, -1) }
    end
  end

  describe "#includes?" do
    it "returns false for an object not in the multiset" do
      ms = Multiset{1, 2, 3}
      ms.includes?(4).should be_false
    end

    it "returns true for an object in the multiset" do
      ms = Multiset{1, 2, 3}
      ms.includes?(2).should be_true
    end

    it "returns false for an object of a different type" do
      ms = Multiset{1, 2, 3}
      ms.includes?('a').should be_false
    end
  end

  describe "#delete" do
    it "returns self" do
      set = Multiset{1, 2, 3}
      set.delete(2).should eq(set)
    end

    it "deletes a given object when only one is present" do
      set = Multiset{1, 2, 3}
      set.delete 2
      set.includes?(2).should be_false
    end

    it "decrements size" do
      set = Multiset{1, 2, 3}
      set.size.should eq 3
      set.delete 2
      set.size.should eq 2
    end

    it "decrements multiplicity of given object when more than one is present" do
      set = Multiset{1, 1, 2}
      set.multiplicity(1).should eq 2
      set.delete(1)
      set.multiplicity(1).should eq 1
    end

    it "decrements multiplicity of a given object by count" do
      set = Multiset{1, 1, 1, 2}
      set.multiplicity(1).should eq 3
      set.delete(1, 2)
      set.multiplicity(1).should eq 1
    end

    it "does not reduce an object's multiplicity below 0" do
      ms = Multiset{1, 2, 3}
      ms.delete(2)
      ms.delete(2)
      ms.delete(2)
      ms.multiplicity(2).should eq 0
    end

    it "raises argument error when given a count less than 0" do
      set = Multiset{1, 2, 3}
      expect_raises(ArgumentError) { set.delete(1, -1) }
    end
  end

  describe "#multiplicity" do
    it "returns 0 for an object not included" do
      ms = Multiset{1, 2, 3}
      ms.multiplicity(9).should eq 0
    end

    it "returns 0 for an object of a different type" do
      ms = Multiset{1, 2, 3}
      ms.multiplicity('a').should eq 0
    end

    it "returns 1 for an object present once" do
      ms = Multiset{1, 2, 3}
      ms.multiplicity(1).should eq 1
    end

    it "returns 3 of an object present 3 times" do
      ms = Multiset{1, 2, 3, 1, 1}
      ms.multiplicity(1).should eq 3
    end
  end

  describe "#dup" do
    it "returns an equal Multiset" do
      ms1 = Multiset{1, 2, 3, 2, 4, 6}
      ms2 = ms1.dup
      (ms1 == ms2).should be_true
    end

    it "returns an independent copy" do
      ms1 = Multiset{1, 2, 3}
      ms2 = ms1.dup
      ms1 << 4
      ms2 << 5

      ms1.should eq Multiset{1, 2, 3, 4}
      ms2.should eq Multiset{1, 2, 3, 5}
    end
  end

  describe "#==" do
    it "returns true given the same object" do
      ms1 = Multiset{1, 2, 3}
      (ms1 == ms1).should be_true
    end
    context "with a Multiset" do
      it "returns true when elements are the same and unique" do
        ms1 = Multiset{1, 2, 3}
        ms2 = Multiset{3, 2, 1}
        (ms1 == ms2).should be_true
      end

      it "returns true when elements and multiplicities are the same" do
        ms1 = Multiset{1, 2, 2, 2, 3, 1}
        ms2 = Multiset{1, 2, 2, 2, 3, 1}
        (ms1 == ms2).should be_true
      end

      it "returns false given a superset" do
        ms1 = Multiset{1, 2, 3}
        ms2 = Multiset{1, 2, 3, 4}
        (ms1 == ms2).should be_false
      end

      it "returns false given a superset with equal set of unique elements" do
        ms1 = Multiset{1, 2, 3}
        ms2 = Multiset{1, 2, 3, 3}
        (ms1 == ms2).should be_false
      end

      it "returns false given a subset" do
        ms1 = Multiset{1, 2, 3}
        ms2 = Multiset{1, 2}
        (ms1 == ms2).should be_false
      end

      it "returns false given a subset with equal set of unique elements" do
        ms1 = Multiset{1, 2, 3, 3}
        ms2 = Multiset{1, 2, 3}
        (ms1 == ms2).should be_false
      end
    end

    context "with a Set" do
      it "returns true when the same elements are present" do
        ms = Multiset{1, 2, 3}
        s = Set{1, 2, 3}
        (ms == s).should be_true
      end

      it "returns false given a superset" do
        ms = Multiset{1, 2, 3}
        s = Set{1, 2, 3, 4}
        (ms == s).should be_false
      end

      it "returns false given a subset" do
        ms = Multiset{1, 2, 3, 4}
        s = Set{1, 2, 3}
        (ms == s).should be_false
      end

      it "returns false when elements are the same, but multiplicities are not" do
        ms = Multiset{1, 2, 3, 1}
        s = Set{1, 2, 3}
        (ms == s).should be_false
      end
    end
  end

  describe "#merge" do
    it "returns self" do
      ms = Multiset{1, 2, 3}
      ms.merge([3, 4]).should eq(Multiset{1, 2, 3, 3, 4})
    end

    it "adds all elements from other Multiset" do
      ms = Multiset{1, 4, 8}
      ms.merge Multiset{1, 8, 9, 9, 10}
      ms.should eq(Multiset{1, 1, 4, 8, 8, 9, 9, 10})
    end

    it "adds all elements from other Array" do
      ms = Multiset{1, 4, 8}
      ms.merge [1, 9, 10]
      ms.should eq(Multiset{1, 1, 4, 8, 9, 10})
    end

    it "adds elements from an iterator" do
      ms = Multiset{[1, 2]}
      ms.merge([2, 3, 4, 5].each_cons(2))
      ms.size.should eq(4)
      ms.includes?([1, 2]).should be_true
      ms.includes?([2, 3]).should be_true
      ms.includes?([3, 4]).should be_true
      ms.includes?([4, 5]).should be_true
    end
  end

  describe "#+" do
    it "returns a new object" do
      ms = Multiset{1, 4, 8}
      (ms + [1, 9, 10]).should_not eq ms
    end
  end

  describe "#to_a" do
    it "returns an Array" do
      Multiset{1, 2, 2, 3}.to_a.should be_a Array(Int32)
    end

    it "returns an Array containing all elements" do
      Multiset{1, 2, 2, 3}.to_a.should eq([1, 2, 2, 3])
    end
  end

  describe "#subtract" do
    it "removes all elements in a given multiset" do
      ms1 = Multiset{1, 2, 3, 4, 5, 6}
      ms2 = Multiset{2, 4, 6}
      ms1.subtract ms2
      ms1.should eq(Multiset{1, 3, 5})
    end

    it "subtracts multiplicity correctly" do
      ms1 = Multiset{1, 2, 2, 3, 4, 5, 4, 5}
      ms2 = Multiset{2, 4, 2, 3}
      ms1.subtract ms2
      ms1.should eq(Multiset{1, 4, 5, 5})
    end

    it "removes elements in a given Set" do
      ms1 = Multiset{1, 2, 3, 3}
      ms1.subtract Set{2, 3}
      ms1.should eq(Multiset{1, 3})
    end

    it "removes elements in a given Array" do
      ms1 = Multiset{1, 2, 2, 3, 4, 5, 4, 5}
      ms1.subtract [2, 4, 2, 3]
      ms1.should eq(Multiset{1, 4, 5, 5})
    end

    it "does nothing with elements that are not present" do
      ms1 = Multiset{1, 2, 3}
      ms2 = Multiset{2, 4, 6}
      ms1.subtract ms2
      ms1.should eq(Multiset{1, 3})
    end

    it "returns self" do
      ms = Multiset{1, 2, 2, 3}
      ms.subtract([1, 3]).should eq ms
    end
  end

  describe "#-" do
    it "returns a new object" do
      ms = Multiset{1, 2, 2, 3}
      (ms - [1, 3]).should_not eq ms
    end
  end

  describe "#each" do
    context "with no block given" do
      it "iterates over unique elements" do
        iter = Multiset{1, 2, 3}.each
        iter.next.should eq(1)
        iter.next.should eq(2)
        iter.next.should eq(3)
        iter.next.should be_a(Iterator::Stop)

        iter.rewind
        iter.next.should eq(1)
      end

      it "iterates over duplicate elements" do
        iter = Multiset{1, 2, 3, 2, 1, 1}.each
        iter.next.should eq(1)
        iter.next.should eq(1)
        iter.next.should eq(1)
        iter.next.should eq(2)
        iter.next.should eq(2)
        iter.next.should eq(3)
        iter.next.should be_a(Iterator::Stop)

        iter.rewind
        iter.next.should eq(1)
      end
    end

    context "with block" do
      it "yields each element" do
        ms = Multiset{1, 2, 2, 3}
        elems = [] of Int32
        ms.each { |e| elems << e }
        elems.should eq [1, 2, 2, 3]
      end
    end
  end

  describe "#&" do
    it "performs multiset intersection" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 3, 3, 8}

      (ms1 & ms2).should eq Multiset{1, 1, 3}
    end

    it "returns a new object" do
      ms1 = Multiset{1, 2, 2, 3}
      ms2 = Multiset{1, 1, 3}

      (ms1 & ms2).should_not eq ms1
      (ms1 & ms2).should_not eq ms2
    end

    it "returns an empty multiset given a disjoint multiset" do
      ms1 = Multiset{1, 2, 2}
      ms2 = Multiset{3, 3, 4}
      (ms1 & ms2).empty?.should be_true
    end

    it "performs intersection given a multiset with type as superset of self" do
      ms1 = Multiset{1, 2}
      ms2 = Multiset{1, 2, 3, 'a', 'b'}
      (ms1 & ms2).should eq Multiset{1, 2}
    end

    it "performs intersection given a multiset with type as subset of self" do
      ms1 = Multiset{1, 2, 'a', 'b'}
      ms2 = Multiset{1, 2}
      (ms1 & ms2).should eq Multiset{1, 2}
    end

    it "returns a empty multiset given a disjoint multiset of a different type" do
      ms1 = Multiset{1, 2}
      ms2 = Multiset{'a', 'b'}
      (ms1 & ms2).empty?.should be_true
    end

    context "with Set" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        s = Set{1, 3, 8}
        (ms & s).should eq Multiset{1, 3}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = Set{1, 2, 8}
        (ms & a).should eq Multiset{1, 2}
      end

      it "performs multiset intersection given elements of a different type" do
        ms = Multiset{1, 2, 3}
        a = Set{'a', 2, 8}
        (ms & a).should eq Multiset{2}
      end
    end

    context "with array" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        a = [1, 3, 8]
        (ms & a).should eq Multiset{1, 3}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 2, 2, 2, 8]
        (ms & a).should eq Multiset{1, 2}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 'a', 2, 2, 8]
        (ms & a).should eq Multiset{1, 2}
      end
    end
  end

  describe "#|" do
    it "performs multiset union" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 3, 3, 8}
      (ms1 | ms2).should eq Multiset{1, 1, 1, 3, 3, 8, 2, 2, 4, 5, 6, 7}
    end

    it "returns a new object" do
      ms1 = Multiset{1, 2, 2, 3}
      ms2 = Multiset{1, 1, 3}

      (ms1 | ms2).should_not eq ms1
      (ms1 | ms2).should_not eq ms2
    end

    it "performs union given a multiset with type as superset of self" do
      ms1 = Multiset{1, 2, 2}
      ms2 = Multiset{1, 2, 3, 'a', 'b'}
      (ms1 | ms2).should eq Multiset{1, 2, 2, 3, 'a', 'b'}
    end

    it "performs union given a multiset with type as subset of self" do
      ms1 = Multiset{1, 2, 'a', 'b'}
      ms2 = Multiset{1, 2, 2}
      (ms1 | ms2).should eq Multiset{1, 2, 2, 'a', 'b'}
    end

    it "returns union given a disjoint multiset of a different type" do
      ms1 = Multiset{1, 2}
      ms2 = Multiset{'a', 'b'}
      (ms1 | ms2).should eq Multiset{1, 2, 'a', 'b'}
    end

    it "performs multiset union given a set" do
      ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      s = Set{1, 3, 8}
      (ms | s).should eq Multiset{1, 1, 1, 3, 8, 2, 2, 4, 5, 6, 7}
    end

    context "with Set" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        s = Set{1, 3, 8}
        (ms | s).should eq Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = Set{1, 2, 8}
        (ms | a).should eq Multiset{1, 2, 3, 8}
      end

      it "performs multiset intersection given elements of a different type" do
        ms = Multiset{1, 2, 3}
        a = Set{'a', 2, 8}
        (ms | a).should eq Multiset{2, 'a', 8, 1, 3}
      end
    end

    context "with array" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        a = [1, 3, 8]
        (ms | a).should eq Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 2, 2, 2, 8]
        (ms | a).should eq Multiset{1, 1, 2, 2, 2, 3, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 'a', 2, 2, 8]
        (ms | a).should eq Multiset{1, 1, 2, 2, 'a', 3, 8}
      end
    end
  end

  describe "#^" do
    it "performs symmetric difference given a multiset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 3, 3, 8}
      (ms1 ^ ms2).should eq Multiset{1, 2, 2, 3, 4, 5, 6, 7, 8}
    end

    it "returns a new object" do
      ms1 = Multiset{1, 2, 2, 3}
      ms2 = Multiset{1, 1, 3}

      (ms1 ^ ms2).should_not eq ms1
      (ms1 ^ ms2).should_not eq ms2
    end

    it "returns an empty multiset given two equal multisets" do
      ms1 = Multiset{1, 2, 2, 3}
      ms2 = Multiset{3, 2, 2, 1}
      (ms1 ^ ms2).empty?.should be_true
    end

    it "performs symmetric difference given a multiset with type as superset of self" do
      ms1 = Multiset{1, 2}
      ms2 = Multiset{1, 2, 3, 'a', 'b'}
      (ms1 ^ ms2).should eq Multiset{3, 'a', 'b'}
    end

    it "performs symmetric difference given a multiset with type as subset of self" do
      ms1 = Multiset{1, 2, 'a', 'b'}
      ms2 = Multiset{1, 2}
      (ms1 ^ ms2).should eq Multiset{'a', 'b'}
    end

    it "returns symmetric difference given a disjoint multiset of a different type" do
      ms1 = Multiset{1, 2}
      ms2 = Multiset{'a', 'b'}
      (ms1 ^ ms2).should eq Multiset{1, 2, 'a', 'b'}
    end

    it "performs symmetric difference given a Set" do
      ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      s = Set{1, 3, 8}
      (ms ^ s).should eq Multiset{1, 1, 2, 2, 4, 5, 6, 7, 8}
    end

    context "with Set" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        s = Set{1, 3, 8}
        (ms ^ s).should eq Multiset{1, 1, 2, 2, 4, 5, 6, 7, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = Set{1, 2, 8}
        (ms ^ a).should eq Multiset{3, 8}
      end

      it "performs multiset intersection given elements of a different type" do
        ms = Multiset{1, 2, 3}
        a = Set{'a', 2, 8}
        (ms ^ a).should eq Multiset{'a', 1, 3, 8}
      end
    end

    context "with array" do
      it "performs multiset intersection given a subset of elements" do
        ms = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
        a = [1, 3, 8]
        (ms ^ a).should eq Multiset{1, 1, 2, 2, 4, 5, 6, 7, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 2, 2, 2, 8]
        (ms ^ a).should eq Multiset{1, 2, 2, 3, 8}
      end

      it "performs multiset intersection given a superset of elements" do
        ms = Multiset{1, 2, 3}
        a = [1, 1, 'a', 2, 2, 8]
        (ms ^ a).should eq Multiset{1, 2, 'a', 3, 8}
      end
    end
  end

  describe "#clear" do
    it "empties the Multiset" do
      ms1 = Multiset{1, 2, 2, 3}
      (ms1.clear).empty?.should be_true
    end

    it "returns self" do
      ms1 = Multiset{1, 2, 2, 3}
      (ms1.clear).should eq ms1
    end
  end

  describe "#*" do
    it "multiplies all multiplicities by sf" do
      ms1 = Multiset{1, 1, 3}
      ms2 = Multiset{1, 1, 1, 1, 3, 3}
      (ms1 * 2).should eq ms2
    end

    it "clears the Multiset when given 0" do
      ms1 = Multiset{1, 1, 3}
      (ms1 * 0).empty?.should be_true
    end

    it "returns self" do
      ms1 = Multiset{1, 1, 3}
      (ms1 * 2).should eq ms1
    end
  end

  describe "intersects?" do
    it "returns true when an element is common to both" do
      ms1 = Multiset{1, 2, 3}
      ms2 = Multiset{2, 4, 6}
      ms1.intersects?(ms2).should be_true
    end

    it "returns false when disjoint" do
      ms1 = Multiset{1, 2, 3}
      ms2 = Multiset{4, 5, 6}
      ms1.intersects?(ms2).should be_false
    end
  end

  describe "#superset?" do
    it "returns true given an equal multiset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = ms1.dup
      ms1.superset?(ms2).should be_true
    end

    it "returns true given a subset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 2, 2, 3, 4, 6, 7}
      ms1.superset?(ms2).should be_true
    end

    it "returns false given a superset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      ms1.superset?(ms2).should be_false
    end
  end

  describe "proper_superset?" do
    it "returns false given an equal multiset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = ms1.dup
      ms1.proper_superset?(ms2).should be_false
    end

    it "returns true given a subset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 2, 2, 3, 4, 6, 7}
      ms1.proper_superset?(ms2).should be_true
    end

    it "returns false given a superset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      ms1.proper_superset?(ms2).should be_false
    end
  end

  describe "#subset?" do
    it "returns true given an equal multiset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = ms1.dup
      ms1.subset?(ms2).should be_true
    end

    it "returns false given a subset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 2, 2, 3, 4, 6, 7}
      ms1.subset?(ms2).should be_false
    end

    it "returns true given a superset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      ms1.subset?(ms2).should be_true
    end
  end

  describe "#proper_subset?" do
    it "returns false given an equal multiset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = ms1.dup
      ms1.proper_subset?(ms2).should be_false
    end

    it "returns false given a subset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 2, 2, 3, 4, 6, 7}
      ms1.proper_subset?(ms2).should be_false
    end

    it "returns true given a superset" do
      ms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7}
      ms2 = Multiset{1, 1, 1, 2, 2, 3, 4, 5, 6, 7, 8}
      ms1.proper_subset?(ms2).should be_true
    end
  end
end
