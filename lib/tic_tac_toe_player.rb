class Player
  attr_reader :turn, :symbol

  def initialize symbol
    @symbol = symbol
    @turn = false
  end

  def make_move board, coord
    row = coord[0].to_i
    column = coord[1].to_i
    board.place_token symbol, row, column
  end
end