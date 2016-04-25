require_relative "board"
require_relative "player"

class BattleshipGame
  attr_reader :board, :player
  def initialize(player = HumanPlayer.new, board = Board.random)
    @player = player
    @board = board
  end
  def play
    board.place_random_ship
    until board.won?
      board.display
      player_input = player.get_play
      puts "Player said #{player_input}"
      puts "#{board.grid} is the grid"
      puts "#{board.count} is the number of ships"
    end
  end
  def [](pos)
    x, y = pos
    board.grid[x][y]
  end

  def []=(pos,mark)
    x, y = pos
    # p "#{x} is x and #{y} is y and #{mark} is mark"
    board.grid[x][y] = mark
  end

  def attack(pos)
    self[pos] = :x
  end

  def count
    board.count
  end

  def game_over?
    board.won?
  end

  def play_turn
    pos = player.get_play
    p "#{pos} is what pos"
    attack(pos)
  end
end

if __FILE__ == $PROGRAM_NAME
  BattleshipGame.new.play
end
