# University of Washington, Programming Languages, Homework 6, hw6runner.rb

# This is the only file you turn in, so do not modify the other files as
# part of your solution.

# Ruby instance variables are private
# I think I need to reimplement each initialize method and call super

class MyTetris < Tetris
  def initialize
    super
    set_board
  end
  
  def set_board
    @canvas = TetrisCanvas.new
    @board = MyBoard.new(self)
    @canvas.place(@board.block_size * @board.num_rows + 3,
                  @board.block_size * @board.num_columns + 6, 24, 80)
    @board.draw
  end
  
  def key_bindings
    super
    
    # Rotates the keys by 180 degrees
    @root.bind('u', proc {@board.rotate_180})
  end
end

class MyPiece < Piece
  # class method to choose the next piece
  def self.next_piece (board)
    MyPiece.new(All_My_Pieces.sample, board)
  end
  
  # Returns the size of the piece
  def size
    @all_rotations[0].size
  end
  
  # class array holding all 10 pieces and their rotations
  All_My_Pieces = [[[[0, 0], [1, 0], [0, 1], [1, 1]]],  # square (only needs one)
                  rotations([[0, 0], [-1, 0], [1, 0], [0, -1]]), # T
                  [[[0, 0], [-1, 0], [1, 0], [2, 0]], # long (only needs two)
                  [[0, 0], [0, -1], [0, 1], [0, 2]]],
                  rotations([[0, 0], [0, -1], [0, 1], [1, 1]]), # L
                  rotations([[0, 0], [0, -1], [0, 1], [-1, 1]]), # inverted L
                  rotations([[0, 0], [-1, 0], [0, -1], [1, -1]]), # S
                  rotations([[0, 0], [1, 0], [0, -1], [-1, -1]]), # Z
                  rotations([[0, 0], [0, 1], [1, 1]]),  # Short L
                  [[[0, 0], [-1, 0], [1, 0], [2, 0], [3, 0]], # new long (only needs two)
                   [[0, 0], [0, -1], [0, 1], [0, 2], [0, 3]]],
                  rotations([[0, 0], [0, -1], [0, 1], [1, 1], [1, 0]]), # new square
                  rotations([[0, 0], [0, -1], [0, 1], [-1, 1], [-1, 0]])] # inverted new square
end

class MyBoard < Board
  def initialize (game)
    super(game)
    @current_block = MyPiece.next_piece(self)
  end

  # gets the next piece
  def next_piece
    @current_block = MyPiece.next_piece(self)
    @current_pos = nil
  end
  
  # Overrides store_current in superclass to allow pieces with variable sizes.
  def store_current
    locations = @current_block.current_rotation
    displacement = @current_block.position
    (0..@current_block.size - 1).each{|index|
      current = locations[index];
      @grid[current[1]+displacement[1]][current[0]+displacement[0]] = 
      @current_pos[index]
    }
    # remove_filled
    @delay = [@delay - 2, 80].max
  end

  # rotates the current piece by 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, -1)
      @current_block.move(0, 0, -1)
    end
    draw
  end
end
