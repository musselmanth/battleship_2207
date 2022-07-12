require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
    it 'exists and contains cells' do
        board = Board.new
        expect(board.cells.length).to eq(16)
        expect(board.cells.values).to all(be_a(Cell))
    end
end


  