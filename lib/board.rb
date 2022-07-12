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
    
end
