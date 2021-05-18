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

    def initialize(user_name)
      @user_name = user_name
    end

  def run
    initializeEnvrionment
    player = Player.new
    @run_game = true
    @current_room = "livingroom"

    puts """
      Welcome to the AirBnB escape game!

      You have rented an AirBnB for the night and during your stay have realised that you are not the only guest.
      In order to survive, you must interact with the apartment and try to escape.
      Each interaction will bring you a hint or a step closer to your freedom

      """

      while (@run_game)
        handleInput
      end
  end

  def handleInput
    input = gets.strip
    case input
      when input == "exit" then @run_game = false
      when input == "take" then takeItem
      when input == "use" then useItem
      when input == "go" then goRoom
    end
  end

  def initializeEnvrionment
    ## create items
    key = Item.new("key", "the key required to escape. Head to the livingroom and use it before the ghost finds you!", "d", true)
    phone = ScoreItem.new("phone", "a phone! But it's out of charge?", "You've used the phone to leave a good review and the ghost loved it! Your score has improved by one star.", false, 1)
    charger = Item.new("phone charger", "a charging cable. I'm sure you could find some use for this somewhere", "You've charge the phone, now you can use it!", false)
    orange_juice = ScoreItem.new("orange juice", "a half empty bottle of orange juice. I'm sure the host won't mind if you finish it off.", "You've just drank all the ghost's favourite juice :( Your AirBnB score has dropped one star.", false, -1)
    toothbrush = ScoreItem.new("toothbrush", "a toothbrush. You sure could use some fresh breath", "Ew! You've grossed out the ghost and lost a star.", false, -1) 

    ## create rooms
    lroom_items = [charger]
    lroom_exits = {:west => "bedroom"}
    lroom = Room.new("livingroom","d",true, lroom_items, lroom_exits)

    broom_items = [phone, toothbrush]
    broom_exits = {:east => "livingroom", :south => "kitchen"}
    broom = Room.new("bedroom","d", false, broom_items, broom_exits)

    kitchen_items = [orange_juice, key]
    kitchen_exits = {:north => "bedroom"}
    kitchen = Room.new("kitchen", "d", false, kitchen_items, kitchen_exits)
  end
    
end

  def takeItem
  end

  def useItem
  end

  def goRoom
  end

game = Game.new("Hannah")
game.run