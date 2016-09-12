require "./test_index.rb" # to include AITestSuite module, for AI functions
require "./better_algorithm.rb" # a better way to choose what to attack next

require "./lib/board.rb"
require "./lib/ship.rb"

# This is called just after displaying a board, so that messages appear
# below the board instead of above them.
def message
  puts $message
  $message = ''
end

def setup_game
  computer_board = ComputerBoard.new("computer")
  computer_board.display_board # for testing
  player_board = PlayerBoard.new("player")
  player_board.display_board unless $testing
  player_board.player_view = player_board.generate_blank_board
  $message << "Setup complete! Let's play! "
  message
  return computer_board, player_board
end

def flip_to_see_who_goes_first
  result = rand(2)
  return nil if result == 0
  "player"
end

def player_turn (computer_board, player_board)
  $message << "Your turn! "
  hit = true # to get into the while loop
  # continue as long as player is hitting
  while hit == true
    hit = false # hasn't hit yet
    # show player what he knows of enemy board
    computer_board.show_player_view
    valid_coords = false
    until valid_coords
      x, y = computer_board.get_valid_coords
      # determine_damage returns 'false' if already attacked coords
      hit, valid_coords = computer_board.determine_damage(x, y)
      return if $winner
    end
  end
  # show player view of computer board at end of player turn
  computer_board.show_player_view
  print "Enter to continue..."
  gets
end

def computer_turn (computer_board, player_board)
  $message << "The enemy attacks! "
  hit = true # to get into the while loop
  # continue as long as player is hitting
  while hit == true
    hit = false # hasn't hit yet
    valid_coords = false
    until valid_coords
      x, y = player_board.determine_computer_coords
      # determine_damage returns 'false' if already attacked coords
      hit, valid_coords = player_board.determine_damage(x, y)
      # show player his own board, with new damage done
      player_board.show_player_view_of_player
      return if $winner
      print "Enter to continue..."
      gets
    end
  end
end

def play_game
  computer_board, player_board = setup_game
  player_move = flip_to_see_who_goes_first
  puts "The #{player_move ? "player" : "computer"} won the toss."
  # code to play game goes here
  until $winner # i.e., until a winner is determined
    player_move ? player_turn(computer_board, player_board) :
      computer_turn(computer_board, player_board)
    # toggle until game ends
    player_move ? player_move = false : player_move = true
  end
  return computer_board, player_board
end

def report_and_prompt(computer_board, player_board)
  $winner == "computer" ? player_board.show_player_view_of_player :
    computer_board.show_player_view
  puts "The winner of this round is the #{$winner}!"
end

