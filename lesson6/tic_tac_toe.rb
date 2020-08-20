# tic_tac_toe.rb
# Doug Catharine
# 20200816

require 'pry'

PLAYER_MOVE = 'X'
COMPUTER_MOVE = 'O'
AVAILABLE_MOVE = ' '
WINNING_MOVES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                [[1, 5, 9], [3, 5, 7]]

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

def header
  puts '   |   |   '
end

def footer
  puts '---+---+---'
end

def display_row(disp_hsh, row_array)
  puts " #{disp_hsh[row_array[0]]} \
| #{disp_hsh[row_array[1]]} | \
#{disp_hsh[row_array[2]]} "
end

def display_board(display_hash)
  system 'clear'
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
  puts "gen error message" if error
  puts 'enter move'
  gets.chomp.to_i
end

def computer_move(board_status)
  board_status[open_board(board_status).sample] = COMPUTER_MOVE
  display_board(board_status)
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
  if clone_array.count > 2
    clone_array[-1] = (concat + clone_array[-1].to_s)
    puts clone_array.join(sep)
  else
    clone_array[-1] = (concat + clone_array[-1].to_s)
    puts clone_array.join(' ')
  end
end

# main script
# intro

loop do
  board_marks = initialize_board
  display_board(board_locations)
  loop do
    puts "#{joinor(play_location(board_marks))} "
    update_board(board_marks, get_move)
    computer_move(board_marks)
    break if game_over?(board_marks)
  end
  puts "game over"
  if winner(board_marks)
    puts "#{winner(board_marks)} WINS"
  else
    puts "It's a tie"
  end
  puts "do you want to play again"
  answer = gets.chomp
  break unless answer.downcase.start_with('y')
end
