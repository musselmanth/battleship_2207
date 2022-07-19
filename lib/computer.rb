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
    
  end

  def generate_ships
    @player.ships.each do |ship|
      @ships << Ship.new(ship.name, ship.length)
    end
  end

  def place_ships
    @ships.each do |ship|
      coordinates = []

      until @board.valid_placement?(ship, coordinates)
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
  end

  # heatmap_with_hits
  # returns a heatmap of non-fired-upon cells that gives preferences to 
  # cells with adjacent hit cells
  # if there is another hit cell in the same direction as a hit cell, 
  # that non-fired-upon cell gets even higher preference
  #   1 2 3 4
  # A . . . .  in this scenario, B1 and B4 have a preference of between 21 and 40 (random)
  # B . H H .  while A2, A3, C2, and C3 have a preference of only between 1 and 20 (random)
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
          heatmap[coord] = (1 + rand(20))
          if @player.board.adjacent_cells(cell.coordinate)[direction] != nil && @player.board.adjacent_cells(cell.coordinate)[direction].render == 'H'
            heatmap[coord] = (21 + rand(40))
          end
        end
      end
    end
    heatmap
  end

  # heatmap_random
  # returns a heatmap of cells which have not been fired upon. to avoidc
  # firing on adjacent cells it only gives values to cells in a lattice
  # assigns a random number between 1 and 100 to allow for randomly selecting
  # when heatmap.max_by is called
  # each game randomly chooses between the follow lattices based on 
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
          heatmap[coord] = (1 + rand(100))
        end
      else
        if column.to_i.even?
          heatmap[coord] = (1 + rand(100))
        end
      end
    end
    heatmap
  end

  def all_ships_sunk?
    @ships.all?{ |ship| ship.sunk? }
  end

end
