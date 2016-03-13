require 'json'
require 'fileutils'
require 'celluloid/io'
require 'byebug'

require_relative 'player_server'
require_relative 'master'

SIM_ENV = 'development'

Master.run # in the forground
