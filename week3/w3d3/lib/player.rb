require_relative "board"
require_relative "battleship"
class HumanPlayer
  attr_accessor :name
  def initialize(name = "Kenzo")
    @name = name
  end

  def get_play
    puts "Choose a position?"
    gets.chomp.split(",").map { |el| Integer(el) }
  end
end
