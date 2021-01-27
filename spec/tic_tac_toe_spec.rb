require '../lib/tic_tac_toe.rb'

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

end