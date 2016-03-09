require 'fileutils'
require 'celluloid/io'
require 'byebug'

require_relative 'pong_server'

PongServer.new('pong.sock').boot
sleep
