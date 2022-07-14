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

    it 'has valid placements according to length of ship' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
    end

    it 'has valid placements with consecutive cells' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
        expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
        expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
        expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    end

    it 'doesnt have valid placement with diagonal cells' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
        expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end

    it 'has valid placement with valid coordinates' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
        expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end

    it 'can place a ship' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.place(cruiser, ["A1", "A2", "A3"])

        cell_1 = board.cells["A1"]
        cell_2 = board.cells["A2"]
        cell_3 = board.cells["A3"]
        expect(cell_1.ship).to eq(cruiser)
        expect(cell_2.ship).to eq(cruiser)
        expect(cell_3.ship).to eq(cruiser)
        expect(cell_3.ship == cell_2.ship).to be true
    end

    it 'doesnt overlap ships' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.place(cruiser, ["A1", "A2", "A3"])

        expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end

    it 'renders the board' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        board.place(cruiser, ["A3", "B3", "C3"])    
        expected_output =   "  1 2 3 4 \n" +
                            "A . . . . \n" +
                            "B . . . . \n" +
                            "C . . . . \n" +
                            "D . . . . \n"

        expected_output_render_ship =   "  1 2 3 4 \n" +
                                        "A S S S . \n" +
                                        "B . . . . \n" +
                                        "C . . . . \n" +
                                        "D . . . . \n"
        
        expect(board.render).to eq(expected_output)
        require 'pry'; binding.pry
        expect(board.render(true)).to eq(expected_output_render_ship)
    end
end


  