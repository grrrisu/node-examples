class Master < Celluloid::SupervisionGroup
  supervise Level, as: :level
  supervise PlayerServer, as: :player_server, args: ['player.sock', {start: true}]
end
