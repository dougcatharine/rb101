# tic_tac_toe.rb
# Doug Catharine
# 20200816

board_marks = { 1 => 1, 2 => 2, 3 => 3,
                4 => 4, 5 => 5, 6 => 6,
                7 => 7, 8 => 8, 9 => 9 }

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
  display_row(display_hash, [1, 2, 3])
  footer
  display_row(display_hash, [4, 5, 6])
  footer
  display_row(display_hash, [7, 8, 9])
end

def available_plays?(board_status)
  board_status.map do |_, v|
    v.class == Integer
  end
end

def valid_play?(board_status, play)
  available_plays?(board_status)[play]
end

def open_board(board_status)
  plays = []
  available_plays?(board_status).each_with index do | bool, index |
    plays << index if bool
  end
end

# main script
display_board(board_marks)
# intro

puts 'enter move'
move = gets.chomp.to_i

if valid_play?(board_marks, move)
  board_marks[move] = 'x'
else
  puts 'invalid move'
end
display_board(board_marks)
#validate move
