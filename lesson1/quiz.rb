def string_lengths(sentence)
  strings = sentence.split

  strings.map { |chars| chars.length }
end

def string_lengths1(sentence)
  strings = sentence.split
  lengths = []

  strings.each do |string|
    lengths << string.size
  end
end


def string_lengths2(sentence)
  words = sentence.split
  word_lengths = []
  counter = 0

  while counter < words.size do
    word_lengths << words[counter].length
    counter += 1
  end

  word_lengths
end


def string_lengths3(sentence)
  strings = sentence.split
  lengths = []
  counter = 1

  until counter == strings.size do
    word_length = strings[counter - 1].length
    lengths.push(word_length)
    counter += 1
  end

  lengths
end
str = "To be or Not to BE"
p string_lengths(str)
p string_lengths1(str)
p string_lengths2(str)
p string_lengths3(str)
