# question3.rb
# Doug Catharine
# 20200730

# Alan wrote the following method, which was intended to show all of the factors of the input number:

def factors(number)
  divisor = number
  factors = []
  while divisor > 0
    factors << number / divisor if number % divisor == 0
    divisor -= 1
  end 
  factors
end
# Alyssa noticed that this will fail if the input is 0, or a negative number, and asked Alan to change the loop. How can you make this work without using begin/end/until? Note that we're not looking to find the factors for 0 or negative numbers, but we just want to handle it gracefully instead of raising an exception or going into an infinite loop.

#Bonus 1
# What is the purpose of the number % divisor == 0 ?

# confirm that the number is cleanly divisable by divisor

#Bonus 2
#What is the purpose of the second-to-last line (line 8) in the method (the factors before the method's end)?

# to return the factors, 