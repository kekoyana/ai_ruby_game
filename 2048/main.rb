# frozen_string_literal: true

require_relative 'tile'
require_relative 'board'
require_relative 'renderer'
require_relative 'input_handler'
require_relative 'game'

game = Game.new
game.play
