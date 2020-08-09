# pp5.rb
# Doug Catharine
# 20200808

munsters = {
  "Herman" => { "age" => 32, "gender" => "male" },
  "Lily" => { "age" => 30, "gender" => "female" },
  "Grandpa" => { "age" => 402, "gender" => "male" },
  "Eddie" => { "age" => 10, "gender" => "male" },
  "Marilyn" => { "age" => 23, "gender" => "female"}
}
# figure out the total age of just the male members of the family.
total_age = 0
munsters.each_value do |v|
  total_age += v["age"] if v["gender"] == "male"
end
puts total_age