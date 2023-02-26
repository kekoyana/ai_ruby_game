# frozen_string_literal: true

require_relative 'maze_ext'
require_relative 'maze'
require_relative 'player'
require_relative 'game'

maze = Maze.new(12, 12)

player = Player.new(1, 1)

game = Game.new(maze, player)
game.run
