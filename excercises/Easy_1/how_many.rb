# how_many.rb
# Doug Catharine
# 20200804

# How Many?
# Write a method that counts the number xof occurrences of each element in a given array.

vehicles = [
  'car', 'car', 'truck', 'car', 'SUV', 'truck',
  'motorcycle', 'motorcycle', 'car', 'Truck'
]

#count_occurrences(vehicles)
#The words in the array are case-sensitive: 'suv' != 'SUV'. ` Once counted, print each element alongside the number of occurrences.

#Expected output:

#car => 4
#truck => 3
#SUV => 1
#motorcycle => 2

#P - [Understand the] Problem
  #count unique case sensitive words in array.
  # print count with unique word.
  #???
  # will there be empty arrays?
  # format out?
  # will the "occurance" always be a string?

  # assume format in - array
  # format out hash
  # no, will not always be a string

#E - Examples / Test cases
#car => 4
#truck => 3
#SUV => 1
#motorcycle => 2
#D - Data Structure
# input = array
# output = hash
#A - Algorithm
#brute force
# go through array, one by one.
# check to see if exists in hash
# if does, add 1
# if doesnt add to hash with value = 1
#return hash when done
#C - Code

def count_occurrences(in_array)
  out_hash = Hash.new
  in_array.each do |element|
    out_hash[element] ? out_hash[element] += 1 : out_hash[element] = 1
  end
  out_hash
end

test_hash = {'car' => 4, 'truck' => 3, 'SUV' => 1, 'motorcycle' => 2}

#test 
puts count_occurrences(vehicles) == test_hash
#puts count_occurrences(vehicles)

# solution 
def count_occurrences(array)
  occurrences = {}

  array.uniq.each do |element|
    occurrences[element] = array.count(element)
  end

  occurrences.each do |element, count|
    puts "#{element} => #{count}"
  end
end