require 'colorize'
require_relative 'score_item'
require_relative 'item'
require_relative 'room'
require_relative 'player'

# Creates and stores all game objects
# Begins with printing progress bar and welcome message to user,
# followed by the available commands user can type
# Class will wait for user input until winning/ losing condition is met or user types 'quit'
class Game
    attr_accessor :run_game, :current_room, :score, :current_item

  def initialize
    initialize_environment
    @player = Player.new()
    @current_room = @lroom
    @score = 3
    @run_game = true
    @used_items = []
  end

  def run
    print_welcome

    while (@run_game)
      puts "\n"
      print_commands
      handle_input
    end
  end

  def handle_input
    input = gets.chomp
    system('clear')
    # single word commands
    if input == 'quit'
       @run_game = false
       puts "Thanks for playing!"
       sleep(3)
       system('clear')
    elsif input == 'backpack'
      @player.print_backpack
    elsif input == 'help'
      puts "Use the commands to move around the AirBnB and use items to help you escape."
    else
      ## double word commands 
      input_arr = input.split(" ")
      if input_arr.size > 1
        command1 = input_arr[0]
        command2 = input_arr[1]
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

  # Initialises all game objects and their attributes
  def initialize_environment
    # Create items
    @key = Item.new("key", "Head to the livingroom and use it before the ghost finds you!", "d", true)
    @phone = ScoreItem.new("phone", "This works better with charge", "You've used the phone to leave a good review and the ghost loved it! Your score has improved by one star.", false, 1)
    @charger = ScoreItem.new("charger", "You could use this to charge up your phone!", "You've charged the phone.", false, 1)
    @juice = ScoreItem.new("juice", "I'm sure the host won't mind if you finish it off.", "You've just drank all the ghost's favourite juice :( Your AirBnB score has dropped one star.", false, -1)
    @toothbrush = ScoreItem.new("toothbrush", "You sure could use some fresh breath", "Ew! You've grossed out the ghost and lost a star.", false, -1)
    # Store start characters used to print score
    @star1 = "\u2b50"
    @star2 = "\u2606"
    ## Create rooms and store items
    # livingroom
    @lroom_items = ["charger"]
    @lroom_exits = {:west => "bedroom"}
    @lroom = Room.new("livingroom","d",true, @lroom_items, @lroom_exits)
    # bedroom
    @broom_items = ["phone", "toothbrush"]
    @broom_exits = {:east => "livingroom", :south => "kitchen"}
    @broom = Room.new("bedroom","d", false, @broom_items, @broom_exits)
    # kitchen
    @kitchen_items = ["juice", "key"]
    @kitchen_exits = {:north => "bedroom"}
    @kitchen = Room.new("kitchen", "d", false, @kitchen_items, @kitchen_exits)

    # Store items together for validation
    @game_items = [@key, @phone, @charger, @juice, @toothbrush]
    # Store rooms together for validation
    @game_rooms = [@kitchen, @broom, @lroom]

  end
    
  def take_item(command)
    if @current_room.has_item?(command) == false # item isn't in current room
      puts "This item isn't here\n"
    else
      # Search for instance of this item
      # and store reference to it
      @game_items.each do |item|
        if item.is_item?(command)
          @current_item = item
        end
      end
      @current_room.remove_item(command)
      @player.pick_up(command)
      puts "You have picked up a #{@current_item.name}"
      puts @current_item.collect_description + "\n\n"
    end
  end

  # Validates item is in room and depending on item type
  # will adjust variables or set winning condition to true
  def use_item(command)
    if @player.has_item?(command)
      # Search for instance of this item and 
      # return object with matching name
      @game_items.each do |item|
        if item.is_item?(command)
          @current_item = item
        end
      end
      if @current_item.is_key? 
        # Item is a key
        if @current_room == @lroom 
          # Room is livingroom
          puts "Congratulations! You escaped the AirBnB"
          puts "You escaped with a rating of: \n"
          puts @star1.encode('utf-8') * @score
          puts "\n\n\nThanks for playing!\n"
          sleep(3)
          system('clear')
          @run_game = false
        else 
          puts "You are not using this item in the correct room!"
        end
      elsif @current_item.is_a? ScoreItem
          # Item adjusts score
          @score += @current_item.score
          puts "You now have a guest rating of #{@score}"
          puts @star1.encode('utf-8') * @score # print star rating
          @player.remove_item(command)
          @used_items << command
          puts "\n#{@current_item.use_description}\n"
          # Score reaches 0
          if @score == 0
            puts "You have a guest rating of 0."
            puts "The g-host has killed you.".colorize(:color => :white, :background => :red)
            run_game = false
          end
      end
    else  
      puts "You aren't carrying this item.\n"
    end
  end

  # Validates direction inputted leads to a room
  # Updates current room 
  def go_room(command)
    if @current_room.has_exit?(command) 
      # current room has this exit 
       exit_room = @current_room.get_exit(command) # return string of room name
       # Search for instance of this room
       # update current room
       @game_rooms.each do |room|
        if room.is_room?(exit_room)
          @current_room = room # update current room
        end
      end
      puts "You have entered the #{@current_room.print_name}!\n"
    else  
      puts "That is not a direction you can travel.\n"
    end
  end

  def print_commands
    puts "Your available commands are: ".green
    puts "\ngo take use help backpack quit\n\n"
    puts "Directions:".green
    @current_room.print_exits
    if @current_room.has_items?
      # Room has items in it
      puts "\nItems available: ".colorize(:green)
      @current_room.print_items
      puts "\n"
    else
      puts "\nThere are no items in this room".green
      puts "\n"
    end
  end

  def print_welcome
    welc_arr = [
      "                     Welcome to the AirBnB escape game!                     ",
      "         You have rented an AirBnB for the night and during your stay       ",
      "                 have realised that you are not the only guest.             ",
      "In order to survive, you must interact with the apartment and try to escape.",
      "  Each interaction will bring you a hint or a step closer to your freedom.  "]

      welc_arr.each do |string|
        puts string.colorize(:color => :white, :background => :red)
      end
  end

end