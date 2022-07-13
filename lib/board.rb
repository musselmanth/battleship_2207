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
                
        if all_coordinates_valid?(coordinates) && ship.length == coordinates.length
            
            if all_same_row?(coordinates) && consecutive_columns?(coordinates)
                true
            elsif all_same_column?(coordinates) && consecutive_rows?(coordinates)
                true
            else
                false
            end

        else
            false
        end

    end

    def all_coordinates_valid?(coordinates)
        coordinates.all? do |coordinate|
            valid_coordinate?(coordinate) 
        end
    end

    def all_same_row?(coordinates)
        rows = coordinates.map{ |coordinate| coordinate.split(//).first }
        
        rows.all?{ |row| row == rows.first }
    end

    def all_same_column?(coordinates)
        columns = coordinates.map{ |coordinate| coordinate.split(//).last }

        columns.all?{ |column| column == columns.last }
    end

    def consecutive_columns?(coordinates)
        columns = coordinates.map{ |coordinate| coordinate.split(//).last}

        is_consecutive = false
    
        ("1".."4").each_cons(coordinates.length) do |expected|
        
            if columns == expected
                is_consecutive = true
            end
        end
        is_consecutive
    end

    def consecutive_rows?(coordinates)

    end

end
