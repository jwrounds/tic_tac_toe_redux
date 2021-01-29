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