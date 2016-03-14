class Master < Celluloid::SupervisionGroup
  supervise Level, as: :level
  supervise EventQueue, as: :event_queue
  supervise Broadcaster, as: :broadcaster
  supervise PlayerServer, as: :player_server, args: ['player.sock', {start: true}]
end
