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
    player = level.find_or_create_player message[:player_id]
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

end
