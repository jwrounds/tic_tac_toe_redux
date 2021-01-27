class Game
  def initialize 
    @three_in_row = false
    @full = false
  end

  def game_over? 
    @three_in_row || @full ? true : false
  end
end
