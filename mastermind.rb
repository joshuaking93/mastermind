# missing frozen string literal warning rubocop
require 'set'
require 'io/console'

# class board
class Board
  attr_accessor :code_breaker_guess_array, :code_maker_hint_array

  def initialize
    puts 'Time to Play mastermind'
    @code_breaker_guess_array = []
    @code_maker_hint_array = ['black', 'white', 'black', 'white']
  end

  def update_board(current_guess)
    # should trigger, display all guesses, display hints from previous guesses,
    # check game finished(num of turns left or win condition is true)
    add_to_guess_array(current_guess)
    add_to_hint_array
    display_all_guesses_and_hints
  end

  def add_to_hint_array
  end

  def add_to_guess_array(current_guess)
    @code_breaker_guess_array.push(current_guess)
  end

  def display_all_guesses_and_hints
    puts "\nyour guesses have been           The hints have been\n\n"
    @code_breaker_guess_array.each do |guess|
      @code_maker_hint_array.each do |hint|
        puts "       hint #{hint.join(' ')}"
      end
      puts guess.join(' ')
    end
  end
end

# class player
class Player
  COLORS = Set['red', 'blue', 'green', 'orange', 'purple', 'yellow']
  def place_row_of_pegs(array, hide_answer = false)
    while array.length < 4
      color = if hide_answer == true
                $stdin.noecho(&:gets).chomp
              else
                gets.chomp
              end
      array.push(color) if COLORS.include?(color)
    end
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
    secret_code_array = []
    place_row_of_pegs(secret_code_array, true)
    puts "you chose: #{secret_code_array}"
    secret_code_array
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
    place_row_of_pegs(guess_array)
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
p code_maker.create_secret_code
game.update_board(code_breaker.make_guess)

# board class in charge of board state, num of turns left,

# player class that has general rules for ALL players and not just codemaker or breaker.

# codemaker class that has some basic rules for the codemaker
# computer codemaker as subclass of codemaker
# human codemaker as subclass of codemaker

# codebreaker class that follows general rules of code breaking
# computer codebreaker as subclass of codebreaker
# human codebreaker as subclass of code breaker
