# question8.rb
# Doug Catharine
# 20200729


# Shorten this sentence:
advice = "Few things in life are as important as house training your pet dinosaur."

# ...remove everything starting from "house".


advice.slice!(0, advice.index('house'))