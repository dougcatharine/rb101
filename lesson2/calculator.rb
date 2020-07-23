# calculator.rb
# Doug Catharine
# 20200722

# codealong

# General flow
# ask the user for two numbers
# ask for the type of operation to perform :add, subtractm multiply or devide
# perform the operation on the two numbers
# display the result

# answer = Kernel.gets()
# Kernel.puts(answer)

def prompt(message)
  Kernel.puts("=> #{message}")
end

def valid_number?(num)
  num.to_i() != 0
end

def operation_to_message(op, number1, number2)
  case op
  when '1'
    ['Adding', number1.to_i() + number2.to_i()]
  when '2'
    ['Subtracting', number1.to_i() - number2.to_i()]
  when '3'
    ['Multiplying', number1.to_i() * number2.to_i()]
  when '4'
    ['Dividing', number1.to_f() / number2.to_f()]
  end
end

loop do
  prompt('Welcome to Calculator!')
  number1 = ''
  loop do
    prompt('Whats the first number?')
    number1 = Kernel.gets().chomp()

    if valid_number?(number1)
      break
    else
      prompt('Please enter in a valid number!')
    end
  end

  number2 = ''
  loop do
    prompt('Whats the second number?')
    number2 = Kernel.gets().chomp()

    if valid_number?(number2)
      break
    else
      prompt('Please enter a valid number')
    end
  end

  operator_prompt = <<-MSG
    What operation would you like to perform?
    1) add 2) subtract 3) multiply 4) divide
  MSG

  operator = ''
  prompt(operator_prompt)

  loop do
    operator = Kernel.gets().chomp()
    if %w(1 2 3 4).include?(operator)
      break
    else
      prompt('Must choose 1,2,3, or 4')
    end
  end
  answer = operation_to_message(operator, number1, number2)
  prompt("#{answer[0]} the two numbers")
  Kernel.puts("The result is #{answer[1]}")

  prompt('Do you want to perform another calculation (y or n)')
  answer = Kernel.gets()
  break unless answer.downcase().start_with?('y')
end

prompt('Thank you for using the calculator')
