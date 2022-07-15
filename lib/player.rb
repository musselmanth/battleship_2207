require './lib/board'
require './lib/ship'

class Player

    attr_reader :board

    def initialize(name, computer)
        @name = name
        @computer = computer
        @board = Board.new
        @ships = {}
        generate_ships
    end

    def generate_ships
        cruiser = Ship.new("cruiser", 3)
        @ships[cruiser.name.to_sym] = cruiser
        submarine = Ship.new("submarine", 2)
        @ships[submarine.name.to_sym] = submarine
    end

    def place_ships
        @ships.each do |key, ship|
            puts "Select your placement for your #{ship.name} (3 cells)"    
            print "Selection: "
            selection = gets.chomp.upcase
            coordinates = selection.split(/ /)
            coordinates.sort!
            until @board.valid_placement?(@ships[key], coordinates)
                puts "Invalid coordinates. Please enter your coordinates." 
                print "Selection: "
                selection = gets.chomp.upcase
                coordinates = selection.split(/ /)
                coordinates.sort! 
            end 
            @board.place(@ships[key], coordinates)
        end

        

        
        # puts "Select your placement for your submarine (2 cells)"
        # print "Selection: "
        # selection = gets.chomp.upcase
        # coordinates = selection.split(/ /)
        # coordinates.sort!
        # until @board.valid_placement?(@ships[:submarine], coordinates)
        #     puts "Invalid coordinates. Please enter your coordinates." 
        #     print "Selection: "
        #     selection = gets.chomp.upcase
        #     coordinates = selection.split(/ /)
        #     coordinates.sort! 
        # end 
        # @board.place(@ships[:submarine], coordinates)
    end

    # def fire
        # @player = Player.new(name, @computer)
        # @computer = Computer.new
        # puts "Select a cell to fire upon"
        # puts "Selection: "
        # selection = gets.chomp
        # # @computer.board.cells[coordinate].fire_upon
        # if @computer.board.cells[coordinate].fire_upon == fired_upon?
        #     puts "That cell has already been selected. Please select again."
        #     puts "Selection: "
        #     selection = gets.chomp
        # if @computer.board.cells[coordinate].fire_upon == @computer.board.place
        #     puts "Your shot on #{coordinate} was a hit!"
        # else 
            # puts "Your shot on #{coordinate} was a miss."
    # end

end
