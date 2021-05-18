require 'colorize'

# Creates and stores all game objects
# Begins with printing progress bar and welcome message to user,
# followed by the available commands user can type
# Class will wait for user input until winning/ losingcondition is met or user types 'quit'
class Game
    att_accessor :game

  def run
    printWelcome
      while (game)
      # take user input
      # process input
      end
  end

  def handleInput
    input = gets.strip

    case input
    when input.eq?("exit") then @game = false
    when input.eq?("take") then takeItem
    when input.eq("use") then useItem
    when input.eq("go") then goRoom
    when input.eq() then
    end

  end

end