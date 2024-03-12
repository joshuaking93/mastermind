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
end

# class code maker inherits from player class
class CodeMaker < Player
  def initialize
    super
    @secret_code_array = []
    puts 'time to make a new code, if you are playing with another human, please get your opponent to look away while
    you decide
    if it is a computer code maker please start to try to crack the code'
    puts "the colors are
    #{COLORS.join(' ')}"
  end

  def give_hint(current_guess)
    place_row_of_hints(current_guess)
  end

  def place_row_of_hints(current_guess)
    current_hint = []
    temp_secret_code = @secret_code_array.dup
    temp_current_guess = current_guess.dup
    get_color_of_hint(temp_secret_code, temp_current_guess, current_hint)
    current_hint.compact!
  end

  def get_color_of_hint(temp_secret_code, temp_current_guess, current_hint)
    temp_current_guess.each_with_index do |guess_color, index|
      current_hint.push(get_black_pegs(guess_color, index, temp_secret_code, temp_current_guess))
    end
    temp_current_guess.each_with_index do |guess_color, index|
      current_hint.push(get_white_pegs(temp_secret_code, guess_color, index, temp_current_guess))
    end
    temp_current_guess.each_with_index do |guess_color, index|
      current_hint.push(get_blank_pegs(guess_color))
    end
  end

  def get_black_pegs(guess_value, index_of_guess, temp_secret_code, temp_current_guess)
    if guess_value == @secret_code_array[index_of_guess]
      temp_secret_code[index_of_guess] = 'removed'
      temp_current_guess[index_of_guess] = 'removed!'
      'black'
    end
  end

  def get_white_pegs(temp_secret_code, guess_value, index_of_guess, temp_current_guess)
    if temp_secret_code.include?(guess_value)
      temp_current_guess[index_of_guess] = 'REMOVED'
      'white'
    end
  end

  def get_blank_pegs(guess_value)
    if COLORS.include?(guess_value)
      'blank'
    end
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
    puts 'please make a code that will be guessed, hide the screen from the code breaker while you make your selection'
    @secret_code_array = place_row_of_colors(true)
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
