# Sorting
Sorting is mostly performed on arrays; since items in arrays are accessed via their index, the order in which those items appear is important.  
Strings don't have access to any sorting methods

Ruby provides a couple of methods that can do this complex work for us: `sort` and `sort_by`.

``` ruby 
[2, 5, 3, 4, 1].sort # => [1, 2, 3, 4 ,5]
```

Sorting is essentially carried out by comparing the items in a collection with each other, and ordering them based on the result of that comparison. Comparison is at the heart of how sorting works.
```ruby
['c', 'a', 'e', 'b', 'd'].sort # => ['a', 'b', 'c', 'd', 'e']
```

## <=> method 
(sometimes referred to as the "spaceship" operator).

Any object in a collection that we want to sort must implement a <=> method. This method performs comparison between two objects of the same type and returns a -1, 0, or 1, depending on whether the first object is less than, equal to, or greater than the second object; if the two objects cannot be compared then nil is returned.

``` ruby
2 <=> 1 # => 1
1 <=> 2 # => -1
2 <=> 2 # => 0
'b' <=> 'a' # => 1
'a' <=> 'b' # => -1
'b' <=> 'b' # => 0
1 <=> 'a' # => nil
```
The return value of the <=> method is used by sort to determine the order in which to place the items. If <=> returns nil to sort then it throws an argument error.
``` ruby
['a', 1].sort # => ArgumentError: comparison of String with 1 failed
```
The answer is that String order is determined by a character's position in the ASCII table.

- Uppercase letters come before lowercase letters.
- Digits and (most) punctuation come before letters
- There is an extended ASCII table containing accented and other characters - this comes after the main ASCII table

We can also call `sort` with a block; this gives us more control over how the items are sorted. The block needs two arguments passed to it (the two items to be compared) and the return value of the block has to be -1, 0, 1 or nil.
```ruby
[2, 5, 3, 4, 1].sort do |a, b|
  a <=> b
end
# => [1, 2, 3, 4, 5]
```
```ruby
[2, 5, 3, 4, 1].sort do |a, b|
  b <=> a
end
# => [5, 4, 3, 2, 1]
```

This shows how `sort` works
``` ruby
[2, 5, 3, 4, 1].sort do |a, b|
  puts "a is #{a} and b is #{b}"
  a <=> b
end
# a is 2 and b is 5
# a is 5 and b is 3
# a is 2 and b is 3
# a is 5 and b is 4
# a is 3 and b is 4
# a is 5 and b is 1
# a is 4 and b is 1
# a is 3 and b is 1
# a is 2 and b is 1
# => [1, 2, 3, 4, 5]
```
working with strings

```ruby
['arc', 'bat', 'cape', 'ants', 'cap'].sort
# => ["ants", "arc", "bat", "cap", "cape"]
```

sort_by method
```ruby
['cot', 'bed', 'mat'].sort_by do |word|
  word[1]
end
# => ["mat", "bed", "cot"]
```

And with a hash...
```ruby
people = { Kate: 27, john: 25, Mike:  18 }
```
The last argument evaluated in the block should then be the thing by which we want to sort, so if we wanted the hash sorted by age we could do the following:
```ruby
people.sort_by do |_, age|
  age
end
# => [[:Mike, 18], [:john, 25], [:Kate, 27]]
```
sort_by always returns an array, even when called on a hash, so the result here is a new array with the key-value pairs as objects in nested arrays. If we need to convert this back into a hash we can call Array#to_h on it.

By using Symbol#<=> we are effectively comparing strings. We therefore know that we can sort our hash by name.

There's a problem though. You may have noticed that one of the names, :john, is not capitalized. Since strings are compared in 'ASCIIbetical' order, :john will come after :Kate and :Mike, which may not be what we want.

Luckily there is an easy way to deal with this problem. We can use the Symbol#capitalize method on each name within the block so that when the keys are compared they are all capitalized.

```ruby
people.sort_by do |name, _|
  name.capitalize
end
# => [[:john, 25], [:Kate, 27], [:Mike, 18]]
```

other sorting methods
* `min`
* `max`
* `minmax`
* `min_by`
* `max_by`
* `minmax_by`