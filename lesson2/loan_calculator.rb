# loan_calculator.rb
# Doug Catharine
# 20200723

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

require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

# prints a centered centered_string with with edges of buffer_string num times
# of width = line_width, reply == nil
def buffer_line(line_width, center_string, buffer_string, num)
  str_len = center_string.length
  buff = (line_width - str_len) / 2
  if 2 * buff + str_len == line_width   # centered?
    buffer = [buff, buff]
  else                                  # or off by one
    buffer = [buff + 1, buff]
  end
  num.times do
    buffer[0].times { print buffer_string }
    print(center_string)
    buffer[1].times { print buffer_string }
    puts
  end
end

# cosmetic signiture starting program, reply == nil
def welcome_show
  line_width = 80
  # signiture = 'Code by Doug Catharine'
  # email = 'dougcatharine@gmail.com'
  # welcome = "Welcome Doug's loan calculator"
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

# brief intro, asking name and welcoming/ warm up, reply == nil
def name_request
  puts MESSAGES['intro']
  puts MESSAGES['my_name']
  print 'first name: '
  first_name = gets.chomp
  puts "It's great to meet you #{first_name}"
  puts MESSAGES['buisness']
  puts MESSAGES['wanna_loan']
end

# confirm valid number, reply = boolean
def valid_number(input)
  [input.to_i.to_s, input.to_f.to_s].include?(input)
end

# ask user for a number, validate number , reply == number
def numeric_request(string, symbol)
  loop do
    puts string
    print symbol
    value = gets.chomp
    return value.to_f if valid_number(value)

    puts MESSAGES['bad_number']
  end
end

# returns true if string reply == letter1, false: reply==letter2.  Cant leave
# if neither, reply == boolean
def one_or_other?(string, letter1, letter2)
  # binding.pry
  loop do
    puts string
    value = gets.chomp
    if value.length == 1
      return true if value.downcase.start_with?(letter1)

      return false if value.downcase.start_with?(letter2)

      next
    end
    puts MESSAGES['bad_comprehend']
  end
end

# asks for m or y and selects correct noun,
# reply == array[term in months, correct noun of supplies units]
def month_or_year(string, term)
  if one_or_other?(string, 'm', 'y')
    unit = term > 1 ? 'months' : 'month'
  else
    unit = term > 1 ? 'years' : 'year'
    term *= 12 # change to months for calculations
  end
  [term, unit]
end

# calculates monthly payments and returns payments/length
def monthly_payment(principal, interest, months)
  interest /= 100 # convert to points
  monthly_payment = principal * (interest / (1 - (1 + interest)**(-months[0])))
  puts "Your monthly payment is $#{monthly_payment.ceil(2)} "\
    "for #{months[0].to_i} #{months[1]}."
end

################################################################################
# Main Program

welcome_show
name_request
loop do
  principal = numeric_request(MESSAGES['money'], ':$')
  loop do
    interest = numeric_request(MESSAGES['rate'], ':%')
    term = numeric_request(MESSAGES['length'], ':')
    months = month_or_year(MESSAGES['month_or_year'], term)
    monthly_payment(principal, interest, months)
    break if one_or_other?(MESSAGES['change_interest'], 'n', 'y')
  end
  break if one_or_other?(MESSAGES['another_loan'], 'n', 'y')
end
puts MESSAGES['thank_you']
