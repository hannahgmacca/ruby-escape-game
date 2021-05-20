require 'tty-prompt'
require "tty-progressbar"
require_relative '../game.rb'

class StartMenu

    def menu
        loop do
            prompt = TTY::Prompt.new
            user_select = prompt.select("Would you like to begin?", %w(Start Leaderboard Quit))
        
            if user_select == "Start"
                system("clear")
                sleep(3)

                # LOADING BAR
                bar = TTY::ProgressBar.new("downloading [:bar]", total: 30)
                30.times do
                    sleep(0.1)
                    puts "Are you ready?".center(112)
                    bar.advance  # by default increases by 1
                  end
                # game = Game.new()
                # game.run
                break
            elsif user_select == "Leaderboard"
                puts "LEADERBOARD".center(112)
            elsif user_select == "Quit"
                exit
            end
        end

    end
end

menu = StartMenu.new
menu.menu