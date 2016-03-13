class PlayerConnection
  include Celluloid
  include Celluloid::Logger
  finalizer :shutdown

  attr_reader :socket

  def initialize(socket, start: false)
    @socket = socket
    listen if start
  end

  def listen
    begin
      data = socket.read
      process data unless data.empty?
    end until data.empty? && socket.eof?
    info "client disconnected"
    shutdown
  end

  def process(data)
    info "received data"
    info data
    info data.class.name
    data = JSON.parse(data, symbolize_names: true)
    info data
    # raise "OH SHIT!!!"
    socket.print data
  rescue StandardError => e
    message = {exception: e.class.name, message: e.message, data: data}
    socket.print message.to_json
    raise
  end

  def shutdown
    socket.close if socket
  end

end
