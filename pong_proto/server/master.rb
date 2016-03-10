class Master < Celluloid::SupervisionGroup
  supervise PongServer, as: :pong_server, args: ['pong.sock', {start: true}]
end
