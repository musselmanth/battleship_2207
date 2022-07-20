require './lib/computer'
require './lib/player'

RSpec.describe Computer do
  before(:each) do
    @computer = Computer.new
  end
  
  it 'exists' do
    expect(@computer).to be_instance_of(Computer)
  end

  it 'has ships' do
    expect(@computer.ships).to all(be_instance_of(Ship))
  end

  it 'has a board' do
    expect(@computer.board).to be_instance_of(Board)
  end

  it 'places its ships' do
    @computer.place_ships
    occupied_cells = @computer.board.cells.count do |coord, cell| 
      !cell.empty?
    end

    expect(occupied_cells).to eq(5)
  end

  it 'places ships differently each time' do
    @computer.place_ships
    first_comp_init_render = @computer.board.render(true)
    computer2 = Computer.new
    computer2.place_ships
    second_comp_init_render = computer2.board.render(true)

    expect(first_comp_init_render).not_to eq(second_comp_init_render)
  end

  it 'can tell you when its lost' do
    @computer.place_ships
    @computer.ships.each do |ship|
      until ship.sunk?
        ship.hit
      end
    end

    expect(@computer.all_ships_sunk?).to be true
  end

  it 'can fire at the players board' do
    player = Player.new("Tom", @computer)
    @computer.player = player
    @computer.fire
    @computer.fire
    count = player.board.cells.count{|key, cell| cell.fired_upon? }
    expect(count).to eq(2)
  end
end