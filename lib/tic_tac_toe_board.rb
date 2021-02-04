class Board
  attr_reader :spaces
  def initialize 
    @spaces = build_board
  end

  def place_token symbol, row, column
    spaces[row][column] = symbol
  end

  def build_board
    Array.new(3) {Array.new(3, false)}
  end

  def print_board
    spaces.each do |row|
      row_display = ""
      row.each do |space|
        space ? row_display += `_#{space}_|` : row_display += "___|"
      end
      puts row_display
    end
  end

end
