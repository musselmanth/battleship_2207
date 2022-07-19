require './lib/board'
require './lib/ship'

class Player

    attr_reader :board, :name, :ships

    def initialize(name, computer, board_size)
        @name = name
        @computer = computer
        @board = Board.new(:player, board_size)
        @ships = []
        @board_size = board_size
        generate_ships
    end

    def generate_ships
        puts "You can select up to #{@board_size} ships."
        puts "How many ships would you like to play with?"
        print "Selection: "
        selection = gets.chomp
        until /\b[1-#{@board_size}]\b/.match?(selection)
            puts "Your selection is invalid. Please select a number between 1 and #{@board_size}."
            print "Selection: "
            selection = gets.chomp
        end
        selection = selection.to_i
        selection.times do |time|
            puts
            puts "Please select a name for ship number #{time + 1}."
            print "Selection: "
            ship_name = gets.chomp.downcase
            until ship_name.length < 15
                puts "Your name is too long. Please enter a different name."
                print "Selection: "
                ship_name = gets.chomp.downcase
            end
            puts "Please select your ship length (2 - 4 units)."
            print "Selection: "
            ship_length = gets.chomp
            until /\b[2-4]\b/.match?(ship_length)
                puts "Invalid ship length. Please select again."
                print "Selection: "
                ship_length = gets.chomp
            end
            ship_length = ship_length.to_i
            @ships << Ship.new(ship_name, ship_length)
        end
    end

    def place_ships
        @ships.each do |ship|
            system('clear')
            puts "==================BATTLESHIP=================="
            puts
            puts board_header
            puts
            puts @board.render(true)
            puts
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

    def board_header
        header = ""
        ((38 - @name.length) / 2).times{ header += "=" }
        header += @name.upcase + "'S BOARD"
        ((38 - @name.length) / 2).times{ header += "=" }
        header += "=" if header.length < 46
        header
    end

    def fire
        puts "Select a cell to fire upon."
        print "Selection: "
        selection = gets.chomp.upcase
        # @computer.board.cells[coordinate].fire_upon
        until @board.valid_coordinate?(selection) && !@computer.board.cells[selection].fired_upon?
            
            puts "That cell is invalid. Please select again."
            print "Selection: "
            selection = gets.chomp.upcase
        end
        result = @computer.board.cells[selection].fire_upon
        system('clear')
        puts "==================BATTLESHIP=================="
        puts
        puts "Your shot on #{selection} was a #{result}." 
    end

    def all_ships_sunk?
        @ships.all?{ |ship| ship.sunk? }
    end

end
