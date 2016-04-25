class Board
  LEGENDS = {
    nil => " ",
    :s => " ",
    :x => "x"
  }
  attr_accessor :grid
  def initialize(grid = Board.default_grid) #is this the samething with self.class.default_grid?
    @grid = grid
  end

  def self.random
    self.new(self.default_grid)
  end

  def [](pos)
    x, y = pos
    grid[x][y]
  end

  def []=(pos, val)
    x, y = pos
    grid[x][y] = val
  end

  def self.default_grid
     Array.new(10) { Array.new(10) }
  end

  def count
    grid.flatten.select { |el| el == :s }.length ##REFACTORED!!
  end
  def empty?(position = nil)
    if position
      self[position].nil?
    else
      count == 0
    end
  end
  def full?
    grid.flatten.none?(&:nil?)
  end
  def place_random_ship
    raise StandardError if full?
    new_pos = random_pos
    until empty?(new_pos) ##good trick!
      new_pos = random_pos
    end
    self[new_pos] = :s
  end
  def random_pos
    [rand(grid.size), rand(grid.size)]
  end
  def won?
    grid.flatten.include?(:s) ? false :  true
  end
  def display
    header = (0..(grid.length - 1)).to_a.join("  ")
    p "  #{header}"
    grid.each_with_index { |row, i| display_row(row, i) }
    #it's important to note that in #display, the messages
    #passes on #display_row .. Object Oriented -- inject independency
  end

  def display_row(row, i)
    chars = row.map { |el| LEGENDS[el] }.join("  ")
    p "#{i} #{chars}"
  end
  def in_range?(pos)
    pos.all? { |x| x.between?(0, grid.length) }
  end
end
