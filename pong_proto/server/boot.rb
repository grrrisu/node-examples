require 'json'
require 'fileutils'
require 'celluloid/io'
require 'byebug'

require_relative 'message_handler/base.rb'
require_relative 'message_handler/test.rb'
require_relative 'player_connection'
require_relative 'player_server'
require_relative 'player'
require_relative 'level'
require_relative 'master'

SIM_ENV = 'development'

Master.run # in the forground
