class Player
  attr_reader :turn, :symbol

  def initialize symbol
    @symbol = symbol
    @turn = false
  end

  def make_move board, coord
    row = coord[0]
    column = coord[1]
    board.place_token symbol, row, column
  end
end