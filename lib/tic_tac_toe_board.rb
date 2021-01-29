class Board
  attr_reader :board
  def initialize 
    @board = build_board
  end

  def place_token symbol, row, column
    board[row][column] = symbol
  end

  def build_board
    Array.new(3) {Array.new(3, false)}
  end

end