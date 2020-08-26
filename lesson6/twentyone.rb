# twentyone.rb
# Doug Catharine
# 20200826

require 'pry'

SUITS = %w(clubs spades diamonds hearts)
VALUES = %w(2 3 4 5 6 7 8 9 10 J Q K A)




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
    cards_on_table[:player] << deal_card(deck)
    cards_on_table[:computer] << deal_card(deck)
  end
  cards_on_table
end

# 3. Player turn: hit or stay
def clear_score
  score = Hash.new
  score[:player] = 0
  score[:computer] = 0
  score
end

def total_cards(cards_on_table, score)

  score.each_key do |k|
    total = 0
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
  puts "player has #{score[:player]}, computer shows a #{cards_on_table[:computer][0][1]} of #{cards_on_table[:computer][0][0]}"
  binding.pry
end

def hit(cards_on_table,deck, user)
cards_on_table[user] << deal_card(deck)
cards_on_table
end

# main loop
score = clear_score
deck = shuffle_deck
delt_cards = deal_cards(deck)
# total_cards(delt_cards,score)
display_score(delt_cards, score)
puts "would you like to hit"
answer = gets.chomp
if answer.eql?('y')
  delt_cards= hit(delt_cards,deck, :player)
  display_score(delt_cards, score)
  puts "You have #{score[:player]}"
  puts "You Busted" if score[:player]>21
end


