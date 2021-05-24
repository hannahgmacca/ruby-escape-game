require 'tty-prompt'
require "tty-progressbar"
require 'artii'
require 'gosu'
require_relative 'game'


class StartMenu
    def initialize
        @program_run = true
    end

    def menu
        while @program_run
            logo
            prompt = TTY::Prompt.new
            user_select = prompt.select("   Would you like to begin?    ".colorize(:color => :black, :background => :white), %w(Start Leaderboard:InDevelopment Quit))
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
                @game = Game.new
                @game.run
            elsif user_select == "Quit"
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