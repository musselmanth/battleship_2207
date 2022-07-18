require './lib/board'
require './lib/ship'

class Computer
  
  attr_writer :player
  attr_reader :board, :ships

  def initialize(board_size)
    @player = nil
    @board = Board.new(:computer, board_size)
    @ships = []
    @zero_or_one = rand(2)
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
        # coordinates[0] = (65 + rand(4)).chr + (1 + rand(4)).to_s 
        coordinates[0] = @board.cells.select{ |coord, cell| cell.empty? }.values.sample.coordinate
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
    heatmap = {}
    if @player.board.hit_cells.length == 0
      heatmap = heatmap_random
    else
      heatmap = heatmap_with_hits
    end
    ## picks the coordinate for the first highest value in the heatmap hash
    fire_coord = heatmap.max_by{ |coord, value| value }.first
    result = @player.board.cells[fire_coord].fire_upon
    puts "My shot on #{fire_coord} was a #{result}."
    puts 
  end

  # heatmap_with_hits
  # returns a heatmap of non-fired-upon cells that gives preferences to 
  # cells with adjacent hit cells
  # if there is another hit cell in the same direction as a hit cell, 
  # that non-fired-upon cell gets even higher preference
  #   1 2 3 4
  # A . . . .  in this scenario, B1 and B4 have a preference of 3 or 4 (random)
  # B . H H .  while A2, A3, C2, and C3 have a preference of only 1 or 2 (random)
  # C . . . .  random numbers of 3/4 or 1/2 are used to simulate randomness in the cell chosen
  # D . . . .  amongst preferences
  def heatmap_with_hits
    heatmap = {}
    @player.board.not_fired_upon_cell_coords.each do |coord|
      heatmap[coord] = 0
    end
    heatmap.each do |coord, value|
      @player.board.adjacent_cells(coord).each do |direction, cell|
        if cell != nil && cell.render == 'H'
          heatmap[coord] = (1 + rand(2))
          if @player.board.adjacent_cells(cell.coordinate)[direction] != nil && @player.board.adjacent_cells(cell.coordinate)[direction].render == 'H'
            heatmap[coord] = (3 + rand(2))
          end
        end
      end
    end
    heatmap
  end

  # heatmap_random
  # returns a heatmap of cells which have not been fired upon. to avoid
  # firing on adjacent cells it gives preferences to every other cell
  # preferred cells get a random number 6 - 10 and non-preferred cells
  # get a random number 1 - 5. random numbers are used to create randomness
  # in which preferred cell is shot at.
  # each game randomly chooses between the follow preferences based on 
  # the @zero_or_one variable
  #      1 2 3 4        1 2 3 4
  #    A . P . P      A P . P . 
  #    B P . P .  or  B . P . P    P = preferred cell
  #    C . P . P      C P . P . 
  #    D P . P .      D . P . P
  def heatmap_random
    heatmap = {}
    @player.board.not_fired_upon_cell_coords.each do |coord|
      row = coord.split(//).first
      column = coord.split(//).last
      if (row.ord + @zero_or_one).even?
        if column.to_i.odd?
          heatmap[coord] = (6 + rand(5))
        else
          heatmap[coord] = (1 + rand(5))
        end
      else
        if column.to_i.even?
          heatmap[coord] = (6 + rand(5))
        else
          heatmap[coord] = (1 + rand(5))
        end
      end
    end
    heatmap
  end

  def all_ships_sunk?
    @ships.all?{ |ship| ship.sunk? }
  end

end
