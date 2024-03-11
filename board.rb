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
    # should trigger, display all guesses, display hints from previous guesses,
    # check game finished(num of turns left or win condition is true)
    #check win before check turns left
    add_to_guess_array(current_guess)
    add_to_hint_array(current_hint)
    display_all_guesses_and_hints
    update_turns_left
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
    puts "\n there are #{@turns_left} turns left"
  end
end
