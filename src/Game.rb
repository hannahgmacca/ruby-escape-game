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
      puts """Welcome to the AirBnB escape game!

      You have rented an AirBnB for the night and during your stay have realised that you are not the only guest.
      In order to survive, you must interact with the apartment and try to escape.
      Each interaction will bring you a hint or a step closer to your freedom
      Then hen you can leave a one-star review of your memorable stay.

      """
      handleInput
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