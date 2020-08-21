# tic_tac_toe.rb
# Doug Catharine
# 20200816

require 'pry'
require 'yaml'
MESSAGES = YAML.load_file('ttt_messages.yml')
LINE_WIDTH = 80
MINIMAX_VAL = 100;

PLAYER_MOVE = 'O'
COMPUTER_MOVE = 'X'
AVAILABLE_MOVE = ' '
WINNING_MOVES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

def prompt(message)
  puts "=> #{message}"
end

def response_prompt(message)
  print "#{message}:"
end

def clear_screen
  system('clear') || system('cls')
end

def name_valid?(first_name)
  !first_name.strip.empty?
end

def validate_name(first_name)
  while !name_valid?(first_name)
    print_error('name_error')
    response_prompt('Name')
    first_name = gets.chomp
  end
  first_name
end

def name_request
  prompt(MESSAGES['my_name'])
  response_prompt('Name')
  validate_name(gets.chomp)
end

def print_hello_name(user_name)
  clear_screen
  prompt("Hello, #{user_name}.")
end

def print_rules
  display_board(board_locations)
  prompt(MESSAGES['rules1'])
  prompt(MESSAGES['rules2'])
  prompt(MESSAGES['rules3'])
  prompt(MESSAGES['rules4'])
end

def validate_number(number)
  while !number.to_i.to_s
    number = get_number(true)
  end
  number.to_i
end

def get_number(error=false)
  prompt("gen error message") if error
  response_prompt('enter number')
  gets.chomp.to_i
end

def number_of_rounds
  prompt(MESSAGES['rounds'])
  validate_number(get_number)
end

def board_locations
  board_marks = {}
  (1..9).each { |k| board_marks[k] = k.to_s }
  board_marks
end

def initialize_board
  board_marks = {}
  (1..9).each { |k| board_marks[k] = AVAILABLE_MOVE }
  board_marks
end

def send_to_right(message)
  puts message.rjust(LINE_WIDTH)
end

def header
  send_to_right('   |   |   ')
end

def footer
  send_to_right('---+---+---')
end

def display_row(disp_hsh, row_array)
  send_to_right(" #{disp_hsh[row_array[0]]} \
| #{disp_hsh[row_array[1]]} | \
#{disp_hsh[row_array[2]]} ")
end

def display_board(display_hash)
  display_row(display_hash, [1, 2, 3])
  footer
  display_row(display_hash, [4, 5, 6])
  footer
  display_row(display_hash, [7, 8, 9])
end

def available_plays?(board_status)
  board_status.map do |_, v|
    v.eql? ' '
  end
end

def valid_play?(board_status, play)
  (1..9).any?(play) ? available_plays?(board_status)[play - 1] : false
end

def open_board(board_status)
  plays = []
  available_plays?(board_status).each_with_index do |bool, idx|
    plays << (idx + 1) if bool
  end
  plays
end

def update_board(board_status, play)
  while !valid_play?(board_status, play)
    play = get_move(true)
  end
  board_status[play] = PLAYER_MOVE
end

def get_move(error=false)
  prompt("gen error message") if error
  prompt('enter move')
  gets.chomp.to_i
end

def computer_move(board_status)
  score_hash = minimax(board_status)
  binding.pry
  board_status[score_hash.key(score_hash.values.min)] = COMPUTER_MOVE
  #board_status[open_board(board_status).sample] = COMPUTER_MOVE
end

def game_over?(board_status)
  board_full?(board_status) || winner(board_status)
end

def board_full?(board_status)
  available_plays?(board_status).all?(false)
end

def three_in_row?(ary, string, board_status)
  ary.map do |idx|
    board_status[idx]
  end.all?(string)
end

def winner(board_status)
  WINNING_MOVES.each do |ary|
    return 'player' if three_in_row?(ary, PLAYER_MOVE, board_status)
    return 'computer' if three_in_row?(ary, COMPUTER_MOVE, board_status)
  end
  nil
end

def play_location(board_status)
  list = available_plays?(board_status)
  (1..9).select { |num| list[num - 1] }
end

def joinor(ary, sep = ', ', concat = 'or')
  concat += ' '
  clone_array = ary.clone
  clone_array[-1] = (concat + clone_array[-1].to_s)
  if clone_array.count > 2
    prompt(clone_array.join(sep))
  else
    prompt(clone_array.join(' '))
  end
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

def intro
  clear_screen
  prompt(MESSAGES['intro'])
  print_hello_name(name_request)
  print_rules
end

def print_round(round_number)
  clear_screen
  prompt("Round #{round_number + 1}")
end

def score(brd)
  return 100 if winner(brd) == "computer"
  return -100 if winner(brd) == "player"
  return 0
end

def minimax(brd, player_is_comp = true)
  #computer = “X” 
  move = {}
  bestMove = {}
  
  availSpots = open_board(brd)
  return 0 if availSpots.length == 0

  availSpots.each do |cell| 
    brd[cell] = player_is_comp ? COMPUTER_MOVE : PLAYER_MOVE
    moves = score(brd)
    move[cell] = minimax(brd, !player_is_comp)
    brd[cell] = AVAILABLE_MOVE
    #binding.pry
    if player_is_comp
      bestMove =  [move[cell], moves].max
    else
      bestMove =  [move[cell], moves].min
    end
  end
  bestMove
end

# main script
intro
loop do
  number_of_rounds.times do |round|
    board_marks = initialize_board
    loop do
      print_round(round)
      display_board(board_marks)
      prompt("The following moves are available")
      joinor(play_location(board_marks))
      update_board(board_marks, get_move)
      # binding.pry
      computer_move(board_marks)
      break if game_over?(board_marks)
    end
    puts "game over"
    if winner(board_marks)
      puts "#{winner(board_marks)} WINS"
    else
      puts "It's a tie"
    end
    puts "hit any key to start next round"
    gets
  end
  break unless go_again?
end
