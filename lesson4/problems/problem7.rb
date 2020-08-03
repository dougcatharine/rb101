# problem7.rb
# Doug Catharine
# 20200803

#Create a hash that expresses the frequency with which each letter occurs in this string:

statement = "The Flintstones Rock"
#ex:

#{ "F"=>1, "R"=>1, "T"=>1, "c"=>1, "e"=>2, ... }
#new_hash = Hash.new
#statement.each_char do |let|
#  new_hash[let].has_key? ? new_hash[let] += 1 : new_hash[let] = 1
#end

# solution
result = {}
letters = ('A'..'Z').to_a + ('a'..'z').to_a
letters.each do |letter|
  letter_frequency = statement.scan(letter).count
  result[letter] = letter_frequency if letter_frequency > 0
end