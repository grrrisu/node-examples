class Player
  include Celluloid
  include Celluloid::Logger
  finalizer :shutdown

  attr_reader :id

  def initialize id
    info "player init with #{id}"
    @id = id
  end

  def shutdown
    info "player #{player.id} shutdown"
  end

  def receive message
    info "player[#{id}] received message #{message}"
  end

end
