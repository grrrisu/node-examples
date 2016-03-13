class PlayerServer
  include Celluloid::IO
  include Celluloid::Logger
  finalizer :shutdown

  def initialize(file, start: false)
    @file = file
    @server = UNIXServer.new(file)
    boot if start
  rescue Errno::EADDRINUSE
    error "\e[0;31maddress in use\e[0m"
    raise
  end

  def boot
    info "server listening ..."
    async.run
  end

  def shutdown
    info "shutting down ..."
    @server.close if @server
    FileUtils.rm @file, force: true
  end

  def run
    begin
      async.handle_connection @server.accept
    end until @server.closed?
  end

  def handle_connection(socket)
    info "client connected"
    listen(socket)
  rescue EOFError
    info "client disconnected"
    socket.close
  rescue StandardError => e
    #puts "\e[0;31mconnection for player #{connection.player.try(:id)} crashed!: \n #{e.message}"
    #puts e.backtrace.join("\n") unless SIM_ENV == 'test'
    #puts "\e[0m"
    raise
  end

  def listen(socket)
    begin
      data = socket.read
      info "received data"
      info data
      info data.class.name
      info JSON.parse(data, symbolize_names: true)
      socket.print data
    end until data.empty? && socket.eof?
  ensure
    info "socket closed"
    socket.close
  end

end
