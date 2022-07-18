require './lib/board'
require './lib/ship'
require './lib/cell'

RSpec.describe Board do
    it 'exists and contains cells' do
        board = Board.new(:player, 8)
        expect(board.cells.length).to eq(64)
        expect(board.cells.values).to all(be_a(Cell))

    end

    it 'has valid coordinates' do
        board = Board.new(:player, 8)
        expect(board.valid_coordinate?("A1")).to be true
        expect(board.valid_coordinate?("D4")).to be true
        expect(board.valid_coordinate?("A5")).to be true
        expect(board.valid_coordinate?("E1")).to be true
        expect(board.valid_coordinate?("A22")).to be false
        expect(board.valid_coordinate?("A9")).to be false
        expect(board.valid_coordinate?("I3")).to be false
        
    end

    it 'has valid placements according to length of ship' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        expect(board.valid_placement?(cruiser, ["A1", "A2"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3", "A4"])).to be false
        expect(board.valid_placement?(submarine, ["A2", "A3"])).to be true
    end

    xit 'has valid placements with consecutive cells' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "A2", "A4"])).to be false
        expect(board.valid_placement?(submarine, ["A1", "C1"])).to be false
        expect(board.valid_placement?(cruiser, ["A3", "A2", "A1"])).to be false
        expect(board.valid_placement?(submarine, ["C1", "B1"])).to be false
    end

    xit 'doesnt have valid placement with diagonal cells' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(cruiser, ["A1", "B2", "C3"])).to be false
        expect(board.valid_placement?(submarine, ["C2", "D3"])).to be false
    end

    xit 'has valid placement with valid coordinates' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)

        expect(board.valid_placement?(submarine, ["A1", "A2"])).to be true
        expect(board.valid_placement?(cruiser, ["B1", "C1", "D1"])).to be true
    end

    xit 'can place a ship' do
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

    xit 'doesnt overlap ships' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)
        submarine = Ship.new("Submarine", 2)
        board.place(cruiser, ["A1", "A2", "A3"])

        expect(board.valid_placement?(submarine, ["A1", "B1"])).to be false
    end

    xit 'renders the board' do
        board = Board.new
        cruiser = Ship.new("Cruiser", 3)

        board.place(cruiser, ["A3", "B3", "C3"])    
        expected_output =   "  1 2 3 4 \n" +
                            "A . . . . \n" +
                            "B . . . . \n" +
                            "C . . . . \n" +
                            "D . . . . \n"

        expected_output_render_ship =   "  1 2 3 4 \n" +
                                        "A . . S . \n" +
                                        "B . . S . \n" +
                                        "C . . S . \n" +
                                        "D . . . . \n"
        
        expect(board.render).to eq(expected_output)
        
        expect(board.render(true)).to eq(expected_output_render_ship)
    end

    xit 'can return a hash of adjacent cells' do
        board = Board.new
        coordinate = "A1"
        expect(board.adjacent_cells(coordinate)).to eq({left: nil, up: nil, right: board.cells["A2"], down: board.cells["B1"]})

        coordinate = "B2"
        expect(board.adjacent_cells(coordinate)).to eq({left: board.cells["B1"], up: board.cells["A2"], right: board.cells["B3"], down: board.cells["C2"]})
    end

    xit 'can return an array of hit cells' do
        board = Board.new
        cruiser = Ship.new("cruiser", 3)
        board.place(cruiser, ["A1", "A2", "A3"])
        board.cells["A2"].fire_upon
        board.cells["C2"].fire_upon
        expect(board.hit_cells).to eq([board.cells["A2"]])
    end

    xit 'can return an array of not_fired_upon cells' do
        board = Board.new
        board.cells["A2"].fire_upon
        board.cells["A3"].fire_upon
        board.cells["A4"].fire_upon
        board.cells["B1"].fire_upon
        board.cells["B2"].fire_upon
        board.cells["B3"].fire_upon
        board.cells["B4"].fire_upon
        board.cells["C1"].fire_upon
        board.cells["C2"].fire_upon
        board.cells["C3"].fire_upon
        board.cells["D1"].fire_upon
        board.cells["D3"].fire_upon
        board.cells["D4"].fire_upon


        expect(board.not_fired_upon_cells).to eq([board.cells["A1"], board.cells["C4"], board.cells["D2"]])
    end
end


  