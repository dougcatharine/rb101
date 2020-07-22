# repeat_yourself_solution1.rb
# Doug Catharine
# 20200721

=begin 
PEDAC


Problem
  Inputs 2- 1 string 1 positive intiger
  Outputs strings n times
  Requierments
    Implicit new line each string
    Explicit print string x times
  Clarifing Questions zero?, no string input?
  Mental Model
    use integer to repeat string n times

Examples/ Test Case
  Work the boundary conditions
  FROZEN  fractions really big/small one/ neg one zero even negative
  repeat_yourself('hello',1) >> hello
  repeat_yourself('hello',3) >> hello
                                hello
                                hello
Data structure

Algorithm
  plain text from mental model

  function(string, int)
   int times print string new line

=end

#code
def repeat_yourself(string_in,rep)

  for i in 1..rep
    puts string_in
  end
end

def repeat_yourself2(string_in, rep)

  while rep>0
    puts string_in
    rep -=1
  end
end

def better_repeater(string_in, rep)
  rep.times{ puts string_in}
end
repeat_yourself('hello', 1)
repeat_yourself2('test',2)
better_repeater('hello', 5)