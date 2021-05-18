require 'tty-prompt'

class StartMenu

    def menu
        loop do
            prompt = TTY::Prompt.new
            user_select = prompt.select("Would you like to begin?", %w(Start Leaderboard Quit))
        
            if user_select == "Start"
                system("clear")
                puts "Are you ready?".center(112)
                # loading bar here
                break
            elsif user_select == "Leaderboard"
                puts "LEADERBOARD".center(112)
            elsif user_select == "Quit"
                exit
            end
        end

    end
end