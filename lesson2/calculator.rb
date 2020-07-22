# calculator.rb
# Doug Catharine
# 20200722

# codealong


# General flow
# ask the user for two numbers
# ask for the type of operation to perform :add, subtractm multiply or devide
# perform the operation on the two numbers
# display the result

#answer = Kernel.gets()
#Kernel.puts(answer)

Kernel.puts("Welcome to Calculator!")

Kernel.puts("Whats the first number?")
number1 = Kernel.gets().chomp()

Kernel.puts("Whats the second number?")
number2 = Kernel.gets().chomp()

Kernel.puts("What operation would you like to perform? 1) add 2) subtract 3) multiply 4) divide")
operator = Kernel.gets().chomp()

if operator == '1'
  result = number1.to_i() +  number2.to_i()
elsif operator == '2'
 result = number1.to_i() -  number2.to_i()
elsif operator == '3'
  result = number1.to_i() *  number2.to_i()
elsif operator == '4'
  result = number1.to_f() /  number2.to_f()
end

Kernel.puts("The result is #{result}")


