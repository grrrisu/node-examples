class PongServer
  include Celluloid::IO
  finalizer :shutdown

  def initialize(file)
    @file = file
    puts "server on #{file}"
    @server = UNIXServer.new(file)
    # at_exit do
    #   terminate
    # end
  end

  def boot
    puts "server listening ..."
    async.run
  end

  def shutdown
    @server.close if @server
    FileUtils.rm @file, force: true
  end

  def run
    loop do
      print '.'
      async.handle_connection @server.accept
    end
  end

  def handle_connection(socket)
    _, port, host = socket.peeraddr
    puts "*** Received connection from #{host}:#{port}"
    listen(socket)
  rescue EOFError
    puts "*** #{host}:#{port} disconnected"
    socket.close
  end

  def listen(socket)
    loop do
      socket.write socket.readpartial(4096)
    end
  end

end
