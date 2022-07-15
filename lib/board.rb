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
        all_coordinates_valid?(ship, coordinates) && (empty_and_in_a_row?(coordinates) || empty_and_in_a_column?(coordinates))
    end

    def all_coordinates_empty?(coordinates)
        coordinates.all?{ |coordinate| @cells[coordinate].empty? }
    end
  
    def all_coordinates_valid?(ship, coordinates)
        coordinates_exist = coordinates.all? { |coordinate| valid_coordinate?(coordinate) }
        correct_coordinate_length = (ship.length == coordinates.length())
        coordinates_exist && correct_coordinate_length
    end

    def empty_and_in_a_row?(coordinates)
        is_empty = all_coordinates_empty?(coordinates)
        is_all_same_row = all_same_row?(coordinates)
        has_consecutive_columns = consecutive_columns?(coordinates)
        is_empty && is_all_same_row && has_consecutive_columns
    end

    def empty_and_in_a_column?(coordinates)
        is_empty = all_coordinates_empty?(coordinates)
        is_all_same_column = all_same_column?(coordinates)
        has_consecutive_rows = consecutive_rows?(coordinates)
        is_empty && is_all_same_column && has_consecutive_rows
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
        ("1".."4").each_cons(coordinates.length).any?{ |expected| columns == expected }
    end

    def consecutive_rows?(coordinates)
        rows = coordinates.map{ |coordinate| coordinate.split(//).first }
        ("A".."D").each_cons(coordinates.length).any?{ |expected| rows == expected }
    end

    def place(ship, coordinates)
        coordinates.each{ |coordinate| @cells[coordinate].place_ship(ship) }
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
