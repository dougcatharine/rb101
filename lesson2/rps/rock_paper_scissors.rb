# rock_paper_scissors.rb
# Doug Catharine
# 20200727

# ----------------------Constants and dependencies------------------------------
require 'yaml'
MESSAGES = YAML.load_file('rps_messages.yml')
VALID_CHOICES = { "Rock": %w(R Rock),
                  "Paper": %w(P Paper),
                  "Scissors": %w(S Scissors),
                  "Lizzard": %w(L Lizzard),
                  "Spock": %w(K Spock) }
LINE_WIDTH = 80
SCORE_BOARD_WIDTH = 24
COLUMN_WIDTH = (SCORE_BOARD_WIDTH - 3) / 2
ROUNDS = 1

# ---------------------------------methods--------------------------------------
# message prompts methods
def prompt(message)
  puts "=> #{message}"
end

def response_prompt(message)
  print "#{message}:"
end

# intro methods
def print_greeting
  print `clear`
  puts MESSAGES['intro']
  puts MESSAGES['my_name']
  response_prompt('Name')
end

def print_hello_name(user_name)
  puts "Hello, #{user_name}."
end

def correct_noun
  if ROUNDS > 1
    "rounds"
  else
    "round"
  end
end

def print_rules
  puts MESSAGES['rules_intro']
  puts "The first player to win #{ROUNDS} #{correct_noun} wins!"
  puts MESSAGES['rules1']
  puts MESSAGES['rules2']
  puts MESSAGES['rules3']
  puts MESSAGES['rules4']
  puts MESSAGES['return_to_procede']
  gets
end

def name_request
  loop do
    first_name = gets.chomp
    if first_name.empty? || first_name.length > 10
      prompt(MESSAGES['name_error'])
    else
      puts `clear`
      return first_name
    end
  end
  first_name
end

# scoreboard methods
def make_center_text(text_string, padding_string)
  text_string.center(COLUMN_WIDTH, padding_string)
end

def make_scoreboard_row(row_discription, label_left, label_right)
  case row_discription
  when 'header'
    bumper = '_'
    padding_string = '_'
  when 'label'
    bumper = '|'
    padding_string = ' '
  when 'footer'
    bumper = '|'
    padding_string = '_'
  end
  bumper.concat(make_center_text(label_left, padding_string), bumper,
                make_center_text(label_right, padding_string), bumper)
end

def print_scoreboard(score, user_name)
  print_header(user_name)
  print_footer(score)
end

def print_header(user_name)
  puts make_scoreboard_row('header', '__', '__').rjust(LINE_WIDTH)
  puts make_scoreboard_row('label', user_name, 'HAL').rjust(LINE_WIDTH)
end

def print_footer(score)
  puts make_scoreboard_row('footer', '__', '__').rjust(LINE_WIDTH)
  puts make_scoreboard_row('label', score[:Player].to_s,
                           score[:Computer].to_s).rjust(LINE_WIDTH)
  puts make_scoreboard_row('footer', '__', '__').rjust(LINE_WIDTH)
end

# game logic methods
def win?(first, second)
  case second
  when 'Scissors'
    %w(Rock Spock).include?(first)
  when 'Paper'
    %w(Scissors Lizard).include?(first)
  when 'Rock'
    %w(Paper Spock).include?(first)
  when 'Lizard'
    %w(Rock Scissors).include?(first)
  when 'Spock'
    %w(Paper Lizzard).include?(first)
  end
end

def adjust_score(score, player, computer)
  if win?(player, computer)
    (score[:Player] += 1)
  elsif win?(computer, player)
    (score[:Computer] += 1)
  end
end

# game interaction display methods
def print_results(player, computer)
  if win?(player, computer)
    prompt("I win this round!!!")
  elsif win?(computer, player)
    prompt("You loose this round!!!")
  else
    prompt("It's a tie, I can't believe it!!!")
  end
end

def countdown
  VALID_CHOICES.keys.each do |str|
    print str
    3.times do
      sleep 0.1
      print '.'
    end
    sleep 0.1
  end
  print 'SHOOT!'
  sleep 1
end

def print_display(score, choice, computer_choice, user_name)
  countdown
  puts `clear`
  print_scoreboard(score, user_name)
  puts "You chose #{choice}, I chose #{computer_choice}."
  print_results(choice, computer_choice)
end

def make_letters_and_words(request)
  if request == 'letters'
    VALID_CHOICES.values.flatten.select.with_index { |_, i| (i).even? }
  elsif request == 'words'
    VALID_CHOICES.values.flatten.select.with_index { |_, i| (i + 1).even? }
  end
end

def print_selection_options
  prompt("Choose one: #{make_letters_and_words('words').join(', ')}")
  prompt("You may enter either the full names as listed or "\
         "#{make_letters_and_words('letters').join(', ')} respectively.")
end

def print_champion(score_board)
  if score_board[:Computer] == ROUNDS
    prompt(MESSAGES["hal_winner"].sample)
    prompt(MESSAGES["hal_brags"].sample)
  else
    prompt(MESSAGES["hal_poor_looser"].sample)
    prompt(MESSAGES["hal_excuses"].sample)
  end
end

# choice selection and validation
def get_choice
  response = []
  loop do
    print_selection_options
    response_prompt('Choice')
    response = validate_choice
    break if response
    print_error('general_error')
  end
  response
end

def validate_choice
  response = gets.chomp
  response = VALID_CHOICES.find { |_, v| v.include?(response.capitalize) }
  return response[0] if response
end

def print_error(error_name)
  puts `clear`
  prompt(MESSAGES[error_name])
end

def go_again?
  loop do
    prompt(MESSAGES['rematch'])
    answer = gets.chomp.downcase
    if answer.downcase.eql?('y')
      return true
    elsif answer.downcase.eql?('n')
      return false
    end
    print_error('yes_no_error')
  end
end

# ------------------------------------main program------------------------------

print_greeting
name = name_request
print_hello_name(name)
print_rules
loop do
  score = { Player: 0, Computer: 0 }
  puts `clear`
  loop do
    choice = get_choice.to_s
    computer_choice = VALID_CHOICES.keys.sample.to_s
    adjust_score(score, choice, computer_choice)
    print_display(score, choice, computer_choice, name)
    break if score.any? { |_, v| v == ROUNDS }
  end
  print_champion(score)
  break unless go_again?
end
prompt(MESSAGES['quiter'])
puts `clear`
