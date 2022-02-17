WIN_CASES = [[1, 4, 7], [2, 5, 8], [3, 6, 9], [1, 2, 3], [4, 5, 6], [7, 8, 9], [1, 5, 9], [3, 5, 7]]

class Game
  attr_reader :positions, :current_player_index

  def initialize
    @positions = (1..9).to_a
    @current_player_index = 0
    @players = [Player.new(self, 'X'), Player.new(self, 'O')]
  end

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

  def wins?(player)
    (WIN_CASES.select { |c| c.difference(player.allpositions).empty? }).any?
  end

  def game_over?(positions)
    positions.none? { |p| (1..9).include?(p) }
  end

  def player_goes(player)
    position = player.select_position
    player.allpositions.push(position)
    @positions[position - 1] = player.letter
    print_board(@positions)
  end

  def current_player
    @players[@current_player_index]
  end

  def other_player
    @players[@current_player_index - 1]
  end

  def switch_players
    @current_player_index = 1 - @current_player_index
  end

  def play
    print_board(@positions)
    loop do
      player_goes(current_player)
      if game_over?(positions)
        puts 'Gosh darn, nobody won. How lame.'
        return
      elsif wins?(current_player)
        puts "Yay!! #{current_player.letter} wins. Sucks to be you #{other_player.letter} :("
        return
      end
      switch_players
    end
  end
end

class Player
  attr_reader :letter, :game
  attr_accessor :allpositions

  def initialize(game, letter)
    @letter = letter
    @game = game
    @allpositions = []
  end

  def select_position
    puts "Player #{@letter}, choose where you'd like to go:"
    position = gets.chomp.to_i
    until @game.positions.include?(position)
      puts 'Sorry, that position is not valid. Please choose another spot:'
      position = gets.chomp.to_i
      puts position
    end
    position
  end
end

Game.new.play
