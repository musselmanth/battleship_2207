require './lib/ship'

RSpec.describe Ship do
    it 'exists' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser).to be_instance_of(Ship)
    end
    
    it 'has initial attributes' do
        cruiser = Ship.new("Cruiser", 3)
        expect(cruiser.name).to eq("Cruiser")
        expect(cruiser.length).to eq(3)
        expect(cruiser.health).to eq(3)
        expect(cruiser.sunk?).to eq(false)
    end

    it 'can take a hit and sink' do
        cruiser = Ship.new("Cruiser", 3)
        cruiser.hit
        expect(cruiser.health).to eq(2)
        expect(cruiser.sunk?).to eq(false)
        cruiser.hit
        cruiser.hit
        expect(cruiser.health).to eq(0)
        expect(cruiser.sunk?).to eq(true)
    end
end