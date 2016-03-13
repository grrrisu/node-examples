require 'json'
require 'fileutils'
require 'celluloid/io'
require 'byebug'

require_relative 'player_server'
require_relative 'master'

Master.run # in the forground
