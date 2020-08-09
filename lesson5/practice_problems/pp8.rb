# pp8.rb
# Doug Catharine
# 20200808

# Using the each method, write some code to output all of the vowels from the strings.

hsh = {first: ['the', 'quick'], second: ['brown', 'fox'], third: ['jumped'], fourth: ['over', 'the', 'lazy', 'dog']}

hsh.each do |k,v|
  v.each do |str|
    str.chars {|c| puts c if %w(a e i o u).any? {|vow| vow == c }}
  end
end

