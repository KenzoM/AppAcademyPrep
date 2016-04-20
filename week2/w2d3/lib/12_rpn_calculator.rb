class RPNCalculator
    attr_accessor :calculator
    def initialize
        @calculator= []
    end
    def push(number)
        @calculator.push(number)
    end

    def plus
        procedure(:+)
    end

    def minus
        procedure(:-)
    end

    def times
        procedure(:*)
    end

    def divide
        procedure(:/)
    end

    def procedure(type_operation)
        raise ArgumentError, "calculator is empty" if @calculator.size <= 1
        last_number = @calculator.pop
        if type_operation == :+
            answer = last_number + @calculator.last
        elsif type_operation == :-
            answer = @calculator.last - last_number
        elsif type_operation == :*
            answer = @calculator.last.to_f * last_number.to_f
        else
            answer = @calculator.last / last_number.to_f
        end
        @calculator[-1] = answer
    end

    def value
        @calculator.last
    end

    def tokens(string)
        characters = string.split(" ")
        operation_signs = %w{+ - * /}
        new = characters.map{|x| operation_signs.include?(x) ? x.to_sym : x.to_i}
    end

    def evaluate(string) # a classic stack memory question..study this again
        must_calculate = tokens(string)
        numbers = []
        must_calculate.each do |x|
            if x.class == Fixnum
                numbers << x
            else
                @calculator = numbers.pop(2) #pop the last two numbers
                numbers.push(procedure(x))
            end
        end
        return @calculator[0].to_f
    end
end
