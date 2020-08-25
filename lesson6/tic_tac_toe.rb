# tic_tac_toe.rb
# Doug Catharine
# 20200816 V1.0  working game
# 20200821 V2.0  minimax version
# 20200825 V2.1  refactored

require 'yaml'
MESSAGES = YAML.load_file('ttt_messages.yml')
LINE_WIDTH = 80
MINIMAX_VAL = 999

PLAYER_MOVE = 'X'
COMPUTER_MOVE = 'O'
AVAILABLE_MOVE = ' '
WINNING_MOVES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]
score = { player: 0, computer: 0 }

def clear_screen
  system('clear') || system('cls')
end

def prompt(message)
  puts "=> #{message}"
end

def response_prompt(message)
  print "#{message}:"
end

def intro
  clear_screen
  prompt(MESSAGES['intro'])
end

def name_valid?(first_name)
  !first_name.strip.empty?
end

def validate_name(first_name)
  while !name_valid?(first_name)
    prompt(MESSAGES['name_error'])
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

def print_hello_name(first_name)
  clear_screen
  prompt("Hello, #{first_name}.")
end

def send_to_right(message)
  puts message.rjust(LINE_WIDTH)
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

def print_rules
  display_board(board_locations)
  prompt(MESSAGES['rules1'])
  prompt(MESSAGES['rules2'])
  prompt(MESSAGES['rules3'])
  prompt(MESSAGES['rules4'])
end

def get_number(error=false)
  prompt(MESSAGES['number_error']) if error
  response_prompt('enter number')
  gets.chomp
end

def validate_number(number)
  while !((number == number.to_i.to_s) && (number.to_i > 0))
    number = get_number(true)
  end
  number.to_i
end

def number_of_rounds
  prompt(MESSAGES['rounds'])
  validate_number(get_number)
end

def board_locations
  brd = {}
  (1..9).each { |k| brd[k] = k.to_s }
  brd
end

def initialize_board
  brd = {}
  (1..9).each { |k| brd[k] = AVAILABLE_MOVE }
  brd
end

def print_round(round_number, tot_round, score, first_name)
  clear_screen
  l_col = "Round #{round_number + 1} of #{tot_round}.  You are #{PLAYER_MOVE}"
  r_col = "#{first_name} #{score[:player]} | EVE  #{score[:computer]}"
  space = LINE_WIDTH - (l_col.length + r_col.length)
  space.times { l_col << ' ' }
  puts l_col + r_col
  puts
end

def available_plays?(brd)
  brd.map do |_, v|
    v.eql?(AVAILABLE_MOVE)
  end
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

def print_avail_moves(brd)
  prompt("The following moves are available")
  joinor(play_location(brd))
end

def open_board(brd)
  plays = []
  available_plays?(brd).each_with_index do |bool, idx|
    plays << (idx + 1) if bool
  end
  plays
end

def valid_play?(brd, play)
  (1..9).any?(play) ? available_plays?(brd)[play - 1] : false
end

def get_move(error=false)
  prompt(MESSAGES['move_error']) if error
  prompt('enter move')
  gets.chomp
end

def score(brd)
  return 1 if winner(brd) == "computer"
  return -1 if winner(brd) == "player"
  0
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

def game_over?(board_status)
  board_full?(board_status) || winner(board_status)
end

def minimax(brd, player_is_computer = false)
  return score(brd) if game_over?(brd)
  champion = player_is_computer ? -MINIMAX_VAL : MINIMAX_VAL
  open_board(brd).each do |cell|
    brd[cell] = player_is_computer ? COMPUTER_MOVE : PLAYER_MOVE
    challanger = minimax(brd, !player_is_computer)
    brd[cell] = AVAILABLE_MOVE
    champion = if player_is_computer
                 [challanger, champion].max
               else
                 [challanger, champion].min
               end
  end
  champion
end

def computer_move(brd)
  champion = -MINIMAX_VAL
  move = nil
  open_board(brd).each do |cell|
    brd[cell] = COMPUTER_MOVE
    challanger = minimax(brd)
    brd[cell] = AVAILABLE_MOVE
    if challanger > champion
      champion = challanger
      move = cell
    end
  end
  brd[move] = COMPUTER_MOVE
end

def update_board(brd, play)
  while !valid_play?(brd, play)
    play = validate_number(get_move(true))
  end
  brd[play] = PLAYER_MOVE
  computer_move(brd)
end

def enter_to_go
  puts "hit enter/return to start next round"
  gets
end

def print_winner(brd, points)
  prompt("Round over")
  if winner(brd)
    prompt("#{winner(brd)} WINS")
    winner(brd) == "computer" ? points[:computer] += 1 : points[:player] += 1
  else
    prompt("It's a tie")
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
    prompt(MESSAGES['yes_no_error'])
  end
end

# main script
intro
print_hello_name(name = name_request)
print_rules
loop do
  (total_rounds = number_of_rounds).times do |round|
    board = initialize_board
    loop do
      print_round(round, total_rounds, score, name)
      display_board(board)
      print_avail_moves(board)
      update_board(board, validate_number(get_move))
      break if game_over?(board)
    end
    clear_screen
    print_winner(board, score)
    enter_to_go unless (round + 1) == total_rounds
  end
  break unless go_again?
end
prompt(MESSAGES['good_bye'])
