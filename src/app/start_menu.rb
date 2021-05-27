require 'tty-prompt'
require "tty-progressbar"
require 'tty-table'
require_relative 'game'

# Class for displaying logo and menu options
# User can select new game, leaderboard or the option to quit the game
class StartMenu
  def initialize
    @star1 = "\u2b50"
    @program_run = true
  end

  # Displays menu prompt to user
  # START initiates game
  def menu
    system('clear')
    while @program_run
      logo
      # Menu prompt
      prompt = TTY::Prompt.new
      user_select = prompt.select("   Would you like to begin?    ".colorize(:color => :black, :background => :white), %w(Start Player\ scores Quit))
      
      # START
      if user_select == "Start"
        system('clear')
        puts "\n\n\n\n\n\n"
        loading_bar
        system('clear')
        new_game

      # PLAYER SCORES
      elsif user_select == "Player\ scores"
        system('clear')
        # Reprint logo
        logo
        # New table
        table = TTY::Table.new(["Player","Score"], [["Hannah", @star1 * 5]])
        # Read from leaderboard file and populate table
        File.readlines("player_scores.txt").each do |line|
          line_arr = line.split(" ")
          score = line_arr[0]
          name = line_arr[1]
          table << [name, @star1 * score.to_i]
        end
        # Display table
        puts table.render(:ascii)
        sleep(5)
        system('clear')

      # QUIT
      elsif user_select == "Quit"
        system('clear')
        exit
      end
    end
  end
end

def logo
  puts"


  ░█████╗░██╗██████╗░██████╗░███╗░░██╗██████╗░  ███████╗░██████╗░█████╗░░█████╗░██████╗░███████╗
  ██╔══██╗██║██╔══██╗██╔══██╗████╗░██║██╔══██╗  ██╔════╝██╔════╝██╔══██╗██╔══██╗██╔══██╗██╔════╝
  ███████║██║██████╔╝██████╦╝██╔██╗██║██████╦╝  █████╗░░╚█████╗░██║░░╚═╝███████║██████╔╝█████╗░░
  ██╔══██║██║██╔══██╗██╔══██╗██║╚████║██╔══██╗  ██╔══╝░░░╚═══██╗██║░░██╗██╔══██║██╔═══╝░██╔══╝░░
  ██║░░██║██║██║░░██║██████╦╝██║░╚███║██████╦╝  ███████╗██████╔╝╚█████╔╝██║░░██║██║░░░░░███████╗
  ╚═╝░░╚═╝╚═╝╚═╝░░╚═╝╚═════╝░╚═╝░░╚══╝╚═════╝░  ╚══════╝╚═════╝░░╚════╝░╚═╝░░╚═╝╚═╝░░░░░╚══════╝
".colorize(:red)
  puts "                                  Terminal Game by Hannah McDonald
  
  "
end 

# Initiate a new game
# If player entered a name then score is recorded with that name
# otherwise is records it as 'anonymous'
def new_game
  if ARGV[0]
    # User entered a value at the start
    @game = Game.new(ARGV[0])
  else 
    @game = Game.new("Anonymous")
  end
    @game.run
end

def loading_bar
  bar = TTY::ProgressBar.new("loading [:bar]".center(112), total: 30, bar_format: :box)
  30.times do
    sleep(0.1)
    bar.advance  # by default increases by 1
  end
end

start = StartMenu.new
start.menu