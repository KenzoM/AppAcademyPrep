class ComputerPlayer
  attr_reader :name, :board
  attr_accessor :mark
  def initialize(name)
    @name = name
  end
  def display(board)
    @board = board
  end
  def get_move
    #lets find all possible combinations available
    all_possible_moves = []
    (0..2).each do |row|
      (0..2).each do |col|
        if board[row,col].nil?
          all_possible_moves  << [row,col]
        end
      end
    end
    all_possible_moves.each do |move|
      return move if wins?(move)
    end
    all_possible_moves.shuffle
  end

  def wins?(move)
    board[*move] = mark # review the splat operator...VERY IMPORTANT!!!
    if board.winner == mark
      board[*move] = nil #reset it!
      true
    else
      board[*move] = nil #reset it
      false
    end
  end
end
