class Board
  attr_reader :spaces
  def initialize 
    @spaces = build_board
  end

  def place_token symbol, row, column
    spaces[row][column] = symbol
  end

  def validate_input row, column
    if (row >= 0 && row <= 2) || (column >= 0 && column <= 2)
      spaces[row][column] ? false : true
    else 
      return false
    end
  end

  def build_board
    Array.new(3) {Array.new(3, false)}
  end

  def print_board
    spaces.each do |row|
      row_display = ""
      row.each do |space|
        space ? row_display += "_#{space}_|" : row_display += "___|"
      end
      puts row_display
    end
  end
end
