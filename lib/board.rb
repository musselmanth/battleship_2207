require './lib/cell'
require './lib/ship'

class Board

    attr_reader :cells

    def initialize(owner, dimension)
        @cells = {}
        ("A"..(64 + dimension).chr).each do |row|
            ("1"..(dimension).to_s).each do |column|
                @cells[row + column] = Cell.new(row + column, owner)
            end
        end
        @dimension = dimension
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
        ("1"..@dimension.to_s).each_cons(coordinates.length).any?{ |expected| columns == expected }
    end

    def consecutive_rows?(coordinates)
        rows = coordinates.map{ |coordinate| coordinate.split(//).first }
        ("A"..(64 + @dimension).chr).each_cons(coordinates.length).any?{ |expected| rows == expected }
    end

    def place(ship, coordinates)
        coordinates.each{ |coordinate| @cells[coordinate].place_ship(ship) }
    end
    
    def adjacent_cells(coordinate) #=>returns hash of adjacent cells objects at a given coordinate.
        coordinate_split = coordinate.split(//)
        row = coordinate_split.first.ord
        column = coordinate_split.last.to_i
        adj_cells = {
            left: nil,
            up: nil,
            right: nil,
            down: nil
        }
        left_coord = row.chr + (column - 1).to_s
        adj_cells[:left] = @cells[left_coord] if valid_coordinate?(left_coord)

        up_coord = (row - 1).chr + column.to_s
        adj_cells[:up] = @cells[up_coord] if valid_coordinate?(up_coord)

        right_coord = row.chr + (column + 1).to_s
        adj_cells[:right] = @cells[right_coord] if valid_coordinate?(right_coord)

        down_coord = (row + 1).chr + column.to_s
        adj_cells[:down] = @cells[down_coord] if valid_coordinate?(down_coord)

        adj_cells
    end

    def hit_cells
        @cells.select{ |coord, cell| cell.render == 'H' }
    end

    def not_fired_upon_cell_coords
        @cells.select{ |coord, cell| !cell.fired_upon? }.keys
    end

    def render(is_player_board = false)
        render_string = "  "
        (18-@dimension).times{render_string += " "}
        ("1"..@dimension.to_s).each do |column|
            render_string += "#{column} "
        end 
        render_string += "   Key:" if is_player_board
        render_string += "\n"
        ("A"..(64 + @dimension).chr).each do |row|
            (18-@dimension).times{render_string += " "}
            render_string += "#{row} "
            ("1"..@dimension.to_s).each do |column|
                render_string += "#{@cells[row + column].render(is_player_board)} "
            end
            render_string += "   M: miss" if row == "A" && is_player_board
            render_string += "   H: hit" if row == "B" && is_player_board
            render_string += "   X: sunk ship" if row == "C" && is_player_board
            render_string += "   S: afloat ship" if row == "D" && is_player_board
            render_string += "\n"
        end
        render_string  
    end



end
