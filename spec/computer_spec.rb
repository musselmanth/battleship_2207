require './lib/computer'

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
end