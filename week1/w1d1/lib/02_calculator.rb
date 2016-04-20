def add(num1,num2)
    num1 + num2
end

def subtract(num1,num2)
    num1 - num2
end

def sum(arr)
    arr.inject(0){|accum,x| accum + x}
end

def multiply(*numbers)
    numbers.inject(1){|accum,x| accum * x}
end

def p_nth(base,power)
    base ** power
end

def factorial(number)
    return 1 if number == 0 #recursion
    number * factorial(number - 1)
end
