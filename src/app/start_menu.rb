require 'tty-prompt'
require "tty-progressbar"
require 'artii'

class StartMenu

    def menu
        loop do
            prompt = TTY::Prompt.new
            user_select = prompt.select("Would you like to begin?".center(112), %w(Start Leaderboard Quit))
            if user_select == "Start"
                system('clear')
                puts "\n\n\n\n\n\n"
                # LOADING BAR
                bar = TTY::ProgressBar.new("loading [:bar]".center(112), total: 30, bar_format: :box)
                30.times do
                    sleep(0.1)
                    bar.advance  # by default increases by 1
                end
                system('clear')
                break
            elsif user_select == "Leaderboard"
                puts "LEADERBOARD".center(112)
            elsif user_select == "Quit"
                exit
            end
        end

    end
end