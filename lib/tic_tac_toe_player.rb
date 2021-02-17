class Player
  attr_reader :symbol

  def initialize symbol
    @symbol = symbol
  end

  def make_move board, row, column
    board.place_token symbol, row, column
  end
end