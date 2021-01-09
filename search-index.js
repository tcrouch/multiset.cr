crystal_doc_search_index_callback({"repository_name":"multiset","body":"# multiset\n\n[![Travis (.com)](https://img.shields.io/travis/com/tcrouch/multiset.cr)](https://www.travis-ci.com/github/tcrouch/multiset.cr)\n[![Documentation](https://img.shields.io/badge/api-docs-informational)](https://tcrouch.github.io/multiset.cr)\n\nA multiset (bag) implementation in Crystal.\n\n## Installation\n\nAdd this to your application's `shard.yml`:\n\n```yaml\ndependencies:\n  multiset:\n    github: tcrouch/multiset.cr\n```\n\n## Usage\n\n```crystal\nrequire \"multiset\"\n\nms1 = Multiset{1, 1}\nms1 << 2                          # => Multiset{1, 1, 2}\nms1.merge [3, 4]                  # => Multiset{1, 1, 2, 3, 4}\nms2 = Multiset.new [2, 3, 4]\nms2.subset?(ms1)                  # => true\nms1 & ms2                         # => Multiset{2, 3, 4}\n```\n\n## Development\n\n`crystal spec`\n\n## Contributing\n\n1. [Fork it](https://github.com/tcrouch/multiset.cr/fork)\n2. Create your feature branch (`git checkout -b my-new-feature`)\n3. Commit your changes (`git commit -am 'Add some feature'`)\n4. Push to the branch (`git push origin my-new-feature`)\n5. Create a new Pull Request\n\n## Contributors\n\n- [[tcrouch]](https://github.com/tcrouch) Tom Crouch - creator, maintainer\n","program":{"html_id":"multiset/toplevel","path":"toplevel.html","kind":"module","full_name":"Top Level Namespace","name":"Top Level Namespace","abstract":false,"superclass":null,"ancestors":[],"locations":[],"repository_name":"multiset","program":true,"enum":false,"alias":false,"aliased":"","const":false,"constants":[],"included_modules":[],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":null,"summary":null,"class_methods":[],"constructors":[],"instance_methods":[],"macros":[],"types":[{"html_id":"multiset/Multiset","path":"Multiset.html","kind":"struct","full_name":"Multiset(T)","name":"Multiset","abstract":false,"superclass":{"html_id":"multiset/Struct","kind":"struct","full_name":"Struct","name":"Struct"},"ancestors":[{"html_id":"multiset/Iterable","kind":"module","full_name":"Iterable","name":"Iterable"},{"html_id":"multiset/Enumerable","kind":"module","full_name":"Enumerable","name":"Enumerable"},{"html_id":"multiset/Struct","kind":"struct","full_name":"Struct","name":"Struct"},{"html_id":"multiset/Value","kind":"struct","full_name":"Value","name":"Value"},{"html_id":"multiset/Object","kind":"class","full_name":"Object","name":"Object"}],"locations":[],"repository_name":"multiset","program":false,"enum":false,"alias":false,"aliased":"","const":false,"constants":[{"id":"VERSION","name":"VERSION","value":"\"0.3.0\"","doc":null,"summary":null}],"included_modules":[{"html_id":"multiset/Enumerable","kind":"module","full_name":"Enumerable","name":"Enumerable"},{"html_id":"multiset/Iterable","kind":"module","full_name":"Iterable","name":"Iterable"}],"extended_modules":[],"subclasses":[],"including_types":[],"namespace":null,"doc":"A `Multiset` (or **bag**) is a collection of unordered elements that is\nsimilar to a set, but allows duplicate values.\n\nMultiset uses `Hash` as storage.\n\n```\nms1 = Multiset.new [1, 2]\nms2 = Multiset{2, 1}\nms1 == ms2          # => true\nms1.add(2)          # => Multiset{1, 2, 2}\nms1.merge([2, 6])   # => Multiset{1, 2, 2, 2, 6}\nms1.multiplicity(2) # => 3\nms1.subset? ms2     # => false\nms2.subset? ms1     # => true\n```","summary":"<p>A <code><a href=\"Multiset.html\">Multiset</a></code> (or <strong>bag</strong>) is a collection of unordered elements that is similar to a set, but allows duplicate values.</p>","class_methods":[],"constructors":[{"id":"new(enumerable:Enumerable(T))-class-method","html_id":"new(enumerable:Enumerable(T))-class-method","name":"new","doc":"Creates a new multiset from the elements in **enumerable**.\n\n```\nMultiset.new([1, 2, 3, 1]) # => Multiset{1, 1, 2, 3}\n```","summary":"<p>Creates a new multiset from the elements in <strong>enumerable</strong>.</p>","abstract":false,"args":[{"name":"enumerable","doc":null,"default_value":"","external_name":"enumerable","restriction":"Enumerable(T)"}],"args_string":"(enumerable : Enumerable(T))","source_link":null,"def":{"name":"new","args":[{"name":"enumerable","doc":null,"default_value":"","external_name":"enumerable","restriction":"Enumerable(T)"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"Multiset(T).new.merge(enumerable)"}},{"id":"new(initial_capacity=nil)-class-method","html_id":"new(initial_capacity=nil)-class-method","name":"new","doc":"Create a new empty `Multiset`.\n\nIf an `initial_capacity` is given, it will set the initial capacity\nof the internal `Hash`.\n\n```\nms = Multiset(Int32).new\nms.empty # => true\n```","summary":"<p>Create a new empty <code><a href=\"Multiset.html\">Multiset</a></code>.</p>","abstract":false,"args":[{"name":"initial_capacity","doc":null,"default_value":"nil","external_name":"initial_capacity","restriction":""}],"args_string":"(initial_capacity = <span class=\"n\">nil</span>)","source_link":null,"def":{"name":"new","args":[{"name":"initial_capacity","doc":null,"default_value":"nil","external_name":"initial_capacity","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"_ = Multiset(T).allocate\n_.initialize(initial_capacity)\nif _.responds_to?(:finalize)\n  ::GC.add_finalizer(_)\nend\n_\n"}}],"instance_methods":[{"id":"&(other:Enumerable)-instance-method","html_id":"&(other:Enumerable)-instance-method","name":"&","doc":null,"summary":null,"abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"args_string":"(other : Enumerable)","source_link":null,"def":{"name":"&","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"n = Multiset(T).new\nother.each do |elem|\n  if elem.is_a?(T)\n  else\n    next\n  end\n  count = multiplicity(elem)\n  if count > 0 && (n.multiplicity(elem)) < count\n    n.add(elem)\n  end\nend\nn\n"}},{"id":"&(other:Multiset)-instance-method","html_id":"&(other:Multiset)-instance-method","name":"&","doc":"Returns a new multiset by performing multiset intersection with **other**.\n\nFor each element, new multiplicity is minimum multiplicity in either\nmultiset\n\n```\nms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}\nms2 = Multiset{1, 1, 3, 3, 6}\nms3 = Multiset{'a', 1, 1}\n\nms1 & ms2 # => Multiset{1, 1, 3}\nms1 & ms3 # => Multiset{1, 1}\n```","summary":"<p>Returns a new multiset by performing multiset intersection with <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"&","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"n = Multiset(T).new\n@hash.each do |elem, count|\n  oc = other.multiplicity(elem)\n  n.add(elem, oc < count ? oc : count)\nend\nn\n"}},{"id":"*(sf:Int32)-instance-method","html_id":"*(sf:Int32)-instance-method","name":"*","doc":"Scales the multiplicity of all elements by **sf** and returns `self`.\n\n```\nMultiset{1, 2, 2} * 2 # => Multiset{1, 1, 2, 2, 2, 2}\n```","summary":"<p>Scales the multiplicity of all elements by <strong>sf</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"sf","doc":null,"default_value":"","external_name":"sf","restriction":"Int32"}],"args_string":"(sf : Int32)","source_link":null,"def":{"name":"*","args":[{"name":"sf","doc":null,"default_value":"","external_name":"sf","restriction":"Int32"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if sf < 0\n  raise(ArgumentError.new(\"negative argument\"))\nend\nsf == 0 ? clear : @hash.merge!(@hash) do |_, v|\n  sf * v\nend\nself\n"}},{"id":"+(other)-instance-method","html_id":"+(other)-instance-method","name":"+","doc":"Returns a new multiset containing the elements from both `self` and\n**other**.\n\n```\nMultiset{1, 2, 3} + Multiset{3, 4, 5} # => Multiset{1, 2, 3, 3, 4, 5}\nMultiset{1, 2, 3} + [3, 4, 5]         # => Multiset{1, 2, 3, 3, 4, 5}\n```","summary":"<p>Returns a new multiset containing the elements from both <code>self</code> and <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":""}],"args_string":"(other)","source_link":null,"def":{"name":"+","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"dup.merge(other)"}},{"id":"-(other:Enumerable)-instance-method","html_id":"-(other:Enumerable)-instance-method","name":"-","doc":"Returns a new multiset with all elements in **other** removed.\n\n```\nMultiset{1, 2, 3} - [1, 3] # => Multiset{2}\n```","summary":"<p>Returns a new multiset with all elements in <strong>other</strong> removed.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"args_string":"(other : Enumerable)","source_link":null,"def":{"name":"-","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"dup.subtract(other)"}},{"id":"<<(object:T)-instance-method","html_id":"<<(object:T)-instance-method","name":"<<","doc":"Alias for `add`.\n\n```\nms = Multiset{1, 2, 3}\nms << 4 # => Multiset{1, 2, 3, 4}\n```","summary":"<p>Alias for <code><a href=\"Multiset.html#add(object:T,count:Int32)-instance-method\">#add</a></code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"args_string":"(object : T)","source_link":null,"def":{"name":"<<","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"add(object)"}},{"id":"==(other:Multiset)-instance-method","html_id":"==(other:Multiset)-instance-method","name":"==","doc":"Returns `true` if both multisets contain the same elements.","summary":"<p>Returns <code>true</code> if both multisets contain the same elements.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"==","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(same?(other)) || (@hash == (other.@hash))"}},{"id":"==(other:Set)-instance-method","html_id":"==(other:Set)-instance-method","name":"==","doc":"Returns `true` if both sets contain the same elements.","summary":"<p>Returns <code>true</code> if both sets contain the same elements.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Set"}],"args_string":"(other : Set)","source_link":null,"def":{"name":"==","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Set"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(size == other.size) && other.all? do |o|\n  includes?(o)\nend"}},{"id":"^(other:Enumerable)-instance-method","html_id":"^(other:Enumerable)-instance-method","name":"^","doc":"Returns a new multiset by performing symmetric difference with **other**.\n\nFor each element, new multiplicity is absolute difference between\nmultiplicity in either multiset.\n\n```\nms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}\nms2 = Multiset{1, 1, 3, 3, 6}\nms3 = Multiset{'a', 1, 1}\n\nms1 ^ ms2 # => Multiset{1, 2, 2, 3, 4, 5, 6}\nms1 ^ ms3 # => Multiset{'a', 1, 2, 2, 3, 4, 5}\n```","summary":"<p>Returns a new multiset by performing symmetric difference with <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"args_string":"(other : Enumerable)","source_link":null,"def":{"name":"^","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"union_merge(other) do |v1, v2|\n  (v1 - v2).abs\nend"}},{"id":"add(object:T,count:Int32)-instance-method","html_id":"add(object:T,count:Int32)-instance-method","name":"add","doc":"Increments multiplicity of **object** by **count** and returns `self`.\n\n```\nms = Multiset{1, 2, 3}\nms.add(4, 2) # => Multiset{1, 2, 3, 4, 4}\n```","summary":"<p>Increments multiplicity of <strong>object</strong> by <strong>count</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"},{"name":"count","doc":null,"default_value":"","external_name":"count","restriction":"Int32"}],"args_string":"(object : T, count : Int32)","source_link":null,"def":{"name":"add","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"},{"name":"count","doc":null,"default_value":"","external_name":"count","restriction":"Int32"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if count < 0\n  raise(ArgumentError.new(\"attempt to add negative count\"))\nend\nif count > 0\n  __temp_24 = object\n  @hash[__temp_24] = @hash[__temp_24] + count\nend\nself\n"}},{"id":"add(object:T)-instance-method","html_id":"add(object:T)-instance-method","name":"add","doc":"Increments multiplicity of **object** and returns `self`.\n\n```\nms = Multiset{1, 2, 3}\nms.add(4) # => Multiset{1, 2, 3, 4}\n```","summary":"<p>Increments multiplicity of <strong>object</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"args_string":"(object : T)","source_link":null,"def":{"name":"add","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"__temp_26 = object\n@hash[__temp_26] = @hash[__temp_26] + 1\nself\n"}},{"id":"clear-instance-method","html_id":"clear-instance-method","name":"clear","doc":"Removes all elements and returns `self`.\n\n```\nms = Multiset{1, 2, 2}\nms.clear\nms.empty? # => true\n```","summary":"<p>Removes all elements and returns <code>self</code>.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"clear","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.clear\nself\n"}},{"id":"delete(object,count:Int32)-instance-method","html_id":"delete(object,count:Int32)-instance-method","name":"delete","doc":"Decrements multiplicity of **object** by **count** and returns `self`.\n\n```\nMultiset{1, 2, 3}.delete(2, 1) # => Multiset{1, 3}\nMultiset{4, 4, 5}.delete(4, 2) # => Multiset{5}\n```","summary":"<p>Decrements multiplicity of <strong>object</strong> by <strong>count</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""},{"name":"count","doc":null,"default_value":"","external_name":"count","restriction":"Int32"}],"args_string":"(object, count : Int32)","source_link":null,"def":{"name":"delete","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""},{"name":"count","doc":null,"default_value":"","external_name":"count","restriction":"Int32"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if count < 0\n  raise(ArgumentError.new(\"attempt to add negative count\"))\nend\nif ((__temp_32 = object\n@hash[__temp_32] = @hash[__temp_32] - count)) < 1\n  @hash.delete(object)\nend\nself\n"}},{"id":"delete(object)-instance-method","html_id":"delete(object)-instance-method","name":"delete","doc":"Decrements multiplicity of **object** and returns `self`.\n\n```\nMultiset{1, 2, 3}.delete(2) # => Multiset{1, 3}\nMultiset{4, 4, 5}.delete(4) # => Multiset{4, 5}\n```","summary":"<p>Decrements multiplicity of <strong>object</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""}],"args_string":"(object)","source_link":null,"def":{"name":"delete","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if ((__temp_30 = object\n@hash[__temp_30] = @hash[__temp_30] - 1)) < 1\n  @hash.delete(object)\nend\nself\n"}},{"id":"dup-instance-method","html_id":"dup-instance-method","name":"dup","doc":"Returns a duplicate of `self`.","summary":"<p>Returns a duplicate of <code>self</code>.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"dup","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"Multiset(T).new.merge(self)"}},{"id":"each(&)-instance-method","html_id":"each(&)-instance-method","name":"each","doc":"Yields each element of the multiset, and returns `self`.","summary":"<p>Yields each element of the multiset, and returns <code>self</code>.</p>","abstract":false,"args":[],"args_string":"(&)","source_link":null,"def":{"name":"each","args":[],"double_splat":null,"splat_index":null,"yields":1,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.each do |elem, count|\n  count.times do\n    yield elem\n  end\nend\nself\n"}},{"id":"each-instance-method","html_id":"each-instance-method","name":"each","doc":"Returns an iterator for each element of the multiset.","summary":"<p>Returns an iterator for each element of the multiset.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"each","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"MultiEntryIterator(typeof(@hash.each), T).new(@hash.each)"}},{"id":"empty?-instance-method","html_id":"empty?-instance-method","name":"empty?","doc":"Returns `true` if the multiset has no elements.\n\n```\nMultiset(Int32).new.empty? # => true\nMultiset{1, 2, 3}.empty?   # => false\n```","summary":"<p>Returns <code>true</code> if the multiset has no elements.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"empty?","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.empty?"}},{"id":"hash(hasher)-instance-method","html_id":"hash(hasher)-instance-method","name":"hash","doc":"See `Object#hash(hasher)`","summary":"<p>See <code>Object#hash(hasher)</code></p>","abstract":false,"args":[{"name":"hasher","doc":null,"default_value":"","external_name":"hasher","restriction":""}],"args_string":"(hasher)","source_link":null,"def":{"name":"hash","args":[{"name":"hasher","doc":null,"default_value":"","external_name":"hasher","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"hasher = @hash.hash(hasher)\nhasher\n"}},{"id":"includes?(object)-instance-method","html_id":"includes?(object)-instance-method","name":"includes?","doc":"Returns `true` if **other** is an element in the multiset.\n\n```\nMultiset{1, 2, 3}.includes?(3)   # => true\nMultiset{1, 2, 3}.includes?(4)   # => false\nMultiset{1, 2, 3}.includes?('a') # => false\n```","summary":"<p>Returns <code>true</code> if <strong>other</strong> is an element in the multiset.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""}],"args_string":"(object)","source_link":null,"def":{"name":"includes?","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.has_key?(object)"}},{"id":"inspect(io:IO):Nil-instance-method","html_id":"inspect(io:IO):Nil-instance-method","name":"inspect","doc":"Alias of `#to_s`.","summary":"<p>Alias of <code><a href=\"Multiset.html#to_s(io:IO):Nil-instance-method\">#to_s</a></code>.</p>","abstract":false,"args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"}],"args_string":"(io : IO) : Nil","source_link":null,"def":{"name":"inspect","args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Nil","visibility":"Public","body":"to_s(io)"}},{"id":"intersects?(other:Multiset)-instance-method","html_id":"intersects?(other:Multiset)-instance-method","name":"intersects?","doc":"Returns `true` if the multiset has any element in common with **other**.","summary":"<p>Returns <code>true</code> if the multiset has any element in common with <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"intersects?","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if @hash.size < (other.@hash).size\n  any? do |o|\n    other.includes?(o)\n  end\nelse\n  other.any? do |o|\n    includes?(o)\n  end\nend"}},{"id":"merge(elems)-instance-method","html_id":"merge(elems)-instance-method","name":"merge","doc":"Adds each element of **elems** and returns `self`.\n\n```\nms = Multiset{1, 2, 3}\nms.merge([3, 4, 5]) # => Multiset{1, 2, 3, 3, 4, 5}\n```","summary":"<p>Adds each element of <strong>elems</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"elems","doc":null,"default_value":"","external_name":"elems","restriction":""}],"args_string":"(elems)","source_link":null,"def":{"name":"merge","args":[{"name":"elems","doc":null,"default_value":"","external_name":"elems","restriction":""}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"elems.each do |elem|\n  add(elem)\nend\nself\n"}},{"id":"merge(other:Multiset(T))-instance-method","html_id":"merge(other:Multiset(T))-instance-method","name":"merge","doc":"Adds each element of **other** and returns `self`.\n\n```\nms = Multiset{3, 4, 5}\nMultiset{1, 2, 3}.merge(ms) # => Multiset{1, 2, 3, 3, 4, 5}\n```","summary":"<p>Adds each element of <strong>other</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset(T)"}],"args_string":"(other : Multiset(T))","source_link":null,"def":{"name":"merge","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset(T)"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(other.@hash).each do |elem, count|\n  __temp_28 = elem\n  @hash[__temp_28] = @hash[__temp_28] + count\nend\nself\n"}},{"id":"multiplicity(object:T)-instance-method","html_id":"multiplicity(object:T)-instance-method","name":"multiplicity","doc":"Returns count of **object** in the multiset.\n\n```\nms = Multiset{1, 2, 2}\nms.multiplicity(1) # => 1\nms.multiplicity(2) # => 2\n```","summary":"<p>Returns count of <strong>object</strong> in the multiset.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"args_string":"(object : T)","source_link":null,"def":{"name":"multiplicity","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"T"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash[object]"}},{"id":"multiplicity(object:U)forallU-instance-method","html_id":"multiplicity(object:U)forallU-instance-method","name":"multiplicity","doc":"Returns `0`.","summary":"<p>Returns <code>0</code>.</p>","abstract":false,"args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"U"}],"args_string":"(object : U) forall U","source_link":null,"def":{"name":"multiplicity","args":[{"name":"object","doc":null,"default_value":"","external_name":"object","restriction":"U"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"0"}},{"id":"proper_subset?(other:Multiset)-instance-method","html_id":"proper_subset?(other:Multiset)-instance-method","name":"proper_subset?","doc":"Returns `true` if the multiset is a proper subset of **other**.\n\n```\nMutiset{1, 2}.proper_subset? Multiset{1, 2, 3} # => true\nMutiset{1, 2}.proper_subset? Multiset{1, 1, 2} # => true\nMutiset{1, 2}.proper_subset? Multiset{1, 2}    # => false\n```","summary":"<p>Returns <code>true</code> if the multiset is a proper subset of <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"proper_subset?","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if size >= other.size\n  return false\nend\nall? do |o|\n  (multiplicity(o)) <= (other.multiplicity(o))\nend\n"}},{"id":"proper_superset?(other:Multiset)-instance-method","html_id":"proper_superset?(other:Multiset)-instance-method","name":"proper_superset?","doc":"Returns `true` if the multiset is a proper superset of **other**.\n\n```\nMutiset{1, 2, 3}.proper_superset? Multiset{1, 2} # => true\nMutiset{1, 1, 2}.proper_superset? Multiset{1, 2} # => true\nMutiset{1, 2}.proper_superset? Multiset{1, 2}    # => false\n```","summary":"<p>Returns <code>true</code> if the multiset is a proper superset of <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"proper_superset?","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if size <= other.size\n  return false\nend\nother.all? do |o|\n  (multiplicity(o)) >= (other.multiplicity(o))\nend\n"}},{"id":"size-instance-method","html_id":"size-instance-method","name":"size","doc":"Returns the number of elements in the multiset.\n\n```\nMultiset{1, 2, 3}.size       # => 3\nMultiset{1, 1, 1, 2, 3}.size # => 5\n```","summary":"<p>Returns the number of elements in the multiset.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"size","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.values.sum"}},{"id":"subset?(other:Multiset)-instance-method","html_id":"subset?(other:Multiset)-instance-method","name":"subset?","doc":"Returns `true` if the multiset is a subset of **other**.\n\n```\nMutiset{1, 2}.subset? Multiset{1, 2, 3} # => true\nMutiset{1, 2}.subset? Multiset{1, 1, 2} # => true\nMutiset{1, 2}.subset? Multiset{1, 2}    # => true\n```","summary":"<p>Returns <code>true</code> if the multiset is a subset of <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"subset?","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if size > other.size\n  return false\nend\nall? do |o|\n  (multiplicity(o)) <= (other.multiplicity(o))\nend\n"}},{"id":"subtract(other:Enumerable)-instance-method","html_id":"subtract(other:Enumerable)-instance-method","name":"subtract","doc":"Removes all elements in **other** and returns `self`.\n\n```\nms = Multiset{1, 2, 3}\nms.subtract([1, 3]) # => Multiset{2}\n```","summary":"<p>Removes all elements in <strong>other</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"args_string":"(other : Enumerable)","source_link":null,"def":{"name":"subtract","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"other.each do |e|\n  delete(e)\nend\nself\n"}},{"id":"subtract(other:Multiset)-instance-method","html_id":"subtract(other:Multiset)-instance-method","name":"subtract","doc":"Removes all elements in **other** and returns `self`.\n\n```\nms = Multiset{1, 2, 3}\nms.subtract(Multiset{1, 3}) # => Multiset{2}\n```","summary":"<p>Removes all elements in <strong>other</strong> and returns <code>self</code>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"subtract","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"(other.@hash).each do |elem, count|\n  delete(elem, count)\nend\nself\n"}},{"id":"superset?(other:Multiset)-instance-method","html_id":"superset?(other:Multiset)-instance-method","name":"superset?","doc":"Returns `true` if the multiset is a superset of **other**.\n\n```\nMutiset{1, 2, 3}.superset? Multiset{1, 2} # => true\nMutiset{1, 1, 2}.superset? Multiset{1, 2} # => true\nMutiset{1, 2}.superset? Multiset{1, 2}    # => true\n```","summary":"<p>Returns <code>true</code> if the multiset is a superset of <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"args_string":"(other : Multiset)","source_link":null,"def":{"name":"superset?","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Multiset"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"if size < other.size\n  return false\nend\nother.all? do |o|\n  (multiplicity(o)) >= (other.multiplicity(o))\nend\n"}},{"id":"to_s(io:IO):Nil-instance-method","html_id":"to_s(io:IO):Nil-instance-method","name":"to_s","doc":"Writes a string representation of the multiset to **io**.","summary":"<p>Writes a string representation of the multiset to <strong>io</strong>.</p>","abstract":false,"args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"}],"args_string":"(io : IO) : Nil","source_link":null,"def":{"name":"to_s","args":[{"name":"io","doc":null,"default_value":"","external_name":"io","restriction":"IO"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"Nil","visibility":"Public","body":"io << \"Multiset{\"\njoin(io, \", \", &.inspect(io))\nio << \"}\"\n"}},{"id":"uniq-instance-method","html_id":"uniq-instance-method","name":"uniq","doc":"Returns an `Array` containing unique elements from the multiset.","summary":"<p>Returns an <code>Array</code> containing unique elements from the multiset.</p>","abstract":false,"args":[],"args_string":"","source_link":null,"def":{"name":"uniq","args":[],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"@hash.keys"}},{"id":"|(other:Enumerable)-instance-method","html_id":"|(other:Enumerable)-instance-method","name":"|","doc":"Returns a new multiset by performing mutiset union with **other**.\n\nFor each element, new multiplicity is maximum multiplicity in either\nmultiset.\n\n```\nms1 = Multiset{1, 1, 1, 2, 2, 3, 4, 5}\nms2 = Multiset{1, 1, 3, 3, 6}\nms3 = Multiset{'a', 1, 1}\n\nms1 | ms2 # => Multiset{1, 1, 1, 3, 3, 6, 2, 2, 4, 5}\nms1 | ms3 # => Multiset{'a', 1, 1, 1, 2, 2, 3, 4, 5}\n```","summary":"<p>Returns a new multiset by performing mutiset union with <strong>other</strong>.</p>","abstract":false,"args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"args_string":"(other : Enumerable)","source_link":null,"def":{"name":"|","args":[{"name":"other","doc":null,"default_value":"","external_name":"other","restriction":"Enumerable"}],"double_splat":null,"splat_index":null,"yields":null,"block_arg":null,"return_type":"","visibility":"Public","body":"union_merge(other) do |v1, v2|\n  v1 < v2 ? v2 : v1\nend"}}],"macros":[],"types":[]}]}})