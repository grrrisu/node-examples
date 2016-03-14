class PlayerConnection
  include Celluloid
  include Celluloid::Logger
  finalizer :shutdown

  attr_reader :socket

  def initialize(socket)
    info "starting with socket #{socket.object_id}"
    @socket = socket
  end

  def listen
    begin
      data = socket.read
      receive data unless data.empty?
    end until data.empty? && socket.eof?
    info "client disconnected"
    terminate
  end

  def receive(data)
    message = JSON.parse(data, symbolize_names: true)
    info "received message #{message}"
    player = get_player message[:player_id]
    # intended behaviour: if the player crashes this connection crashes too
    raise 'Oh my dear!'
    player.receive(message)
  rescue StandardError => e
    message = {exception: e.class.name, message: e.message, data: data}
    socket.print message.to_json
    raise
  end

  def level
    Celluloid::Actor[:level]
  end

  def send(message)
    socket.print message.to_json
  end

  def shutdown
    socket.close if socket
    info "socket closed"
  end

  private

  def get_player player_id
    raise ArgumentError, "player_id is required" unless player_id
    return @player if @player
    @player = Player.new_link(player_id)
    @player.connection = self
    level.add_player @player
    @player
  end

end
