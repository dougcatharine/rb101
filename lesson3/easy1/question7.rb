# question7.rb
# Doug Catharine
# 20200729


# If we build an array like this:
flintstones = ["Fred", "Wilma"]
flintstones << ["Barney", "Betty"]
flintstones << ["BamBam", "Pebbles"]
#We will end up with this "nested" array:

#["Fred", "Wilma", ["Barney", "Betty"], ["BamBam", "Pebbles"]]
print flintstones
puts
print flintstones.flatten!