class Master < Celluloid::SupervisionGroup
  supervise PlayerServer, as: :player_server, args: ['player.sock', {start: true}]
end
