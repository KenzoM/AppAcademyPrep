

class Board
  attr_accessor :grid
  def initialize(grid = nil)
    if grid != nil
      @grid = grid
    else
      @grid = Array.new(3) { Array.new(3) }
    end
  end
  def [] (row,col)
    @grid[row][col]
  end

  def []= (row,col, val)
    @grid[row][col] = val
  end

  def place_mark(pos, mark)
    self[*pos]= mark #calling itself of its method
  end


  def empty?(pos)
    self[*pos].nil? ##you need def[](row,col) to define first!
  end

  def winner
    (@grid + cols + diag ).each do |win_combination|
      return :X if win_combination == [:X, :X, :X]
      return :O if win_combination == [:O, :O, :O]
    end
    nil
  end

  def over?
    !grid.flatten.any?{|x| x == nil} || winner
    ##realized the opposite of #any? method is #none? as shown in the solution
  end

  def cols
    cols = [[], [], []]
    @grid.each do |row|
      row.each_with_index do |mark, col_idx|
        cols[col_idx] << mark
      end
    end
    #the trick here is that if column is a possible win combination,
    #they all must have the same col_idx to work!
    #Future look: can it possible be done by simply transposing the matrix?
    cols
  end

  def diag #places all possible combination to win via diagonally
    down_diag = [[0, 0], [1, 1], [2, 2]]
    up_diag = [[0, 2], [1, 1], [2, 0]]

    [down_diag, up_diag].map do |diagonal|
      diagonal.map { |row, col| grid[row][col] }
    end
  end

end
