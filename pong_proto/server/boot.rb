require 'fileutils'
require 'celluloid/io'
require 'byebug'

require_relative 'pong_server'
require_relative 'master'

Master.run # in the forground
# PongServer.new('pong.sock').boot
# sleep
