require_relative '../lib/tic_tac_toe_game.rb'
require_relative '../lib/tic_tac_toe_player.rb'
require_relative '../lib/tic_tac_toe_board.rb'

describe Game do
  describe '.game_over?' do
    subject(:game) { described_class.new }

    context 'when there is a winner' do
      before { game.instance_variable_set(:@winner, true) }
      it { is_expected.to be_game_over }
    end

    context 'when there is no winner' do
      it { is_expected.to receive(:check_full); game.game_over? }
    end
  end

  describe '.check_full' do
    subject(:game) { described_class.new }

    context 'when the board is full' do
      before do
        board = game.instance_variable_get(:@board)
        player = Player.new 'X'
        3.times do |i|
          3.times do |j| 
            player.make_move(board, i, j)
          end
        end
      end
      it 'returns true' do
        expect(game.check_full).to eq(true)
      end
    end

    context 'when there is at least one space open' do
      it 'does not return true' do
        expect(game.check_full).to eq(false)
      end
    end
  end

  describe '.check_three_in_row' do
    subject(:game) { described_class.new }

    context 'when a row is filled with X or O' do
      before do
        board = game.instance_variable_get(:@board)
        player = Player.new 'X'
        player.make_move(board, 1, 0)
        player.make_move(board, 1, 1)
        player.make_move(board, 1, 2)
      end
      it 'changes @winner to X or O' do
        game.check_three_in_row(row: true, start_x: 1)
        expect(game.instance_variable_get(:@winner)).to eq('X')
      end
    end
    
    context 'when no row is filled with X or O' do
      it 'does not change @winner' do
        expect{ game.check_three_in_row(row: true, start_x: 1) }.not_to change { game.instance_variable_get(:@winner) }
      end
    end

    context 'when a column is filled with X or O' do
      before do
        board = game.instance_variable_get(:@board)
        player = Player.new 'X'
        player.make_move(board, 0, 0)
        player.make_move(board, 1, 0)
        player.make_move(board, 2, 0)
      end
      it 'changes @winner to X or O' do
        game.check_three_in_row(column: true)
        expect(game.instance_variable_get(:@winner)).to eq('X')
      end 
    end

    context 'when no column is filled with X or O' do
      it 'does not change @winner' do
        expect{ game.check_three_in_row(column: true) }.not_to change { game.instance_variable_get(:@winner) }
      end
    end

    context 'when diagonal spaces are filled with X or O' do
      before do
        board = game.instance_variable_get(:@board)
        player = Player.new 'O'
        player.make_move(board, 0, 0)
        player.make_move(board, 1, 1)
        player.make_move(board, 2, 2)
      end
      it 'changes @winner to X or O' do
        game.check_three_in_row(diagonal_left: true)
        expect(game.instance_variable_get(:@winner)).to eq('O')
      end
    end

    context 'when diagnoal spaces are not filled with X or O' do
      it 'does not change @winner' do
        expect{ game.check_three_in_row(diagonal_left: true) }.not_to change { game.instance_variable_get(:@winner) }
      end
    end
  end
end

describe Board do
  subject(:game_board) { described_class.new }

  describe '.place_token' do
    context 'when it is a player turn' do
      it 'adds a player token to the board' do
        symbol = 'X'
        row = 0
        column = 1
        expect { game_board.place_token(symbol, row, column) }.to change { game_board.instance_variable_get(:@spaces) }
      end
    end
  end

  describe '.validate_input' do
    context 'when a player chooses an occupied spot' do
      it 'returns false' do
        player = Player.new 'X'
        player.make_move(game_board, 0, 0)
        row = 0
        column = 0
        expect(game_board.validate_input(row, column)).to eq(false)
      end
    end

    context 'when a player chooses a spot off the board' do
      it 'returns false' do
        row = 3 
        column = 3
        expect(game_board.validate_input(row, column)).to eq(false)
      end
    end

    context 'when a plyer chooses an empty spot' do
      it 'returns true' do
        row = 0
        column = 0
        expect(game_board.validate_input(row, column)).to eq(true)
      end
    end
  end
end

describe Player do
  subject(:player) { described_class.new 'X' }

  describe '.make_move' do
    context 'when the player plays a token' do
      it 'calls .place_token on board object' do
        board = instance_double('Board')
        symbol = player.instance_variable_get(:@symbol)
        row = 0
        column = 1

        expect(board).to receive(:place_token).with(symbol, row, column)
        player.make_move board, row, column
      end
    end
  end
end