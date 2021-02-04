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

  def check_row
    3.times {|i| check_three_in_row(row: true, start_x: i)} 
  end

  def check_column 
    3.times {|i| check_three_in_row(column: true, start_y: i)}
  end

  def check_diagonal
    check_three_in_row(diagonal_left: true)
    check_three_in_row(diagonal_right: true, start_y: 2)
  end

  def check_three_in_row(row: false, column: false, diagonal_left: false, diagonal_right: false, start_x: 0, start_y: 0)
    x = start_x
    y = start_y
    memo = spaces[x][y]

    2.times do 

      case 
        when row
          y += 1
        when column
          x += 1
        when diagonal_left
          x += 1
          y += 1
        when diagonal_right
          x += 1
          y -= 1
      end

      new_space = spaces[x][y]
      new_space == memo ? memo = new_space : memo = false
    end
    @three_in_row = memo if memo
  end

end

