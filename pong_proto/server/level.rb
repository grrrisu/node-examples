class Level
  include Celluloid
  include Celluloid::Logger
  finalizer :shutdown

  attr_reader :players

  def initialize
    info "level init"
    @players = {}
  end

  def add_player player
    @players[player.id] = player
  end

  def remove_player player
    @players.delete player.id
  end

  def find_or_create_player player_id
    raise ArgumentError, "player_id is required" unless player_id
    unless player = @players[player_id]
      player = Player.new(player_id)
      add_player player
    end
    player
  end

  def shutdown
    @players = {}
    info "level shutdown"
  end

end
