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
require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

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

def name_request
  puts MESSAGES['intro']
  puts MESSAGES['my_name']
  print 'first name: '
  first_name = gets.chomp
  puts "It's great to meet you #{first_name}"
  puts MESSAGES['buisness']
  puts MESSAGES['wanna_loan']
end

def valid_number(input)
  input.to_i.to_s == input || input.to_f.to_s == input
end

def numeric_request(string, symbol)
  loop do
    puts string
    print symbol
    value = gets.chomp
    if valid_number(value)
      return value.to_f
    else
      puts MESSAGES['bad_number']
    end
  end
end

def month_or_year(string, term)
  loop do
    puts string
    value = gets.chomp
    if value.downcase.start_with?('m')
      unit = term > 1 ? 'months' : 'month'
      return [term, unit]
    elsif value.downcase.start_with?('y')
      unit = term > 1 ? 'years' : 'year'
      term *= 12
      return [term, unit]
    else
      puts MESSAGES['bad_comprehend']
    end
  end
end

def monthly_payment(principal, interest, months)
  monthly_payment = principal * (interest / (1 - (1 + interest)**(-months[0])))
  puts "Your monthly payment is $#{monthly_payment.ceil(2)}"\
    "for #{months[0].to_i} #{months[1]}."
end

def break_loop(string)
  loop do
    puts string
    reply = gets.chomp
    if reply.downcase.start_with?('y') || reply.downcase.start_with?('n')
      if reply.downcase.start_with?('n')
        return true
      else
        break
      end
    end
    puts MESSAGES['bad_comprehend']
  end
end
################################################################################
# Main Program

welcome_show
name_request
loop do
  principal = numeric_request(MESSAGES['money'], ':$')
  loop do
    interest = numeric_request(MESSAGES['rate'], ":%")
    term = numeric_request(MESSAGES['length'], ":")
    months = month_or_year(MESSAGES['month_or_year'], term)
    monthly_payment(principal, interest / 100, months)
    break if break_loop(MESSAGES['change_interest'])
  end
  break if break_loop(MESSAGES['another_loan'])
end
puts MESSAGES['thank_you']
