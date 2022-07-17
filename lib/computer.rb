require './lib/board'
require './lib/ship'

class Computer
  
  attr_writer :player
  attr_reader :board, :ships

  def initialize()
    @player = nil
    @board = Board.new
    @ships = []
    generate_ships
  end

  def generate_ships
    cruiser = Ship.new("cruiser", 3)
    @ships << cruiser
    submarine = Ship.new("submarine", 2)
    @ships << submarine
  end

  def place_ships
    @ships.each do |ship|
      coordinates = []

      until @board.valid_placement?(ship, coordinates)
        coordinates[0] = (65 + rand(4)).chr + (1 + rand(4)).to_s 
        # coordinates[0] = @board.cells.find_all do |key, cell|
        across = rand(2) == 1
        (ship.length - 1).times do |i|

          if across
            coordinates[i+1] = coordinates[i][0] + (coordinates[i][1].to_i + 1).to_s
          else #down
            coordinates[i+1] = coordinates[i][0].next + coordinates[i][1]
          end
        end
      end
      @board.place(ship, coordinates)
    end
  end

  def fire
    non_fired_cells = @player.board.cells.find_all{ |key, cell| !cell.fired_upon? }.to_a
    random_cell = non_fired_cells.sample.first
    result = @player.board.cells[random_cell].fire_upon
    puts "My shot on #{random_cell} was a #{result ? "hit" : "miss"}."
    puts ""

  end

  def all_ships_sunk?
    @ships.all?{ |ship| ship.sunk? }
  end

end
