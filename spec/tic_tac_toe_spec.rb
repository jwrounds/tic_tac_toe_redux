require_relative '../lib/tic_tac_toe.rb'
require_relative '../lib/tic_tac_toe_player.rb'
require_relative '../lib/tic_tac_toe_board.rb'

describe Game do
  describe '.game_over?' do
    subject(:game) { described_class.new }

    context 'when there are three in a row' do
      before { game.instance_variable_set(:@three_in_row, true) }
      it { is_expected.to be_game_over }
    end

    context 'when the board is full' do
      before { game.instance_variable_set(:@full, true) }
      it { is_expected.to be_game_over }
    end

    context 'when there are not three in a row, and at least one space open' do
      it { is_expected.not_to be_game_over }
    end
  end

  describe '.check_row' do
    subject(:game) { described_class.new }
    let(:board) { Board.new }
    let(:player) { Player.new 'X' } 

    context 'when a row is filled with X or O' do
      before do
        player.make_move(board, 00)
        player.make_move(board, 01)
        player.make_move(board, 02)
      end
      it 'changes @three_in_row to true' do
        expect{ game.check_row }.to change { game.instance_variable_get(:@three_in_row) }
      end
    end
    
    context 'when no row is filled with X or O' do
      it 'does not change @three_in_row' do
        expect{ game.check_row }.not_to change { game.instance_variable_get(:@three_in_row) }
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
        expect { game_board.place_token(symbol, row, column) }.to change { game_board.instance_variable_get(:@board) }
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
        coordinates = '01'
        row = 0
        column = 1

        expect(board).to receive(:place_token).with(symbol, row, column)
        player.make_move board, coordinates
      end
    end
  end
end