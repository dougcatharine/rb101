# odd_solution1.rb
# Doug Catharine
# 20200721



=begin 
PEDAC


Problem
  Inputs 
    1 integer pos neg zero
  Outputs 
    Boolean
  Requierments
    Implicit 
      pos neg zero
    Explicit 
      Intiger
  Clarifing Questions 
  Mental Model
    return boolean if intiger is odd

Examples/ Test Case
  Work the boundary conditions
  FROZEN  fractions really big/small one/ neg one zero even negative
  is_odd?(-1) >> true
  is_odd?(0) >> false
  is_odd?(1) >> true

Data structure
intiger in bool out

Algorithm
  pseudo code

  funtion(intiger)
  (integer+2)%%2 == 1 || (integer-2)%%-2
  end 

=end

def is_odd?(int)
  (int % 2 == 1) || (int % -2 ==1 )
end

# turns out explicit work not necesary below will work as well

def is_odder?(int)
  int % 2 == 1
end

puts is_odd?(2)
puts is_odd?(5)
puts is_odd?(-17)
puts is_odder?(-8)
puts is_odder?(0)
puts is_odder?(7)

