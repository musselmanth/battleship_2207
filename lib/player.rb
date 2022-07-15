require './lib/board'
require './lib/ship'

class Player

    attr_reader :board

    def initialize(name)
        @name = name
        # @computer = computer
        @board = Board.new
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
        puts "Select your placement for your cruiser (3 cells)"
        puts "Selection: "
        selection = gets.chomp
        coordinates = selection.split(/ /)

        @board.place(@ships[0], coordinates)
        
        puts "Select your placement for your submarine (2 cells)"
        puts "Selection: "
        selection = gets.chomp
        coordinates = selection.split(/ /)
        @board.place(@ships[1], coordinates)
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
player = Player.new("Rob")
player.place_ships
puts player.board.render(true)