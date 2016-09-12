require "./battleship_methods.rb"

$winner = nil # tells parser who the winner is; nil = game not over
$testing = false # not used at present
$message = '' # stuff that is saved to be displayed to the user after the board
$random = true # half the time, the computer guesses randomly

# enclosing loop
game_on = true
while game_on == true
  computer_board, player_board = play_game
  # reports results and prompts for another game
  report_and_prompt(computer_board, player_board)
  game_on = false
end
