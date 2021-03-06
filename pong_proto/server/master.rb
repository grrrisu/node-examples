class Master < Celluloid::SupervisionGroup
  supervise Level, as: :level
  supervise Queue::EventQueue, as: :event_queue
  supervise Net::Broadcaster, as: :broadcaster
  supervise Net::PlayerServer, as: :player_server, args: ['player.sock', {start: true}]
end
