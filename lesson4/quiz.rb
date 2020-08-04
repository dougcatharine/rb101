map { |obj| block } → array
map → an_enumerator
Returns a new array with the results of running block once for every element in enum.

If no block is given, an enumerator is returned instead.

(1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
(1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]


collect → an_enumerator
Returns a new array with the results of running block once for every element in enum.

If no block is given, an enumerator is returned instead.

(1..4).map { |i| i*i }      #=> [1, 4, 9, 16]
(1..4).collect { "cat"  }   #=> ["cat", "cat", "cat", "cat"]

hashh= {a:1,b:2}
hashj.map {|num| puts num}