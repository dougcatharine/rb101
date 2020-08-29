# twentyone.rb
# Doug Catharine
# 20200826

require 'pry'
require 'yaml'
HEART = ?\u2661
DIAMOND = ?\u2662
SPADE = ?\u2660
CLUB = ?\u2663
MESSAGES = YAML.load_file('twenty_one.yml')

SUITS = [HEART, DIAMOND, SPADE, CLUB]
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)

def prompt(message)
  puts "=> #{message}"
end

def clear_screen
  system('clear') || system('cls')
end

# 1. Initialize deck
def shuffle_deck
  deck = Array.new
  SUITS.each do |suit|
    VALUES.each do |value|
      deck << [suit, value]
    end
  end
  deck
end

# 2. Deal cards to player and dealer
def deal_card(deck)
  deck.delete(deck.sample)
end

def deal_cards(deck)
  cards_on_table = Hash.new { |hash, key| hash[key] = [] }
  2.times do 
    # cards_on_table[:player] << deal_card(deck)
    cards_on_table[:player] << [HEART, 'A'] #deal_card(deck)
    # binding.pry
    cards_on_table[:dealer] << deal_card(deck)
  end
  cards_on_table
end

# 3. Player turn: hit or stay
def clear_score
  score = Hash.new
  score[:player] = 0
  score[:dealer] = 0
  score
end

def total_cards(cards_on_table, score)
  score.each_key do |k|
    total = 0
    score[k] = 0
    cards_on_table[k].each do |card|
      val = if %w(J Q K).any?(card[1])
              10
            elsif 'A'.eql?(card[1])
              11
            else
              card[1]
            end
      total += val.to_i
    end
    # binding.pry
    cards_on_table[k].select { |card| card[1] == 'A' }.count.times do
      total -= 10 if total > 21
    end
    score[k] += total
  end
  score
end




#   - repeat until bust or "stay"
# 4. If player bust, dealer wins.
# 5. Dealer turn: hit or stay
#   - repeat until total >= 17
# 6. If dealer bust, player wins.
# 7. Compare cards and declare winner.

def display_score(cards_on_table, score)
  score = total_cards(cards_on_table, score)
  #binding.pry
  print "Player holds"
  display_cards(cards_on_table[:player])
  puts "Player has a total of #{score[:player]}" 
  puts "Dealer shows a #{cards_on_table[:dealer][0][1]} #{cards_on_table[:dealer][0][0]}"
  #binding.pry
end

def display_cards(cards)
  cards.each do |card|
    # binding.pry
    print " #{card[1]}#{card[0]}"
  end
  puts '.'
end

def hit(cards_on_table,deck, user)
  cards_on_table[user] << deal_card(deck)
  cards_on_table
end

def player_is_winner?(score)
  !bust?(score[:player]) && greater_than_other?(score[:player], score[:dealer])
end

def bust?(points)
  points > 21
end

def draw?(score)
  score[:player] == score[:dealer]
end

def greater_than_other?(score_one, score_other)
  (score_one > score_other)
end

def hit?
  loop do
    prompt("Do you want another card")
    answer = gets.chomp.downcase
    if answer.downcase.eql?('y')
      return true
    elsif answer.downcase.eql?('n')
      return false
    end
    print_error('yes_no_error')
  end
end

def hit?
  loop do
    prompt(MESSAGES['hit'])
    answer = gets.chomp.downcase
    if answer.downcase.eql?('y')
      return true
    elsif answer.downcase.eql?('n')
      return false
    end
    prompt(MESSAGES['yes_or_no_error'])
  end
end

# main loop
clear_screen
score = clear_score
deck = shuffle_deck
delt_cards = deal_cards(deck)
# total_cards(delt_cards,score)
display_score(delt_cards, score)
while hit?
  clear_screen
  delt_cards= hit(delt_cards,deck, :player)
  display_score(delt_cards, score)
  puts "You have #{score[:player]}"
  #binding.pry
  if bust?(score[:player])
    puts "You Busted"
    puts "Dealer WON!"
    break
  end
end
puts "computer has score of #{score[:player]}"
while score[:dealer] < 17 && !bust?(score[:player])
  delt_cards = hit(delt_cards,deck, :dealer)
  score = total_cards(delt_cards, score)
  puts "Dealer has score of #{score[:dealer]}"
  #binding.pry
  if bust?(score[:dealer])
    puts "Dealer Busted"
    break
  end
end

if player_is_winner?(score)
  puts 'You Won'
elsif score[:player] == score[:dealer]
  puts "its a draw"
else
  puts "dealer wins"
end