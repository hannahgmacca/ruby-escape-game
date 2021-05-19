# require 'require_all'
require 'colorize'
require_relative 'app/score_item'
require_relative 'app/room'
require_relative 'app/player'


# Creates and stores all game objects
# Begins with printing progress bar and welcome message to user,
# followed by the available commands user can type
# Class will wait for user input until winning/ losingcondition is met or user types 'quit'
class Game
    attr_accessor :run_game, :current_room, :score

    def initialize()
    end

  def run
    initializeEnvrionment
    @player = Player.new()
    @current_room = @lroom
    @run_game = true

    puts """
      Welcome to the AirBnB escape game!

      You have rented an AirBnB for the night and during your stay have realised that you are not the only guest.
      In order to survive, you must interact with the apartment and try to escape.
      Each interaction will bring you a hint or a step closer to your freedom

      """
      # puts @current_room.room_name
      # puts @current_room.hasExit?("west")
      # @current_room.print_exits

      while (@run_game)
        handleInput
      end
  end

  def handleInput
    input = gets.chomp

    # user wants to exit
    if input == 'quit'
       @game_run = false
       puts "Thanks for playing!"
       exit
    end

    input_arr = input.split(" ")
    if input_arr.size > 1 # checks if user has entered second command
      command1 = input_arr[0]
      command2 = input_arr[1]
        ## find matching command
        if command1 == "take"
          takeItem(command2)
        elsif command1 == "use"
          useItem(command2)
        elsif command1 == "go"
          goRoom(command2)
        else
          puts "This is not a valid command"
        end
    else  
      puts "I'll need more information than that"
    end
  end

  def initializeEnvrionment
    ## create items
    @key = Item.new("key", "the key required to escape. Head to the livingroom and use it before the ghost finds you!", "d", true)
    @phone = ScoreItem.new("phone", "a phone! But it's out of charge?", "You've used the phone to leave a good review and the ghost loved it! Your score has improved by one star.", false, 1)
    @charger = Item.new("phone charger", "a charging cable. I'm sure you could find some use for this somewhere", "You've charge the phone, now you can use it!", false)
    @orange_juice = ScoreItem.new("orange juice", "a half empty bottle of orange juice. I'm sure the host won't mind if you finish it off.", "You've just drank all the ghost's favourite juice :( Your AirBnB score has dropped one star.", false, -1)
    @toothbrush = ScoreItem.new("toothbrush", "a toothbrush. You sure could use some fresh breath", "Ew! You've grossed out the ghost and lost a star.", false, -1) 
    
    ## store items together for validation
    @game_items = [@key, @phone, @charger, @orange_juice, @toothbrush]

    ## create rooms
    @lroom_items = [@charger]
    @lroom_exits = {:west => "bedroom"}
    @lroom = Room.new("livingroom","d",true, @lroom_items, @lroom_exits)

    @broom_items = [@phone, @toothbrush]
    @broom_exits = {:east => "livingroom", :south => "kitchen"}
    @broom = Room.new("bedroom","d", false, @broom_items, @broom_exits)

    @kitchen_items = [@orange_juice, @key]
    @kitchen_exits = {:north => "bedroom"}
    @kitchen = Room.new("kitchen", "d", false, @kitchen_items, @kitchen_exits)
  end
    
  def takeItem(command)
 
  end

  def useItem(command)
   
  end

  def goRoom(command)
    if @current_room.hasExit?(command.to_sym) == false
      puts "That isn't an available room!"
    else  
      @current_room = @current_room.hasExit?(command.to_sym)
      puts "You have entered the #{@current_room}!"
    end
  end


end


game = Game.new()
game.run
