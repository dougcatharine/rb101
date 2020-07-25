# loan_calculator.rb
# Doug Catharine
# V1 20200723
# V2.3 20200724

################################################################################
# extensions

require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

################################################################################
# procedures

# cosmetic signiture starting program.
# input = none
# output = 2(Int)
def welcome_show
  line_width = 80
  buffer_line(line_width, '*', '*', 3)
  buffer_line(line_width, '-', '-', 1)
  buffer_line(line_width, MESSAGES['signiture'], '*', 1)
  buffer_line(line_width, '-', '-', 1)
  buffer_line(line_width, MESSAGES['email'], '*', 1)
  buffer_line(line_width, '-', '-', 1)
  buffer_line(line_width, '*', '*', 3)
  buffer_line(line_width, ' ', ' ', 2)
  buffer_line(line_width, MESSAGES['welcome'], ' ', 1)
  buffer_line(line_width, ' ', ' ', 2)
end

# prints a centered centered_string(str) with with edges of buffer_string(str)
# num times(int) of line_width(int).
# input = line_width(Int), center_string(String), buffer_string(string),
# num(Int)
# output = num(Int)
def buffer_line(line_width, center_string, buffer_string, num)
  buffer = center_string(center_string, line_width)
  num.times do
    buffer[0].times { print buffer_string }
    print(center_string)
    buffer[1].times { print buffer_string }
    puts
  end
end

# finds padding for given center_string(str) on line of width line_width(int).
# input = center_string(String), line_width(Int)
# output = Array[left_padding, right_padding]
def center_string(center_string, line_width)
  str_len = center_string.length
  buff = (line_width - str_len) / 2
  if 2 * buff + str_len == line_width   # centered?
    [buff, buff]
  else                                  # or off by one
    [buff + 1, buff]
  end
end

# brief intro, asking name and welcoming/ warm up.
# input = none
# output == nil
def name_request
  puts MESSAGES['intro']
  puts MESSAGES['my_name']
  print 'first name: '
  first_name = gets.chomp
  puts "It's great to meet you #{first_name}"
  puts MESSAGES['buisness']
  puts MESSAGES['wanna_loan']
end

# ask user for a number, validates if number.
# input = command(String), command(String), symbol(String)
# output = value(Float)
def numeric_request(command, error, symbol)
  loop do
    puts command
    print symbol
    value = gets.chomp
    return value.to_f if valid_number?(value)

    puts error
  end
end

# confirm valid number.
# input = input(Int/Float)
# output = boolean
def valid_number?(input)
  [input.to_i.to_s, input.to_f.to_s].include?(input)
end

# asks for 'm or y' and selects correct noun and gives months for loan.
# input command(String), error(String), term(Int/Float)
# output = Array[term(Float), unit(String)]
def month_or_year_request(command, error, term)
  if one_or_other?(command, error, 'm', 'y')
    unit = term > 1 ? 'months' : 'month'
  else
    unit = term > 1 ? 'years' : 'year'
    term *= 12 # change to months for calculations
  end
  [term, unit]
end

# returns true if string1 reply == letter1, false: reply==letter2.  Can't leave
# if neither, error message = string2
# input = command(String), error(String), option1(String), option2(String)
# output = boolean
def one_or_other?(command, error, option1, option2)
  # binding.pry
  loop do
    puts command
    value = gets.chomp
    if value.length == 1
      return true if value.downcase.start_with?(option1)

      return false if value.downcase.start_with?(option2)

      next
    end
    puts error
  end
end

# calculates monthly payments and returns payments/length
# input = principal(Int/Float), interest(Int/Float), months(Int/Float),
# term(Int/Float)
# output = nil
def monthly_payment(principal, interest, months, term)
  interest /= (100 * 12) # convert to points monthly
  monthly_payment = principal * (interest / (1 - (1 + interest)**(-months[0])))
  puts "Your monthly payment is $#{monthly_payment.ceil(2)} "\
    "for #{term} #{months[1]}." # bank gets the fractional penny
end

################################################################################
# Main Program

welcome_show
name_request
loop do
  principal = numeric_request(MESSAGES['money'], MESSAGES['bad_number'], ':$')
  loop do
    interest = numeric_request(MESSAGES['rate'], MESSAGES['bad_number'], ':%')
    term = numeric_request(MESSAGES['length'], MESSAGES['bad_number'], ':')
    months = month_or_year_request(MESSAGES['month_or_year'],
                                   MESSAGES['m_or_y'], term)
    monthly_payment(principal, interest, months, term)
    break if one_or_other?(MESSAGES['change_interest'],
                           MESSAGES['n_or_y'], 'n', 'y')
  end
  break if one_or_other?(MESSAGES['another_loan'], MESSAGES['n_or_y'], 'n', 'y')
end
puts MESSAGES['thank_you']

=begin
problem
  build a loan calculator based on provide formula `
  m = p * (j / (1 - (1 + j)**(-n)))
  m = monthly payment
  p = loan amount
  j = monthly interest rate
  n = loan duration in months

examples
  car with 4% 60 months
  house with 4% 30 years
  know years vs months

data
  loan amount = float
  interest rate = float
  loan duration = int
algo
START
PRINT welcome
GET Name,
  GET object buying,
  LOOP interest loan term month or years
    SET monthly payment
    GET rerun change interest and term?
  GET rerun change object?
PRINT bye message
=end
