# loan_calculator.rb
# Doug Catharine, review by Srdan Coric
# V1 20200723
# V2.3 20200724
# V3 20200725

################################################################################
# extensions

require 'yaml'
MESSAGES = YAML.load_file('loan_messages.yml')

################################################################################
# methods

def print_welcome_show
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

def buffer_line(line_width, center_string, buffer_string, num)
  buffer = center_string(center_string, line_width)
  num.times do
    buffer[0].times { print buffer_string }
    print(center_string)
    buffer[1].times { print buffer_string }
    puts
  end
end

def center_string(center_string, line_width)
  str_len = center_string.length
  buff = (line_width - str_len) / 2
  (2 * buff + str_len) == line_width ? [buff, buff] : [buff + 1, buff]
end

def print_greeting
  puts MESSAGES['intro']
  puts MESSAGES['my_name']
  print 'first name:'
end

def print_hello_name
  print_greeting
  puts "It's great to meet you #{name_request}"
  puts MESSAGES['buisness']
  puts MESSAGES['wanna_loan']
end

def name_request
  loop do
    first_name = gets.chomp
    if first_name.empty?
      print_request(MESSAGES['name_error'], '=> ')
    else
      puts `clear`
      return first_name
    end
  end
  first_name
end

def retrieve_input(input_type, symbol)
  print_request(MESSAGES[input_type], symbol)
  input = gets.chomp
  loop do
    break if valid_input?(input, input_type)
    puts(MESSAGES["#{input_type}_error"])
    print_request(MESSAGES[input_type], symbol)
    input = gets.chomp
  end
  input
end

def print_request(command, symbol)
  puts command
  print symbol
end

def valid_input?(input, input_type)
  case input_type
  when "loan_amt"
    [input.to_i.to_s, input.to_f.to_s].include?(input) && (input.to_f > 0)
  when "apr"
    [input.to_i.to_s, input.to_f.to_s].include?(input) && (input.to_f > 0)
  when "duration"
    input.to_i.to_s.eql?(input) && (input.to_f > 0)
  when 'month_or_year'
    (input.length == 1) && (['m', 'y'].include?(input.downcase))
  end
end

def month_or_year(term, time_unit)
  time_unit.eql?('m') ? noun = 'month' : noun = 'year'
  noun += 's' if term > 1
  noun
end

def correct_term(unit, term)
  term *= 12 if unit.downcase.start_with?('y')
  term
end

def monthly_payment(principal, interest, term, noun)
  interest /= (100 * 12) # convert to points monthly
  monthly_payment = principal * (interest / (1 - (1 + interest)**(-term)))
  puts "Your monthly payment is $#{monthly_payment.ceil(2)} "\
    "for #{term} #{noun}." # bank gets the fractional penny
end

################################################################################
# Main Program

print_welcome_show
print_hello_name

loop do
  principal = retrieve_input('loan_amt', '=> $').to_f
  interest = retrieve_input('apr', '=> %').to_f
  term = retrieve_input('duration', '=> ').to_i
  m_o_y = retrieve_input('month_or_year', '=> ')
  noun = month_or_year(term, m_o_y)
  term = correct_term(noun, term)
  puts `clear`
  monthly_payment(principal, interest, term, noun)
  puts MESSAGES['again']
  answer = gets.chomp
  puts `clear`
  break if (answer.length == 1) && (answer.start_with?('n'))
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
