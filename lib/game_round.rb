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
      selection = gets.chomp.downcase
    end

    exit if selection == 'q'

    name = ''
    while name == '' || name.length > 36
      print "Please enter your first name: "
      name = gets.chomp
      puts "Your name is too long." if name.length > 36
    end
    
    @computer = Computer.new
    @player = Player.new(name.capitalize, @computer)
    @computer.player = @player

    puts "Hi #{@player.name}!, I'm Computer. Let's play Battleship!"

    place_ships
  end

  def place_ships
    @computer.place_ships
    @player.place_ships
    take_turn
  end

  def take_turn
    puts "===============COMPUTER'S BOARD==============="
    puts @computer.board.render #=> rendering ships now for testing, final product should remove (true)
    puts players_board_header
    puts @player.board.render(true)
    puts ""

    @player.fire
    @computer.fire
    if game_round_over?
      game_over
    else
      take_turn
    end
  end

  def players_board_header
    header = ""
    ((38 - @player.name.length) / 2).times{ header += "=" }
    header += @player.name.upcase + "'S BOARD"
    ((38 - @player.name.length) / 2).times{ header += "=" }
    header += "=" if header.length < 46
    header
  end

  def game_round_over?
    @computer.all_ships_sunk? || @player.all_ships_sunk?
  end

  def game_over
    puts "===============COMPUTER'S BOARD==============="
    puts @computer.board.render(true) #=> rendering ships now for testing, final product should remove (true)
    puts players_board_header # puts "=============#{@player.name} BOARD============="
    puts @player.board.render(true)
    puts ""
    if @computer.all_ships_sunk?
      puts "You won!"
    else
      puts "I won!"
    end
    puts "Thanks for playing, #{@player.name}!"
    puts ""
    start
  end

end