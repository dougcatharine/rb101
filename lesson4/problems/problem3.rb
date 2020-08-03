# problem3.rb
# Doug Catharine
# 20200803


ages = { "Herman" => 32, "Lily" => 30, "Grandpa" => 402, "Eddie" => 10 }
#remove people with age 100 and greater.

ages.select do |k,v|
  v>100
end
