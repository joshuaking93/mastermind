# missing frozen string literal warning rubocop
require 'set'
require 'io/console'
require_relative 'player'
require_relative 'board'

# put prompts here on whether you want 2 players, or the computer to guess and you to make the code.
game = Board.new
code_maker = HumanCodeMaker.new
code_breaker = HumanCodeBreaker.new
secret_code = code_maker.create_secret_code
# game.place_secret_code(secret_code)
new_guess = code_breaker.make_guess
new_hint = code_maker.give_hint(new_guess)
game.update_board(new_guess, new_hint)
new_guess = code_breaker.make_guess
new_hint = code_maker.give_hint(new_guess)
game.update_board(new_guess, new_hint)
