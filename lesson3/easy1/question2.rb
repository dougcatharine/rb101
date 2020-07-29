# question2.rb
# Doug Catharine
# 20200729

#Describe the difference between ! and ? in Ruby. And explain what would happen in the following scenarios:

# what is != and where should you use it?
# not equal to. such as 
number = 7
if number != 6
  puts "not six"
end
# put ! before something, like !user_name
  # not, flips boolian such as 
if !false
  puts "true"
end
# put ! after something, like words.uniq!
# Imlies that that the method that ! is before mutates the caller.  such as 
a = [1, 2, 2, 4, 3, 4]
p a
a.uniq!
p a 
# put ? before something
# no idea

# put ? after something
#a ? after a method implies that it returns a boolian such as eql?
a = "hello"
a.eql?("hello")

# put !! before something, like !!user_name
# !! is a double not so if a statement is false, it continues to be false, such as

a = false
puts !a
puts !a 
