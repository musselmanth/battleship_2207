require './lib/ship'
require './lib/cell'

RSpec.describe Cell do

    it 'exists and has initial attributes' do
        cell = Cell.new("B4")

        expect(cell.coordinate).to eq("B4")
        expect(cell.ship).to eq(nil)
        expect(cell.empty?).to be true
    end

    it 'can be placed' do
        cell = Cell.new("B4")
        cruiser = Ship.new("Cruiser", 3)
        cell.place_ship(cruiser)

        expect(cell.ship).to be_instance_of(Ship)
        expect(cell.empty?).to be false
    end

    it 'can be fired upon' do
        cell = Cell.new("B4")
        cruiser = Ship.new("Cruiser", 3)

        cell.place_ship(cruiser)

        expect(cell.fired_upon?).to be false

        cell.fire_upon

        expect(cell.ship.health).to eq(2)
        expect(cell.fired_upon?).to be true
    end 
end