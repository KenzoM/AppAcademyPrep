require_relative "board"
require_relative "battleship"
class HumanPlayer
  attr_accessor :name
  def initialize(name = "Kenzo")
    @name = name
  end

  def prompt
      puts "User, please enter position"
  end

  def get_play
    prompt
    puts "Ex: 0,0 or 4,6"
    gets.chomp.split(",").map { |el| Integer(el) }
  end
end
