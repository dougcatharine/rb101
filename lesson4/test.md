# Lesson 4 - Ruby Collections


## element reference
```ruby
str = 'abcdefghi'

str[2] # => "c"
```
You can alsoe reference multiple charecters through 
```ruby
str[2, 3] # => "cde"
```

Something to be aware of in the above example is that str[2, 3] is actually a call to the #slice method of String and is alternative syntax for str.slice(2, 3). The fact that we can use this alternative form of #slice is part of Ruby's syntactical sugar.

```ruby
arr = [1, 'two', :three, '4']
arr.slice(3, 1) # => ["4"]
arr.slice(3..3) # => ["4"]
arr.slice(3)    # => "4"
```

On lines 2, 3, and 4 in the code above, we are using the element reference syntax of the Array#slice method. Although these three method calls all target the same element of arr (the string '4' at index 3), the first two method calls return that element inside a new array, whereas the third one simply returns the element itself.

## Coversion

The fact that strings and arrays share similarities, such as both being zero-indexed collections, lends itself to being able to convert from one to the other, and this is quite common practice in Ruby code. There are a number of Ruby methods that facilitate this type of conversion including String#chars and Array#join.


String#chars returns an array of individual characters.
```ruby
str = 'Practice'

arr = str.chars # => ["P", "r", "a", "c", "t", "i", "c", "e"]
```

Array#join returns a string with the elements of the array joined together.

``` ruby
arr.join # => "Practice"
```
Hash has a #to_a method, which returns an array.

``` ruby
hsh = { sky: "blue", grass: "green" }
hsh.to_a # => [[:sky, "blue"], [:grass, "green"]]
```


# Loops

``` ruby 
loop do
  puts "This will keep printing until you hit Ctrl + c"
end
```

``` ruby 
i = 0
loop do
  i += 1
  puts i
  break         # this will cause execution to exit the loop
end
```

a conditional loop
``` ruby 
i = 0
loop do
  i += 2
  puts i
  if i == 10
    break       # this will cause execution to exit the loop
  end
end
```

using next
``` ruby

i = 0
loop do
  i += 2
  if i == 4
    next        # skip rest of the code in this iteration
  end
  puts i
  if i == 10
    break
  end
end
```

A while loop is given a parameter that evaluates to a boolean (remember, that's just true or false). Once that boolean expression becomes false, the while loop is not executed again, and the program continues after the while loop. 
``` ruby 

x = gets.chomp.to_i

while x >= 0
  puts x
  x = x - 1
end

puts "Done!"
```

untill loops 
```ruby 
# countdown.rb

x = gets.chomp.to_i

until x < 0
  puts x
  x -= 1
end

puts "Done!"
```

A do/while loop works in a similar way to a while loop; one important difference is that the code within the loop gets executed one time, prior to the conditional check to see if the code should be executed.

``` ruby 
loop do
  puts "Do you want to do that again?"
  answer = gets.chomp
  if answer != 'Y'
    break
  end
end
```
also 
``` ruby 
begin
  puts "Do you want to do that again?"
  answer = gets.chomp
end while answer == 'Y'
```
While the above works, it's not recommended by Matz, the creator of Ruby.

for loops

``` ruby
x = gets.chomp.to_i

for i in 1..x do
  puts i
end
```
as we saw, this doesnt have a block ( either {} or do/end) so it is not locally scoped.

A block is just some lines of code ready to be executed. When working with blocks there are two styles you need to be aware of. By convention, we use the curly braces ({}) when everything can be contained in one line. We use the words do and end when we are performing multi-line operations. Let's add some functionality to our previous program to try out this do/end stuff.

``` ruby 
x = [1, 2, 3, 4, 5]

for i in x do
  puts i
end

puts "Done!"
```

iterators

``` ruby
names = ['Bob', 'Joe', 'Steve', 'Janice', 'Susan', 'Helen']

names.each { |name| puts name }

puts "Done!"
```

Iterating over colections 
``` ruby
number_of_pets = {
  'dogs' => 2,
  'cats' => 4,
  'fish' => 1
}
pets = number_of_pets.keys # => ['dogs', 'cats', 'fish']
counter = 0

loop do
  break if counter == number_of_pets.size
  current_pet = pets[counter]
  current_pet_number = number_of_pets[current_pet]
  puts "I have #{current_pet_number} #{current_pet}!"
  counter += 1
end
```

## Selection and Transformation

Selection is picking certain elements out of the collection depending on some criterion. For example, pick out all the odd integers from an array. Transformation, on the other hand, refers to manipulating every element in the collection. For example, increment all elements of the array by 1. If there are n elements in a collection, selection results in n or less elements, while transformation always results in exactly n elements. 

selection
``` ruby 
alphabet = 'abcdefghijklmnopqrstuvwxyz'
selected_chars = ''
counter = 0

loop do
  current_char = alphabet[counter]

  if current_char == 'g'
    selected_chars << current_char    # appends current_char into the selected_chars string
  end

  counter += 1
  break if counter == alphabet.size
end

selected_chars # => "g"
```

and transform
``` ruby 
fruits = ['apple', 'banana', 'pear']
transformed_elements = []
counter = 0

loop do
  current_element = fruits[counter]

  transformed_elements << current_element + 's'   # appends transformed string into array

  counter += 1
  break if counter == fruits.size
end

transformed_elements # => ["apples", "bananas", "pears"]
```

Extracting to Methods

String#include?
```ruby 
def select_vowels(str)
  selected_chars = ''
  counter = 0

  loop do
    current_char = str[counter]

    if 'aeiouAEIOU'.include?(current_char)
      selected_chars << current_char
    end

    counter += 1
    break if counter == str.size
  end

  selected_chars
end
```
An important thing to note here is that when our method is done iterating over the collection it returns a new collection containing the selected values. In this case, our select_vowels method returns a new string.

```ruby 
def select_fruit(produce_list)
  produce_keys = produce_list.keys
  counter = 0
  selected_fruits = {}

  loop do
    # this has to be at the top in case produce_list is empty hash
    break if counter == produce_keys.size

    current_key = produce_keys[counter]
    current_value = produce_list[current_key]

    if current_value == 'Fruit'
      selected_fruits[current_key] = current_value
    end

    counter += 1
  end

  selected_fruits
end
```
Notice that:

the original argument, produce_list, is not mutated
a new hash is returned by the method (as opposed to an array or string)


Lets look at each, select, and map

# each
he each method is functionally equivalent to using loop and represents a simpler way of accomplishing the same task. Here's an example that produces the same result as the implementation above:
``` ruby
[1, 2, 3].each do |num|
  puts num
end
```
The method takes a block, which is the do … end part.  The code within the block is executed for each iteration. In this case the code within the block is puts num which means each element in the array will be output by the puts method.
How does the block know what num is? For each iteration, each sends the value of the current element to the block in the form of an argument. In this block, the argument to the block is num and it represents the value of the current element in the array.

Since we're working with an array here, each knows that there's only one element per iteration, so each sends the block only one argument, num. Hashes, however, need two arguments in order to represent both the key and the value per iteration. Calling each on a hash looks a little different, since the block has two arguments:
```ruby 
hash = { a: 1, b: 2, c: 3 }

hash.each do |key, value|
  puts "The key is #{key} and the value is #{value}"
end
```
Once each is done iterating, it returns the original collection. We can verify this by testing it in irb.

``` ruby
irb :001 > [1, 2, 3].each do |num|
irb :002 >   puts num
irb :003 > end
1
2
3
=> [1, 2, 3]  
```
What if we added a statement after #each? What will the return value of a_method be?
```ruby
def a_method
  [1, 2, 3].each do |num|
    puts num * 2
  end

  puts 'hi'
end
```
The return value of a_method has changed to nil. Why? The last expression within the method has changed from each to puts 'hi'. Since puts always returns nil, the return value of a_method is nil.
```ruby
a_method # => nil  
```
# select

We've explored a basic approach to performing selection with loop, but arrays and hashes also have a built-in way to iterate over a collection and perform selection: through a select method that makes doing this significantly easier.

``` ruby
[1, 2, 3].select do |num|
  num.odd?
end
```
To perform selection, `select` evaluates the return value of the block. The block returns a value on each iteration, which then gets evaluated by `select`. ***Similar to a real method, the return value of the block is the return value of the last expression within the block.***