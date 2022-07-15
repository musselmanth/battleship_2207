require './lib/cell'
require './lib/ship'

class Board

    attr_reader :cells, :row, :column

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
        if all_coordinates_valid?(ship, coordinates)
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
  
    def all_coordinates_valid?(ship, coordinates)
        coordinates_exist = coordinates.all? do |coordinate|
            valid_coordinate?(coordinate) 
        end

        coordinates_empty = coordinates.all? do |coordinate|
            @cells[coordinate].empty?
        end

        correct_coordinate_length = ship.length == coordinates.length

        coordinates_exist && coordinates_empty && correct_coordinate_length
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

        ("1".."4").each_cons(coordinates.length).any? do |expected|
            columns == expected
        end
    end

    def consecutive_rows?(coordinates)
        rows = coordinates.map{ |coordinate| coordinate.split(//).first }

        ("A".."D").each_cons(coordinates.length).any? do |expected|
            rows == expected
        end
    end

    def place(ship, coordinates)
        coordinates.each do |coordinate|
            @cells[coordinate].place_ship(ship)
        end
    end

    def render(render_hidden_ship = false)
        render_string = "  1 2 3 4 \n"
        ("A".."D").each do |row|
            render_string += "#{row} "
            ("1".."4").each do |column|
                render_string += "#{@cells[row + column].render(render_hidden_ship)} "
            end
            render_string += "\n"
        end
        render_string  
    end
end
