# missing frozen string literal warning rubocop
require 'set'
require 'io/console'

# class board
class Board
  attr_accessor :code_breaker_guess_array, :code_maker_hint_array

  def initialize
    puts 'Time to Play mastermind'
    @code_breaker_guess_array = []
    @code_maker_hint_array = []
  end

  def update_board(current_guess)
    # should trigger, display all guesses, display hints from previous guesses,
    # check game finished(num of turns left or win condition is true)
    add_to_guess_array(current_guess)
    add_to_hint_array(current_guess)
    display_all_guesses_and_hints
  end

  def add_to_hint_array(current_guess)
    current_hint = []
    @secret_code.each_with_index do |code_value, index_of_code|
      if code_value == current_guess[index_of_code]
        current_hint.push('black')
      elsif current_guess.include?(code_value)
        current_hint.push('white')
      else
        current_hint.push('blank')
      end
    end
    p current_hint.shuffle!
  end
  # push the colors to a temp array and pass it to the place pegs definition after that.
  # change player class to not have include?COLORLS make it part of the codemaking and then the codebreaker class
  # try using super or a different way to do that, will clean up the code better and not have to repeat the
  # place pegs definition

  def add_to_guess_array(current_guess)
    @code_breaker_guess_array.push(current_guess)
  end

  def display_all_guesses_and_hints
    puts "\n       your guesses have been                      The hints have been\n\n"
    @code_breaker_guess_array.each_with_index do |guess, index|
      puts "guess # #{index + 1} #{guess}}                       hint # #{index + 1} #{@code_maker_hint_array[index]}"
      # puts guess.join(' ')
    end
  end

  def place_secret_code(array)
    @secret_code = array
  end
end

# class player
class Player
  COLORS = Set['red', 'blue', 'green', 'orange', 'purple', 'yellow']
  def place_row_of_colors(array, hide_answer = false)
    while array.length < 4
      color = if hide_answer == true
                $stdin.noecho(&:gets).chomp
              else
                gets.chomp
              end
      array.push(color) if COLORS.include?(color)
    end
  end

  def place_row_of_hints(array)
    @secret_code_array.each_with_index do |code_value, index_of_code|
      if code_value == current_guess[index_of_code]
        current_hint.push('black')
      elsif current_guess.include?(code_value)
        current_hint.push('white')
      else
        current_hint.push('blank')
      end
    end
    p current_hint.shuffle!
  end
end

# class code maker inherits from player class
class CodeMaker < Player
  def initialize
    super
    puts 'time to make a new code, if it is a human playing, please get your opponent to look away while you decide'
    puts 'if it is a computer codebreaker please start to try to crack the code'
    puts "the colors are #{COLORS}"
  end

  def give_hint
    hint_array = []
    place_row_of_hints(hint_array)
    hint_array
  end
end

# computer code maker class inherits from codemaker and player
class ComputerCodeMaker < CodeMaker
  def initialize
    super
    puts 'computer is deciding a random assignment of colors'
  end

  def create_secret_code
    puts 'the comp is making the secret code'
  end
end

# human code maker class inherits from codemaker and player
class HumanCodeMaker < CodeMaker
  def create_secret_code
    return %w[red blue green yellow]
    puts 'please make a code that will be guessed, hide the screen from the code breaker while you make your selection'
    @secret_code_array = []
    place_row_of_colors(@secret_code_array, true)
    puts "you chose: #{@secret_code_array}"
    @secret_code_array
  end
end

# class code breaker
class CodeBreaker < Player
  def make_guess
    puts "\n\nmake your guess now"
  end
end

class ComputerCodeBreaker < CodeBreaker
end

# Human code breaker class for guessing the secret code.
class HumanCodeBreaker < CodeBreaker
  def make_guess
    guess_array = []
    super
    place_row_of_colors(guess_array)
    guess_array
  end
end
# general rules of the game a master creates a secret code with 4 different colors in 4 different spots
# the guesser has to eventually break the code.
# They do that by placing colored pegs into the holes and the master then gives hints according to the placed pegs
# a white peg means right color wrong place. a black peg means right color and right spot.

# put prompts here on whether you want 2 players, or the computer to guess and you to make the code.
game = Board.new
code_maker = HumanCodeMaker.new
code_breaker = HumanCodeBreaker.new
secret_code = code_maker.create_secret_code
game.place_secret_code(secret_code)
#game.place_secret_code(code_maker.create_secret_code)
new_guess = code_breaker.make_guess
game.update_board(new_guess)
new_guess = code_breaker.make_guess
game.update_board(new_guess)
