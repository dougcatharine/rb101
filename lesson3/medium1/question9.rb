# question9.rb
# Doug Catharine.rb
# 20200730

#Consider these two simple methods:

def foo(param = "no")
  "yes"
end

def bar(param = "no")
  param == "no" ? "yes" : "no"
end
#What would be the return value of the following method invocation?

p bar(foo)

#no