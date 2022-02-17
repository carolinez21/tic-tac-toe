# module that has a function which checks wins - make this module accessible to both
module Win
  def wins?
    possible_win_cases = [[1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7]]
    winning_cases = possible_win_cases.select { |c| c.difference(self.allpositions).empty? }
    winning_cases.any?
  end
end

class PlayerX
  extend Win
  @@allpositions = []
  @@letter = 'X'

  def self.allpositions
    @@allpositions
  end

  def self.letter
    @@letter
  end

  attr_reader :letter

  def initialize(position)
    @position = position
    @@allpositions.push(position)
  end

  # keep track of all X positions
end

class PlayerO
  extend Win
  @@allpositions = []
  @@letter = 'O'

  def self.allpositions
    @@allpositions
  end

  def self.letter
    @@letter
  end

  attr_reader :letter

  def initialize(position)
    @position = position
    @@allpositions.push(position)
  end

  # keep track of all O positions
end

# gameplay
# draw game board
# loop until there's a winner
# puts PlayerX enter position
# check if that position is taken
# prints game board with x
# check if there's a winner
# puts Player O enter position
# check if that position is taken
# prints game board with O
# check if there's a winner

def print_board(array)
  puts '     |     |     '
  puts "  #{array[0]}  |  #{array[1]}  |  #{array[2]}  "
  puts '_____|_____|_____'
  puts '     |     |     '
  puts "  #{array[3]}  |  #{array[4]}  |  #{array[5]}  "
  puts '_____|_____|_____'
  puts '     |     |     '
  puts "  #{array[6]}  |  #{array[7]}  |  #{array[8]}  "
  puts '     |     |     '
end

positions = (1..9).to_a
print_board(positions)

current_player = PlayerO
other_player = PlayerX

# check if game is over
#if (positions.any? { |p| (1..9).include?(p) }).empty?
 # puts 'Gosh darn, nobody won. How lame.'
#end
def game_over?(positions)
  positions.none? { |p| (1..9).include?(p) }
end

# loop
until current_player.wins? || game_over?(positions)
  temp = current_player
  current_player = other_player
  other_player = temp
  puts "#{current_player}, choose where you'd like to go."
  position = gets.chomp.to_i
  # if that position is not valid
  # if that position == X or O then print error message
  # else, set to X
  # while current_player.allpositions.include?(position) || other_player.allpositions.include?(position)
  unless positions.include?(position)
    puts 'Sorry, that is not a valid. Please choose another spot.'
    position = gets.chomp.to_i
  end
  current_player.new(position)
  positions[position - 1] = current_player.letter
  print_board(positions)
end
if game_over?(positions)
  puts 'Gosh darn, nobody won. How lame.'
else
  puts "Yay!! #{current_player} wins. Sucks to be you #{other_player}."
end
