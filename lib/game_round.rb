require './lib/board'
require './lib/player'
require './lib/computer'

class GameRound

  def initialize
    @computer = nil
    @player = nil
  end

  def start
    puts "Welcome to BATTLESHIP!"

    puts "Enter p to play. Enter q to quit."
    print "Selection: "
    selection = gets.chomp
    until (selection == 'p' || selection == 'q')
      puts "Your selection is not valid. Please enter either 'p' to play or 'q' to quit."
      print "Selection: "
      selection = gets.chomp
    end

    exit if selection == 'q'

    name = ''
    while name == ''
      print "Please enter your name: "
      name = gets.chomp
    end
    puts "Hi #{name}!, I'm Computer."

    @computer = Computer.new
    @player = Player.new(name, @computer)
    @computer.player = @player

    place_ships
  end

  def place_ships
    @computer.place_ships
    @player.place_ships
    take_turn
  end

  def take_turn
    puts "================COMPUTER BOARD================"
    puts @computer.board.render(true) #=> rendering ships now for testing, final product should remove (true)
    puts "=================PLAYER BOARD=================" #refactor to include @player.name?
    puts @player.board.render(true)
    # @player.fire
    # @computer.fire
    if game_round_over?
      game_over
    else
      take_turn
    end
  end

  def game_round_over?
    true #needs to return true if either all computer ships are sunk or player ships are sunk
    # @computer.all_ships_sunk? || @player.all_ships_sunk?
  end

  def game_over
    if true #=> computer.all_ships_sunk?
      puts "You won!"
    else
      puts "I won!"
    end
#    puts "Thanks for playing #{@player.name}"
    puts ""
    start
  end

end