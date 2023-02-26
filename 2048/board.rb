# frozen_string_literal: true

class Board
  attr_accessor :tiles

  def initialize
    @tiles = []
    add_random_tile
    add_random_tile
  end

  def add_random_tile
    empty_cells = (0..15).to_a - @tiles.map(&:position)
    position = empty_cells.sample
    value = [2, 4].sample
    @tiles << Tile.new(value, position)
  end

  def move_left
    @tiles.each do |tile|
      tile.position -= 1 while tile.position % 4 != 0 && @tiles.none? { |t| t.position == tile.position - 1 }
      merge_left(tile)
    end
  end

  def move_right
    @tiles.each do |tile|
      tile.position += 1 while tile.position % 4 != 3 && @tiles.none? { |t| t.position == tile.position + 1 }
      merge_right(tile)
    end
  end

  def move_up
    @tiles.each do |tile|
      tile.position -= 4 while tile.position / 4 != 0 && @tiles.none? { |t| t.position == tile.position - 4 }
      merge_up(tile)
    end
  end

  def move_down
    @tiles.each do |tile|
      tile.position += 4 while tile.position / 4 != 3 && @tiles.none? { |t| t.position == tile.position + 4 }
      merge_down(tile)
    end
  end

  def merge_left(tile)
    neighbor = @tiles.find { |t| t.position == tile.position - 1 }
    return unless neighbor && neighbor.value == tile.value

    neighbor.value *= 2
    @tiles.delete(tile)
  end

  def merge_right(tile)
    neighbor = @tiles.find { |t| t.position == tile.position + 1 }
    return unless neighbor && neighbor.value == tile.value

    neighbor.value *= 2
    @tiles.delete(tile)
  end

  def merge_up(tile)
    neighbor = @tiles.find { |t| t.position == tile.position - 4 }
    return unless neighbor && neighbor.value == tile.value

    neighbor.value *= 2
    @tiles.delete(tile)
  end

  def merge_down(tile)
    neighbor = @tiles.find { |t| t.position == tile.position + 4 }
    return unless neighbor && neighbor.value == tile.value

    neighbor.value *= 2
    @tiles.delete(tile)
  end

  def game_over?
    @tiles.size == 16 &&
      @tiles.none? { |t| [3, 7, 11].include?(t.position % 4) && @tiles.none? { |n| n.position == t.position - 1 } } &&
      @tiles.none? { |t| [0, 4, 8].include?(t.position % 4) && @tiles.none? { |n| n.position == t.position + 1 } } &&
      @tiles.none? { |t| [0, 1, 2].include?(t.position / 4) && @tiles.none? { |n| n.position == t.position + 4 } } &&
      @tiles.none? { |t| [12, 13, 14].include?(t.position / 4) && @tiles.none? { |n| n.position == t.position - 4 } }
  end
end
