# class player
class Player
  COLORS = Set['red', 'blue', 'green', 'orange', 'purple', 'yellow']
  def place_row_of_colors(hide_answer = false)
    color_array = []
    while color_array.length < 4
      color = if hide_answer == true
                $stdin.noecho(&:gets).chomp
              else
                gets.chomp
              end
      push_to_array(color, color_array)
    end
    color_array
  end

  def push_to_array(color, color_array)
    multiple_colors = color.split(' ')
    multiple_colors.each do |current_color|
      color_array.push(current_color) if COLORS.include?(current_color)
    end
  end

  def place_row_of_hints(current_guess)
    current_hint = []
    @secret_code_array.each_with_index do |secret_code_value, index_of_code|
      current_hint.push(get_type_of_hint(secret_code_value, index_of_code, current_guess))
    end
    current_hint.sort!
  end

  def get_type_of_hint(secret_code_value, index_of_code, current_guess)
    if secret_code_value == current_guess[index_of_code]
      'black'
      # figure this out tomorrow!!
      # figure out how to splice the array without modifying it and then add that method to the black or white options
      # for each element of the secret code, check if the guess has the same color in the same spot, if it does then black
      # if it isn't check the other elements of the guess to see if it has the same color anywhere else and splice the guess down
      # if black or white
      elsif current_guess[index_of_code].include?()
      'white'
    else
      'blank'
    end
  end
end

# class code maker inherits from player class
class CodeMaker < Player
  def initialize
    super
    puts 'time to make a new code, if you are playing with another human, please get your opponent to look away while
    you decide
    if it is a computer code maker please start to try to crack the code'
    puts "the colors are
    #{COLORS.join(' ')}"
  end

  def give_hint(current_guess)
    place_row_of_hints(current_guess)
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
    return @secret_code_array = %w[red blue red blue]
    puts 'please make a code that will be guessed, hide the screen from the code breaker while you make your selection'
    @secret_code_array = []
    @secret_code_array = place_row_of_colors(true)
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
    super
    place_row_of_colors
  end
end
