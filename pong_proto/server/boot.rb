require 'json'
require 'fileutils'
require 'celluloid/io'
require 'byebug'


require_relative 'event/action'
require_relative 'event/test'
require_relative 'fire_worker'
require_relative 'event_queue'
require_relative 'message_handler/base'
require_relative 'message_handler/test'
require_relative 'player_connection'
require_relative 'player_server'
require_relative 'player'
require_relative 'broadcaster'
require_relative 'level'
require_relative 'master'

SIM_ENV = 'development'

Master.run # in the forground
