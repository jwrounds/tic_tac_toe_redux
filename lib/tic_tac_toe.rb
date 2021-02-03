require_relative '../lib/tic_tac_toe_player.rb'
require_relative '../lib/tic_tac_toe_board.rb'

class Game
  attr_reader :board
  attr_accessor :full, :three_in_row

  def initialize(board: Board.new) 
    @three_in_row = false
    @full = false
    @board = board
  end

  def game_over? 
    three_in_row || full ? true : false
  end

  def spaces
    board.spaces
  end

  def check_row row
    column = 0
    memo = spaces[row][column]
    2.times do 
      column += 1
      new_space = spaces[row][column]
      new_space == memo ? memo = new_space : memo = false
    end
    @three_in_row = memo
  end

  def check_column column

  end

end

