# pry_example.rb
# Doug Catharine
# 20200723

require "pry"

counter = 0

loop do
  counter += 1
  binding.pry
  break if counter == 5
end

# use Ctrl + D to continue moving or "exit-program" to exit
