# question2.rb
# Doug Catharine
# 20200730


# What is the result of the last line in the code below?
greetings = { a: 'hi' }
informal_greeting = greetings[:a]
informal_greeting << ' there'

puts informal_greeting  #  => "hi there"
puts greetings

# "hi there" the variables are shared after the informal_greeting = greetings[:a]