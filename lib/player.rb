require './lib/board'
require './lib/ship'

class Player

    attr_reader :board, :name

    def initialize(name, computer, board_size)
        @name = name
        @computer = computer
        @board = Board.new(:player, board_size)
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
            puts "Select your placement for your #{ship.name} (#{ship.length} cells)"    

            print "Selection: "
            selection = gets.chomp.upcase
            coordinates = selection.split(/ /)
            coordinates.sort!
            until @board.valid_placement?(ship, coordinates)
                puts "Invalid coordinates. Please enter your coordinates." 
                print "Selection: "
                selection = gets.chomp.upcase
                coordinates = selection.split(/ /)
                coordinates.sort! 
            end 
            @board.place(ship, coordinates)
        end
    end

    def fire
        puts "Select a cell to fire upon"
        print "Selection: "
        selection = gets.chomp.upcase
        # @computer.board.cells[coordinate].fire_upon
        until @board.valid_coordinate?(selection) && !@computer.board.cells[selection].fired_upon?
            
            puts "That cell is invalid. Please select again."
            print "Selection: "
            selection = gets.chomp.upcase
        end
        result = @computer.board.cells[selection].fire_upon
        puts
        puts "Your shot on #{selection} was a #{result}." 
    end

    def all_ships_sunk?
        @ships.all?{ |ship| ship.sunk? }
    end

end
