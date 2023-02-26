# frozen_string_literal: true

class Tile
  attr_accessor :value, :position

  def initialize(value, position)
    @value = value
    @position = position
  end
end
