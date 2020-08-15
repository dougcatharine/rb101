# pp13.rb
# Doug Catharine
# 20200809

#Given the following data structure, return a new array containing the same sub-arrays as the original but ordered logically by only taking into consideration the odd numbers they contain.

arr = [[1, 6, 7], [1, 4, 9], [1, 8, 3]]
#The sorted array should look like this:
#[[1, 8, 3], [1, 6, 7], [1, 4, 9]]

arr.sort_by { |sub_arr| [sub_arr[0], sub_arr[2]]}


# solution 
arr.sort_by do |sub_arr|
  sub_arr.select do |num|
    num.odd?
  end
end
# => [[1, 8, 3], [1, 6, 7], [1, 4, 9]]