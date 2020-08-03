# problem1.rb
# Doug Catharine
# 20200803

# Given the array below

flintstones = ["Fred", "Barney", "Wilma", "Betty", "Pebbles", "BamBam"]
#Turn this array into a hash where the names are the keys and the values are the positions in the array.

hash = Hash.new
flintstones.each_with_index do |val, index|
  hash[val] = index
end
puts hash
