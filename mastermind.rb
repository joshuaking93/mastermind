# missing frozen string literal warning rubocop
require 'set'
require 'io/console'
require_relative 'player'
require_relative 'board'

# put prompts here on whether you want 2 players, or the computer to guess and you to make the code.
game = Board.new
# puts "choose 1: human code maker vs human code breaker
#        2: human code maker vs computer code breaker
#        3: computer code maker vs human code breaker
#        4: computer code maker vs computer code breaker"

puts "chose whether you want
1: human vs human
2: human vs computer"
choice = gets.chomp
case choice
when '1'
  puts 'you chose human vs human'
  code_maker = HumanCodeMaker.new
  code_breaker = HumanCodeBreaker.new
when '2'
  puts 'you chose human vs computer'
  code_maker = ComputerCodeMaker.new
  code_breaker = HumanCodeBreaker.new
end

code_maker.create_secret_code
game_end = false
while game_end == false
  new_guess = code_breaker.make_guess
  new_hint = code_maker.place_row_of_hints(new_guess)
  game.update_board(new_guess, new_hint)
  game_end = game.check_end_of_game(new_hint)
end
