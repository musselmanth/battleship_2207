require './lib/board'
require './lib/player'
require './lib/computer'

class GameRound

  def initialize
    @computer = nil
    @player = nil
  end

  def start
    system('clear')
    puts "==================BATTLESHIP=================="
    puts
    puts "Welcome to BATTLESHIP!"

    puts "Enter p to play. Enter q to quit."
    print "Selection: "
    selection = gets.chomp
    until (selection == 'p' || selection == 'q')
      puts "Your selection is not valid. Please enter either 'p' to play or 'q' to quit."
      print "Selection: "
      selection = gets.chomp.downcase
    end

    exit if selection == 'q'

    puts
    name = ''
    while name == '' || name.length > 36
      print "Please enter your first name: "
      name = gets.chomp
      puts "Your name is too long." if name.length > 36
    end
    puts
    puts "Hi #{name}!, I'm Computer. Let's play Battleship!"
    puts
    puts "Please select the dimensions of the board (choose a number between 4 and 9)."
    print "Selection: "
    dimension = gets.chomp
    until /\b[4-9]\b/.match?(dimension)
      puts "Your dimensions are invalid. Please select again."
      print "Selection: "
      dimension = gets.chomp
    end
    dimension = dimension.to_i


    puts
    @computer = Computer.new(dimension)
    @player = Player.new(name.capitalize, @computer, dimension)
    @computer.player = @player
    @computer.generate_ships



    place_ships
  end

  def place_ships
    @computer.place_ships
    @player.place_ships
    system('clear')
    puts "==================BATTLESHIP=================="
    puts
    take_turn
  end

  def take_turn
    puts "===============COMPUTER'S BOARD==============="
    puts
    puts @computer.board.render
    puts
    puts @player.board_header
    puts
    puts @player.board.render(true, true)
    puts 

    @player.fire
    #clearing in player fire
    @computer.fire
    if game_round_over?
      game_over
    else
      take_turn
    end
  end

  def game_round_over?
    @computer.all_ships_sunk? || @player.all_ships_sunk?
  end

  def game_over
    puts
    puts "===============COMPUTER'S BOARD==============="
    puts
    puts @computer.board.render(true)
    puts
    puts @player.board_header 
    puts
    puts @player.board.render(true, true)
    puts 
    if @computer.all_ships_sunk?
      puts "You won!"
    else
      puts "I won!"
    end
    puts "Thanks for playing, #{@player.name}!"
    puts 
    puts "Press enter to continue"
    gets.chomp
    start
  end

end