# class board
class Board
  attr_accessor :code_breaker_guess_array, :code_maker_hint_array

  def initialize
    puts 'Time to Play mastermind'
    @code_breaker_guess_array = []
    @code_maker_hint_array = []
    @turns_left = 12
  end

  def update_board(current_guess, current_hint)
    add_to_guess_array(current_guess)
    add_to_hint_array(current_hint)
    display_all_guesses_and_hints
  end

  def check_end_of_game(current_hint)
    update_turns_left
    check_win(current_hint)
  end

  def add_to_hint_array(current_hint)
    @code_maker_hint_array.push(current_hint)
  end

  def add_to_guess_array(current_guess)
    @code_breaker_guess_array.push(current_guess)
  end

  def display_all_guesses_and_hints
    puts "\n       The hints have been                      your guesses have been\n\n"
    @code_breaker_guess_array.each_with_index do |guess, index|
      puts "hint # #{index + 1} #{@code_maker_hint_array[index].join(' ')}         guess # #{index + 1} #{guess.join(' ')}"
    end
  end

  def update_turns_left
    @turns_left -= 1
    if @turns_left.zero?
      puts 'there are no more turns left, the code maker has won'
      return true
    end
    puts "\n there are #{@turns_left} turns left"
    false
  end

  def check_win(current_hint)
    if current_hint.all? { |color| color == 'black' }
      puts 'congrats you won'
      return true
    end
    false
  end
end
