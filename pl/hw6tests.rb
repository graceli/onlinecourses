require "test/unit"

require_relative './hw6provided'
require_relative './hw6assignment'

def runTetris
	Tetris.new
	mainLoop
end

def runMyTetris
	MyTetris.new
	mainLoop
end

# TODO: explore ruby unit testing
# which is easier to use and why?
# TODO: try writing the unit test in rspec
# TODO: try writing in minitest
class TestMyTetris < Test::Unit::TestCase
	def setup
		@game = MyTetris.new
		# see forums for how to get an instance variable from the class for unit testing
	end

	def test_num_pieces
		assert_equal(10, MyPiece::All_My_Pieces.size)
	end

	def test_rotation
		# simulate key press
		# test that two rotations occurred (absolute value of index is 2)	
	end

	def test_cheating
		# simulate keypress
		# check that the score has 100 deducted
		# check that we are cheating
		# check that the next piece is a single square
	end

	def test_cheat_twice
		# simulate keypress
		# save the score
		# cheat again
		# check that the score stayed the same
	end
end
