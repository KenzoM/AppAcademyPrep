require_relative 'board'
require_relative 'human_player'
require_relative 'computer_player'

class Game
  attr_accessor :board, :current_player, :player_one, :player_two
  def initialize(player_one,player_two)
    @player_one = player_one
    @player_two = player_two
    player_one.mark = :X
    player_two.mark = :O
    @current_player = player_one
    @board = Board.new
  end
  def begin
    system('clear')
    puts "Lets start the game!"
    current_player.display(board)
    until board.over?
      play_turn
    end
  end
  def play_turn
    board.place_mark(current_player.get_move, current_player.mark)
    switch_players!
  end
  def switch_players!
    self.current_player = current_player == player_one ? player_two : player_one
  end
end

if $PROGRAM_NAME == __FILE__ ##there is a bug..it wont run because of :mark
  bob = HumanPlayer.new('Bob')
  barry = ComputerPlayer.new('Barry')
  new_game = Game.new(bob, barry)
  new_game.begin
end
