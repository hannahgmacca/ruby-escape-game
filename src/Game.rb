# ruby src/game.rb
require 'rainbow'
require 'artii'
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
    initialize_environment
    @player = Player.new()
    @current_room = @lroom
    @score = 3
    @run_game = true

    puts Rainbow("""

      Welcome to the AirBnB escape game!
      You have rented an AirBnB for the night and during your stay have realised that you are not the only guest.
      In order to survive, you must interact with the apartment and try to escape.
      Each interaction will bring you a hint or a step closer to your freedom.
      """).white.bg(:red)

    while (@run_game)
      print_commands
      handle_input
    end
    exit
  end

  def handle_input
    input = gets.chomp
    system('clear')
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
            take_item(command2)
          elsif command1 == "use"
            use_item(command2)
          elsif command1 == "go"
            go_room(command2)
          else
            puts "This is not a valid command"
          end
      else  
        puts "I'll need more information than that"
      end
    end

  end

  def initialize_environment
    ## create items
    @key = Item.new("key", "Head to the livingroom and use it before the ghost finds you!", "d", true)
    @phone = ScoreItem.new("phone", "But it's out of charge?", "You've used the phone to leave a good review and the ghost loved it! Your score has improved by one star.", false, 1)
    @charger = Item.new("charger", "You could use this to charge up your phone!", "You've charge the phone, now you can use it!", false)
    @orange_juice = ScoreItem.new("orange juice", "I'm sure the host won't mind if you finish it off.", "You've just drank all the ghost's favourite juice :( Your AirBnB score has dropped one star.", false, -1)
    @toothbrush = ScoreItem.new("toothbrush", "You sure could use some fresh breath", "Ew! You've grossed out the ghost and lost a star.", false, -1) 
    
    # store characters for printing score
    @star1 = "\u2b50"
    @star2 = "\u2606"

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
    
  def take_item(command)
    if @current_room.has_item?(command) == false # item isn't in current room
      puts "This item isn't here\n"
    else
      # search for instance of item
      @game_items.each do |item|
        if item.is_item?(command)
          @current_item = item
        end
      end
      # remove from room and add to backpack
      @current_room.remove_item(command)
      @player.pick_up(command)
      puts "You have picked up a #{@current_item.name}"
      puts @current_item.collect_description + "\n\n"
    end
  end

  ## validates item is in backpack then removes it
  def use_item(command)
    if @player.has_item?(command)

      # search for instance of this item
      @game_items.each do |item|
        if item.is_item?(command)
          @current_item = item
        end
      end
      @player.remove_item(command)
      puts "\n#{@current_item.use_description}\n"

      # increase / decrease AirBNB score
      if @current_item.is_a? ScoreItem
        @score += @current_item.score
        puts "You now have a guest rating of #{@score}"
        puts @star1.encode('utf-8') * @score
      elsif @current_item.is_key?
        puts "Congratulations! You escaped the AirBnB"
        puts "You escaped with a rating of: \n"
        puts @star1.encode('utf-8') * @score
        puts "\n\n\nThanks for playing!\n"
        @run_game = false
      end
    else  
      puts "You aren't carrying this item.\n"
    end
  end

  ## validates user is in room with this exit and then changes current room
  def go_room(command)
    if @current_room.has_exit?(command)  
       exit_room = @current_room.get_exit(command) # string of room user is trying to enter
       # search for instance of room
       @game_rooms.each do |room|
        if room.is_room?(exit_room)
          @current_room = room # store instance of next room in current room
        end
      end
      puts "You have entered the #{@current_room.print_name}!\n"
    else  
      puts "That is not a direction you can travel.\n"
    end
  end

  def print_commands
    puts "Your available commands are:\ngo take use help\n\n"
    puts "Directions: \n"
    @current_room.print_exits
    if @current_room.has_items?
      puts "\nItems available: "
      @current_room.print_items
      puts "\n"
    else
      puts "\nThere are no items in this room"
      puts "\n"
    end
  end

end

game = Game.new()
game.run
