class Code
  PEGS = {
  "R" => :red,
  "G" => :green,
  "B" => :blue,
  "Y" => :yellow,
  "O" => :orange,
  "P" => :purple
}
  attr_reader :pegs, :answer_code
  def initialize(pegs)
    @pegs = pegs
  end

  def self.parse(str)
    pegs = []
    str.each_char do |color|
      raise StandardError if !PEGS.has_key?(color.upcase)
      pegs << PEGS[color.upcase]
    end
    Code.new(pegs)
  end

  def self.random
    random_code = []
    4.times do |random_color| ##REFACTOR THIS!!!!!!
      random_code << PEGS.values.sample
    end
    Code.new(random_code)
  end

  def [](index)
    @pegs[index]
  end

  def exact_matches(possible_match)
    #puts "#{pegs} vs #{possible_match.pegs}"
    count_matches = 0
    pegs.each_with_index do |color1, idx1|
      possible_match.pegs.each_with_index do |color2, idx2|
        count_matches += 1 if color1 == color2 && idx1 == idx2
      end
    end
    count_matches
  end

  def near_matches(possible_match)
    possible_match_counts = possible_match.color_counts
    near_matches = 0
    self.color_counts.each do |color, count|
      next if !possible_match_counts.has_key?(color)
      near_matches += [count, possible_match_counts[color]].min
    end
    near_matches - exact_matches(possible_match)
  end

  def color_counts
    color_count = Hash.new(0)
    @pegs.each do |key|
      color_count[key] += 1
    end
    color_count
  end

  def ==(other_code)
    other_code == self.pegs ? true : false
  end
end

class Game
  MAX_GUESSES = 5
  attr_reader :secret_code

  def initialize (secret_code = Code.random)
    @secret_code = secret_code
  end

  def get_guess
    puts "Care to guess the right code?"
    begin
      Code.parse(gets.chomp)
    rescue
      puts "Error parsing code!"
    retry
    end
  end

  def display_matches(guess)
    exact_matches = @secret_code.exact_matches(guess)
    near_matches = @secret_code.near_matches(guess) #review on this

    puts "You got #{exact_matches} exact matches!"
    puts "You got #{near_matches} near matches!"
  end

  def lets_play
    MAX_GUESSES.times do |left_guess|
      puts "Remaining guesses : #{remaining_guess(left_guess)}"
      guess = get_guess
      break if win?(guess)
      display_matches(guess)
      # puts "HINT: answer is #{secret_code.pegs}"
    end
  end

  def remaining_guess(left_chances)
    5-left_chances
  end

  def win?(guess)
    secret_code == guess ? true : false
  end
end

if __FILE__ == $PROGRAM_NAME
  system('clear')
  puts "Let's play Mastermind!"
  Game.new.lets_play
end
