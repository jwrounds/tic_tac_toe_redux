require_relative '../lib/tic_tac_toe_player.rb'
require_relative '../lib/tic_tac_toe_board.rb'

class Game
  attr_reader :board, :players
  attr_accessor :winner

  def initialize(board: Board.new, players: [Player.new('X'), Player.new('Y')]) 
    @winner = false
    @board = board
    @players = players
  end

  def game_over? 
    winner || check_full ? true : false
  end

  def spaces
    board.spaces
  end

  def check_full
    spaces.each do |row|
      return false if row.include?(false)
    end
    true
  end

  def check_winner
    check_row
    check_column
    check_diagonal
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

  def check_three_in_row(
                          row: false, 
                          column: false, 
                          diagonal_left: false, 
                          diagonal_right: false, 
                          start_x: 0, 
                          start_y: 0
                        )
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
    @winner = memo if memo
  end

  def run_turn
    active_player = @players[1]
    puts "WELCOME TO TIC TAC TOE!\nLET'S GET READY TO RUMBLE!\n"
    @board.print_board

    until game_over? do
      active_player == @players[1] ? active_player = @players[0] : active_player = @players[1]

      puts "\nPlayer #{active_player.symbol}: Choose an empty space by entering an integer 0-2 representing each row and column (00 represents top right):\n"
      coord = gets.chomp
      row = coord[0].to_i
      column = coord[-1].to_i

      until @board.validate_input(row, column) do
        puts 'Error! Select a valid input!'
        coord = gets.chomp
        row = coord[0].to_i
        column = coord[-1].to_i
      end

      active_player.make_move @board, row, column
      @board.print_board
      check_winner
    end
    puts winner ? "\n#{active_player.symbol} Wins!" : "Tie game!"
  end
end
