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
code_maker = HumanCodeMaker.new
code_breaker = HumanCodeBreaker.new
code_maker.create_secret_code
game_end = false
while game_end == false
  new_guess = code_breaker.make_guess
  new_hint = code_maker.give_hint(new_guess)
  game.update_board(new_guess, new_hint)
  game_end = game.check_end_of_game(new_hint)
end
