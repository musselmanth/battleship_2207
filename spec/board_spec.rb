require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
    it 'exists and contains cells' do
        board = Board.new
        expect(board.cells.length).to eq(16)
        expect(board.cells.values).to all(be_a(Cell))
    end

    it 'has valid coordinates' do
        board = Board.new
        expect(board.valid_coordinate?("A1")).to be true
        expect(board.valid_coordinate?("D4")).to be true
        expect(board.valid_coordinate?("A5")).to be false
        expect(board.valid_coordinate?("E1")).to be false
        expect(board.valid_coordinate?("A22")).to be false
    end

    it 'has valid placements according to lenght of ship' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true


    end
end


  