INITIAL_MARKER = " "
PLAYER_MARKER = "X"
COMPUTER_MARKER = "O"
REQUIRED_WINS = 5

require "pry"

def prompt(str)
  puts "#> #{str}"
end

def joinor(arr, separator = ", ", final_str = "or")
  case arr.size
  when 0 then ''
  when 1 then arr.first
  when 2 then arr.join(" #{final_str} ")
  else
    arr[-1] = "#{final_str} #{arr.last}"
    arr.join(separator)
  end
end

def display_board(brd_hsh)
  system 'clear'
  puts ""
  puts "     |     |     "
  puts "  #{brd_hsh[1]}  |  #{brd_hsh[2]}  |  #{brd_hsh[3]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd_hsh[4]}  |  #{brd_hsh[5]}  |  #{brd_hsh[6]}  "
  puts "     |     |     "
  puts "-----+-----+-----"
  puts "     |     |     "
  puts "  #{brd_hsh[7]}  |  #{brd_hsh[8]}  |  #{brd_hsh[9]}  "
  puts "     |     |     "
end

def make_new_board
  new_board = {}
  (1..9).each { |num| new_board[num] = INITIAL_MARKER }
  new_board
end

def player_turn!(brd_hsh)
  square = ""
  loop do
    prompt "Choose a square (#{joinor(empty_squares(brd_hsh))}):"
    square = gets.chomp.to_i
    break if brd_hsh[square] == INITIAL_MARKER
    puts "Sorry that is not a valid choice."
  end
  brd_hsh[square] = PLAYER_MARKER
end

def empty_squares(brd_hsh)
  brd_hsh.keys.select { |num| brd_hsh[num] == INITIAL_MARKER }
end

def computer_turn!(brd_hsh)
  empties = brd_hsh.keys.select { |num| brd_hsh[num] == INITIAL_MARKER }
  square = empties.sample
  brd_hsh[square] = COMPUTER_MARKER
end

def board_full?(brd_hsh)
  brd_hsh.keys.select { |num| brd_hsh[num] == INITIAL_MARKER }.empty?
end

def winner(brd_hsh)
  winning_lines = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] +
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] +
                  [[1, 5, 9], [3, 5, 7]]
  # binding.pry
  winning_lines.each do |line|
    if line.all? { |num| brd_hsh[num] == PLAYER_MARKER }
      return "You"
    elsif line.all? { |num| brd_hsh[num] == COMPUTER_MARKER }
      return "The Computer"
    end
  end
  nil
end

def someone_won?(brd_hsh)
  !!winner(brd_hsh)
end

loop do
  loop do
    board = make_new_board
    player_wins = 0
    computer_wins = 0
    display_board(board)
    loop do
      display_board(board)
      player_turn!(board)
      break if someone_won?(board) || board_full?(board)
      computer_turn!(board)
      break if someone_won?(board) || board_full?(board)
    end
    display_board(board)
    if someone_won?(board)
      puts "#{winner(board)} won!"
      case winner(board)
      when "You" then player_wins += 1
      when "The Computer" then computer_wins += 1
    else
      puts "It's a tie!"
    end
    puts "Your wins: #{player_wins}  | Computer wins: #{computer_wins}"
    break if ( player_wins >= REQUIRED_WINS || computer_wins >= REQUIRED_WINS)
  end
  puts "Play again? (Y/N)"
  break if gets.chomp.downcase.start_with?("n")
end

puts "Thanks for playing!"
