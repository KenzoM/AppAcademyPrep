def reverser
  yield.split(" ").map{|x| x.reverse}.join(" ")
end

def adder(plus = 1)
  yield + plus
end

def repeater(count = 1)
  index =  0
  until index == count
    index += 1
    yield
  end
end
