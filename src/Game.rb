require 'rainbow'
require_relative 'app/score_item'
require_relative 'app/room'
require_relative 'app/player'

# Creates and stores all game objects
# Begins with printing progress bar and welcome message to user,
# followed by the available commands user can type
# Class will wait for user input until winning/ losingcondition is met or user types 'quit'
class Game
    attr_accessor :run_game, :current_room, :score, :current_item

  def run
    initializeEnvrionment
    @player = Player.new()
    @current_room = @lroom
    @run_game = true

    puts Rainbow("""
      Welcome to the AirBnB escape game!
      You have rented an AirBnB for the night and during your stay have realised that you are not the only guest.
      In order to survive, you must interact with the apartment and try to escape.
      Each interaction will bring you a hint or a step closer to your freedom.
      """).white.bg(:red)
      
      while (@run_game)
        print_commands
        handleInput
      end
      exit
  end

  def handleInput
    input = gets.chomp
    
    # user wants to exit
    if input == 'quit'
       @run_game = false
       puts "Thanks for playing!"
    else
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

  end

  def initializeEnvrionment
    ## create items
    @key = Item.new("key", "Head to the livingroom and use it before the ghost finds you!", "d", true)
    @phone = ScoreItem.new("phone", "But it's out of charge?", "You've used the phone to leave a good review and the ghost loved it! Your score has improved by one star.", false, 1)
    @charger = Item.new("charger", "You could use this to charge up your phone!", "You've charge the phone, now you can use it!", false)
    @orange_juice = ScoreItem.new("orange juice", "I'm sure the host won't mind if you finish it off.", "You've just drank all the ghost's favourite juice :( Your AirBnB score has dropped one star.", false, -1)
    @toothbrush = ScoreItem.new("toothbrush", "You sure could use some fresh breath", "Ew! You've grossed out the ghost and lost a star.", false, -1) 
    
    # for items that need to be used in a certain order
    @charger.give_prerequisite("phone")

    ## create rooms
    @lroom_items = ["charger"]
    @lroom_exits = {:west => "bedroom"}
    @lroom = Room.new("livingroom","d",true, @lroom_items, @lroom_exits)

    @broom_items = ["phone", "toothbrush"]
    @broom_exits = {:east => "livingroom", :south => "kitchen"}
    @broom = Room.new("bedroom","d", false, @broom_items, @broom_exits)

    @kitchen_items = ["orange juice", "key"]
    @kitchen_exits = {:north => "bedroom"}
    @kitchen = Room.new("kitchen", "d", false, @kitchen_items, @kitchen_exits)

    # store items together for validation
    @game_items = [@key, @phone, @charger, @orange_juice, @toothbrush]
    # store rooms together for validation
    @game_rooms = [@kitchen, @broom, @lroom]

  end
    
  def takeItem(command)
    if @current_room.hasItem?(command) == false # item isn't in current room
      puts "This item isn't here"
    else
      # search for instance of item
      @game_items.each do |item|
        if item.isItem?(command)
          @current_item = item
        end
      end
  
      # remove from room and add to backpack
      @current_room.removeItem(command)
      @player.pickUp(command)
      puts "You have picked up the " + @current_item.print_name
      puts @current_item.print_collected
    end
  end

  ## validates item is in backpack then removes it
  def useItem(command)
   item = @player.hasItem?(command)
   if item == false # if this item isn't in backpack
    puts "You aren't carrying this item."
   else  
    @player.removeItem(item)
    puts "You have used the #{item.name}!\n\n#{item.use_description}"
   end
  end

  ## validates user is in room with this exit and then changes current room
  def goRoom(command)
    if @current_room.has_exit?(command)  
       exit_room = @current_room.get_exit(command) # string of room user is trying to enter
       # search for instance of room
       @game_rooms.each do |room|
        if room.is_room?(exit_room)
          @current_room = room # store instance of next room in current room
        end
      end
      puts "You have entered the #{@current_room.print_name}!"
    else  
      puts "That is not a direction you can travel."
    end
  end

  def print_commands
    puts "Your available commands are:\ngo take use help\n\n"
    puts "Directions: "
    current_room.print_exits
  end

end

game = Game.new()
game.run
