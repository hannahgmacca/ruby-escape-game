require 'tty-prompt'
require "tty-progressbar"
require "tty-table"
require_relative 'game'

class StartMenu
    def initialize
        @program_run = true
        @table = TTY::Table.new ["Name", "Score"]
    end

    def menu
        while @program_run
            logo
            # Menu prompt
            prompt = TTY::Prompt.new
            user_select = prompt.select("   Would you like to begin?    ".colorize(:color => :black, :background => :white), %w(Start Leaderboard Quit))
            if user_select == "Start"
              system('clear')
              puts "\n\n\n\n\n\n"
              # Loading bar
              bar = TTY::ProgressBar.new("loading [:bar]".center(112), total: 30, bar_format: :box)
              30.times do
                sleep(0.1)
                bar.advance  # by default increases by 1
              end
              system('clear')
              # New game
              if ARGV[0]
                @game = Game.new(ARGV[0])
              else 
                @game = Game.new("Your name")
              end
              @game.run
            elsif user_select == "Leaderboard"
              # Read from leaderboard file
              File.readlines("Leaderboard.txt").each do |line|
                line_arr = line.split(" ")
                name = line_arr[0]
                score = line_arr[1]
                @table << [name, score]
              end
              @table.render(:basic, alignments: [:left, :center])
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
start = StartMenu.new
start.menu