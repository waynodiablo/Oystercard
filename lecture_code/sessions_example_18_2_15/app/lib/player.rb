class Player
  attr_reader :name

  def initialize(name)
    @name = name
  end
end

class Game
  def initialize
    @players = []
  end

  def add_player(player)
    @players << player
  end

  def find_player_by_object_id(object_id)
    @players.select { |player| player.object_id == object_id }.first
  end
end


# pl1 = Player.new('roi')
# pl2 = Player.new('mihai')

# session_me = pl2.object_id

# game = Game.new

# game.add_player pl1
# game.add_player pl2

# p game.find_player_by_object_id session_me
