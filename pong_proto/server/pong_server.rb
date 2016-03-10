class PongServer
  include Celluloid::IO
  finalizer :shutdown

  def initialize(file, start: false)
    @file = file
    puts "server on #{file}"
    @server = UNIXServer.new(file)
    boot if start
  end

  def boot
    puts "server listening ..."
    async.run
  end

  def shutdown
    puts "shutting down ..."
    @server.close if @server
    FileUtils.rm @file, force: true
  end

  def run
    begin
      print '.'
      async.handle_connection @server.accept
    end until @server.closed?
  end

  def handle_connection(socket)
    puts "*** client connection"
    listen(socket)
  rescue EOFError
    puts "*** client disconnected"
    socket.close
  end

  def listen(socket)
    begin
      socket.write socket.readpartial(4096)
    end until @server.closed?
  end

end
