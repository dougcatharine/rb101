# problem2.rb
# Doug Catharine
# 20200803

# Add up all of the ages from the Munster family hash:

ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 5843, "Eddie" => 10, "Marilyn" => 22, "Spot" => 237 }
age = 0
ages.each_value {|val| age +=val}
puts age
