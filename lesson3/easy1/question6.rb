# question6.rb
# Doug Catharine
# 20200729

# Starting with the string:

famous_words = "seven years ago..."
# show two different ways to put the expected "Four score and " in front of it.

prefix = "Four score and "


 puts prefix + famous_words
puts prefix.concat(famous_words)
puts famous_words.insert(0,prefix)
puts famous_words.prepend(prefix)