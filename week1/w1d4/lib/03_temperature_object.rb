class Temperature
  attr_accessor :temp
  def initialize(temp = {})
    @temp = temp
  end

  def self.from_celsius(temp)
      Temperature.new(c: temp)
  end

  def self.from_fahrenheit(temp)
      Temperature.new(f: temp)
  end

  def in_fahrenheit
    if @temp.has_key?(:f)
      @temp[:f]
    else
      answer = (9.0/5.0)*@temp[:c] + 32
    end
  end

  def in_celsius
    if @temp.has_key?(:c)
        answer = @temp[:c]
    else
        answer = (5.0/9.0) * (@temp[:f] - 32)
    end
  end
end

class Celsius < Temperature
    def initialize(temp)
        @temp = {c:temp}
    end
    def in_celsius
        super
    end
    def in_fahrenheit
        super
    end
end

class Fahrenheit < Temperature
    def initialize(temp)
        @temp = {f:temp}
    end
    def in_celsius
        super
    end
    def in_fahrenheit
        super
    end
end
