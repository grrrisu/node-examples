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
    info JSON.parse(data, symbolize_names: true)
    socket.print data
  end

  def shutdown
    socket.close if socket
  end

end
