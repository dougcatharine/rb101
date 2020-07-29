# question4.rb
# Doug Catharine
# 20200724
# The Ruby Array class has several methods for removing items from the array. Two of them have very similar names. Let's see how they differ:

numbers = [1, 2, 3, 4, 5]
#What do the following method calls do (assume we reset numbers to the original array between method calls)?

numbers.delete_at(1)
# deletes the index 1 so it will remove 2.  mutates
p numbers
puts

numbers.delete(1)
# deletes the number 1 mutates
p numbers
