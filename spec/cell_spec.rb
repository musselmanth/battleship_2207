require './lib/ship'
require './lib/cell'

RSpec.describe Cell do

    it 'exists and has initial attributes' do
        cell = Cell.new("B4", :player)

        expect(cell.coordinate).to eq("B4")
        expect(cell.ship).to eq(nil)
        expect(cell.empty?).to be true
    end

    it 'can be placed' do
        cell = Cell.new("B4", :player)
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)

        expect(cell.ship).to be_instance_of(Ship)
        expect(cell.empty?).to be false
    end

    it 'can be fired upon' do
        cell = Cell.new("B4", :player)
        cruiser = Ship.new("Cruiser", 3)

        cell.place_ship(cruiser)

        expect(cell.fired_upon?).to be false

        cell.fire_upon

        expect(cell.ship.health).to eq(2)
        expect(cell.fired_upon?).to be true
    end 

    it 'renders correctly with no ship' do
        cell_1 = Cell.new("B4", :player)

        expect(cell_1.render).to eq(".")

        cell_1.fire_upon

        expect(cell_1.render).to eq("M")
    end

    it 'renders correctly with a ship' do
        cell_2 = Cell.new("C3", :player)
        cruiser = Ship.new("Cruiser", 3)
        cell_2.place_ship(cruiser)
        
        expect(cell_2.render).to eq(".")
        expect(cell_2.render(true)).to eq("S")

        cell_2.fire_upon

        expect(cell_2.render).to eq("H")
        
        cruiser.hit
        cruiser.hit

        expect(cruiser.sunk?).to be true
        expect(cell_2.render).to eq ("X")
    end


end
