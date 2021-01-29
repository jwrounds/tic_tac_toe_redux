require_relative '../lib/tic_tac_toe_player.rb'
require_relative '../lib/tic_tac_toe_board.rb'

class Game
  attr_reader :three_in_row, :full
  def initialize 
    @three_in_row = false
    @full = false
  end

  def game_over? 
    three_in_row || full ? true : false
  end

  def check_row
    
  end
end
