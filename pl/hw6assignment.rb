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
  # The constant All_My_Pieces should be declared here

  # your enhancements here

end

class MyBoard < Board
  
  # def initialize (game)
  #   super
  # end

  # rotates the current piece by 180 degrees
  def rotate_180
    if !game_over? and @game.is_running?
      @current_block.move(0, 0, -1)
      @current_block.move(0, 0, -1)
    end
    draw
  end
end
