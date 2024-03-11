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
    @secret_code_array.each_with_index do |code_value, index_of_code|
      current_hint.push(get_type_of_hint(code_value, index_of_code, current_guess))
    end
    current_hint.shuffle!
  end

  def get_type_of_hint(code_value, index_of_code, current_guess)
    if code_value == current_guess[index_of_code]
      'black'
    elsif current_guess.include?(code_value)
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
    puts 'time to make a new code, if it is a human playing, please get your opponent to look away while you decide'
    puts 'if it is a computer codebreaker please start to try to crack the code'
    puts "the colors are #{COLORS}"
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
    return @secret_code_array = %w[red blue green yellow]
    puts 'please make a code that will be guessed, hide the screen from the code breaker while you make your selection'
    @secret_code_array = []
    place_row_of_colors(true)
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
