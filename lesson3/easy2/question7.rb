# question7.rb
# Doug Catharine
# 20200729

flintstones = %w(Fred Barney Wilma Betty BamBam Pebbles)
flintstones << "Dino"
# We could have used either Array#concat or Array#push to add Dino to the family.

# How can we add multiple items to our array? (Dino and Hoppy)
print flintstones.append("Dino", "Hoppy")
flintstones.concat(%w(Dino Hoppy))  # concat adds an array rather than one item
flintstones.push("Dino").push("Hoppy") 