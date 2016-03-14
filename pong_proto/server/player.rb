# the player actor is linked with its connection
# if one of the two crashes the other crashes as well
class Player
  include Celluloid
  include Celluloid::Logger
  finalizer :shutdown

  attr_reader :id
  attr_accessor :connection

  def initialize id
    info "player init with #{id}"
    @id = id
  end

  def shutdown
    level = Celluloid::Actor[:level]
    level.async.remove_player @id
    debug "player[#{@id}] shutdown"
  end

  def receive message
    info "player[#{id}] received message #{message}"
    #raise "Oh Snap!!!"
    connection.send(message)
  end

end
