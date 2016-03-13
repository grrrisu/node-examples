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
    PlayerConnection.supervise(socket, start: true)
  end

end
