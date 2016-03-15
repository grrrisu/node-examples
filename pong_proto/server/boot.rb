require 'json'
require 'fileutils'
require 'celluloid/io'
require 'byebug'


require_relative 'queue/event/action'
require_relative 'queue/event/test'
require_relative 'queue/fire_worker'
require_relative 'queue/event_queue'
require_relative 'net/message_handler/base'
require_relative 'net/message_handler/test'
require_relative 'net/player_connection'
require_relative 'net/player_server'
require_relative 'net/broadcaster'
require_relative 'player'
require_relative 'level'
require_relative 'master'

SIM_ENV = 'development'

Master.run # in the forground
