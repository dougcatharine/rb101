# pp16.rb
# Doug Catharine
# 20200809

#A UUID is a type of identifier often used as a way to uniquely identify items...which may not all be created by the same system. That is, without any form of synchronization, two or more separate computer systems can create new items and label them with a UUID with no significant chance of stepping on each other's toes.

#It accomplishes this feat through massive randomization. The number of possible UUID values is approximately 3.4 X 10E38.

#Each UUID consists of 32 hexadecimal characters, and is typically broken into 5 sections like this 8-4-4-4-12 and represented as a string.

#It looks like this: "f65c57f6-a6aa-17a8-faa1-a67f2dc9fa91"

#Write a method that returns one UUID when called with no parameters.
def create_uuid
  hex_array = []
  uuid = []
  structure = [8,4,4,4,12]

  (0..9).each { |num| hex_array << num.to_s }
  ('a'..'f').each { |num| hex_array << num}
  structure.each do |inx|
    uuid << hex_array.sample(inx).join
  end
  uuid.join("-")
end
    

p create_uuid


def create_uuid
  require 'securerandom'
  uuid = []
  structure = [8,4,4,4,12]
  structure.each do |inx|
    uuid << SecureRandom.hex(inx/2)
  end
  uuid.join("-")
end
    

p create_uuid

def create_uuid
  require 'securerandom'
  SecureRandom.uuid
end

p create_uuid