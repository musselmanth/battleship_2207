require './lib/cell'
require './lib/ship'

class Board

    attr_reader :cells

    def initialize
        @cells = {}
        ("A".."D").each do |row|
            ("1".."4").each do |column|
                @cells[row + column] = Cell.new(row + column)
            end
        end
    end

    def valid_coordinate?(coordinate)
        @cells.key?(coordinate)        
    end
    
    def valid_placement?(ship, coordinates)
        all_coordinates_valid = coordinates.all? do |coordinate|
            valid_coordinate?(coordinate) 
        end
        
        matching_lengths = ship.length == coordinates.length
        
        if all_coordinates_valid && matching_lengths
            true
        else
            false
        end
        # @ship.length = valid_coordinate?

    end
end
