VALID_CHOICES = %w(rock paper scissors lizard spock)
WINS = { 'rock' => ['scissors', 'lizard'],
         'paper' => ['rock', 'spock'],
         'scissors' => ['paper', 'lizard'],
         'lizard' => ['spock', 'paper'],
         'spock' => ['scissors', 'rock'] }

def prompt(message)
  Kernel.puts("#> #{message}")
end

def win?(player1, player2)
  if WINS[player1].include?(player2)
    true
  end
end

def results(player, computer)
  if win?(player, computer)
    "player"
  elsif win?(computer, player)
    "computer"
  else
    "tie"
  end
end

def display_winner(win)
  case win
  when 'player' then prompt("You won!")
  when 'computer' then prompt("Computer won!")
  when 'tie' then prompt("It's a tie!")
  end
end

def grand_winner?(score)
  if score >= 3
    true
  end
end

loop do
  prompt("Welcome to Rock, Paper, Scissors, Lizard, Spock!")
  prompt("Win best 2 of 3 to be crowned Grand Winner!")
  player_wins = 0
  computer_wins = 0
  loop do
    choice = ''
    loop do
      prompt("Choose one: #{VALID_CHOICES.join(', ')}")
      choice = Kernel.gets().chomp().downcase()
      break if VALID_CHOICES.include?(choice)
    end
    computer_choice = VALID_CHOICES.sample()
    prompt("You chose: #{choice}. The computer chose: #{computer_choice}")

    winner = results(choice, computer_choice)
    display_winner(winner)

    case winner
    when 'player' then player_wins += 1
    when 'computer' then computer_wins += 1
    end

    prompt("Your score: #{player_wins} Computer score: #{computer_wins}")
    if grand_winner?(player_wins)
      prompt("You are the grand winner!")
      break
    elsif grand_winner?(computer_wins)
      prompt("The computer is the grand winner!")
      break
    end
  end

  prompt("Play again? (y/n)")
  replay = Kernel.gets().chomp()
  break unless replay.downcase().start_with?('y')
end

prompt("Thanks for playing!")
