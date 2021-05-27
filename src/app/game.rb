require 'colorize'
require "tty-box"
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

  def initialize(username)
    initialize_environment
    @player = Player.new()
    @current_room = @lroom
    @score = 3 # user begins with a rating of 3
    @run_game = true
    @username = username
  end

  def run
    print_welcome
    while (@run_game)
      puts "\n"
      print_commands
      handle_input
    end
  end

  # Class to read input from user and compare again known commands
  # some commands require two words
  def handle_input
    # Takes user input
    input = STDIN.gets.chomp
    system('clear')

    # Single word commands
    # QUIT
    if input == 'quit'
       @run_game = false
       puts "Thanks for playing!"
       sleep(3)
       system('clear')

    # BACKPACK
    elsif input == 'backpack'
      @player.print_backpack

    # HELP
    elsif input == 'help'
      puts "Use the commands to move around the AirBnB and use items to help you escape."

    else
      # Double word commands 
      input_arr = input.split(" ")
      # User has only entered one word
      if input_arr.size > 1
        command1 = input_arr[0]
        command2 = input_arr[1]
          # TAKE ITEM
          if command1 == "take"
            take_item(command2)
          # USE ITEM
          elsif command1 == "use"
            use_item(command2)
          # GO ROOM
          elsif command1 == "go"
            go_room(command2)
          else
            # User doesn't specify second command
            puts "I'll need more information than that!"
          end
      else
        # User enters invalid command word
        puts "That isn't a valid command"
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
   
    # Store star characters used to print score
    @star1 = "\u2b50"

    ## Create rooms and store items
    # livingroom
    @lroom_items = ["charger"]
    @lroom_exits = {:west => "bedroom"}
    @lroom = Room.new("livingroom", @lroom_items, @lroom_exits)
    # bedroom
    @broom_items = ["phone", "toothbrush"]
    @broom_exits = {:east => "livingroom", :south => "kitchen"}
    @broom = Room.new("bedroom", @broom_items, @broom_exits)
    # kitchen
    @kitchen_items = ["juice", "key"]
    @kitchen_exits = {:north => "bedroom"}
    @kitchen = Room.new("kitchen", @kitchen_items, @kitchen_exits)

    # Store items together for validation
    @game_items = [@key, @phone, @charger, @juice, @toothbrush]
    # Store rooms together for validation
    @game_rooms = [@kitchen, @broom, @lroom]

  end
  
  # Validates item is in room
  # Removes item from room and adds to players backpack
  def take_item(command)
    if @current_room.has_item?(command) # item isn't in current room
      self.new_current_item(command)
      # Remove from room and add to backpack
      @current_room.remove_item(command)
      @player.pick_up(command)
      puts "\nYou have picked up a #{@current_item.name}"
      puts @current_item.collect_description + "\n\n"
    else
      puts "This item isn't here\n"
    end
  end

  # Validates item is in backpack and depending on item type
  # either adjusts score or finishes game
  def use_item(command)
    if @player.has_item?(command)
      # Player is carrying item
      self.new_current_item(command)
      if @current_item.is_key? 
        if @current_room == @lroom 
          puts "Congratulations! You escaped the AirBnB"
          puts "You escaped with a rating of: \n"
          puts @star1.encode('utf-8') * @score
          puts "\n\n\nThanks for playing!\n"
          # Write score to player scores file
          write_to_file("#{@score} #{@username}","player_scores.txt")
          sleep(3)
          system('clear')
          @run_game = false
        else 
          puts "You are not using this item in the correct room!"
        end
      elsif @current_item.is_a? ScoreItem
          # Item adjusts score
          @score += @current_item.score
          if @score == 1
            # Score reaches 0
            puts "\nYour guest rating dropped too low."
            puts "\nThe gHost has killed you.".colorize(:color => :white, :background => :red)
            sleep(2.5)
            system('clear')
            @run_game = false
          else
            puts "\n#{@current_item.use_description}\n\n"
            puts "You now have a guest rating of #{@score}".colorize(:blue)
            puts @star1.encode('utf-8') * @score # print star rating
            @player.remove_item(command)
          end
      else  
        puts "You aren't carrying this item.\n"
      end
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
      puts "\nYou have entered the #{@current_room.print_name}!\n"
    else  
      puts "That is not a direction you can travel.\n"
    end
  end

  # Print available commands, directions, rooms & items
  def print_commands
    puts "Your available commands are: ".green
    puts "go take use help backpack quit\n\n"
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

  # Print welcome message to user 
  # formatted in a red bo with a border
  def print_welcome
    box = TTY::Box.frame(width: 90, height: 17, align: :center, style: {bg: :red}) do
      "\nWelcome to the AirBnB escape game!\n
      You have rented an AirBnB for the night and during your stay\n
      have realised that your super host might be supernatural.\n
      In order to survive, you must interact with the apartment and try to escape.\n
      Each interaction will bring you a hint or a step closer to your freedom.\n
      Be careful though, as some items can damage your guest rating.\n
      If you reach a rating of 0, the g-host will kill you." 
    end
    print box
  end

  # Opens file and writes new line to it
  def write_to_file(line, my_file)
    # Error Handling
    begin
    File.open(my_file, "a") { |f| f.write "#{line}\n" }
    rescue => e
      raise FileNotFoundError,"Could not find file"
      puts e.message
      puts e.backtrace.inspect
    end
  end

  # Validates item as an item in the game and updates current item
  def new_current_item(command)
    @game_items.each do |item|
      if item.is_item?(command)
        @current_item = item
      end
    end
  end

end

