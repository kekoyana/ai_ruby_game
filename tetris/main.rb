# frozen_string_literal: true

require_relative 'game'

class Main
  def self.run
    game = Game.new
    game.start
  end
end

Main.run
