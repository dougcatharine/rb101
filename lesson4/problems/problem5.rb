# problem5.rb
# Doug Catharine
# 20200803

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)

# Find the index of the first name that starts with "Be"

flintstones.index do |name|
  name[0,2].eql?('Be')
end

