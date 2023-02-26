# frozen_string_literal: true

class Player
  attr_reader :x, :y

  def initialize(x, y)
    @x = x
    @y = y
  end

  def move(dx, dy, maze)
    new_x = @x + dx
    new_y = @y + dy
    if can_move_to?(new_x, new_y, maze)
      @x = new_x
      @y = new_y
      return true
    end
    false
  end

  def can_move_to?(x, y, maze)
    if x.negative? || x >= maze.width || y.negative? || y >= maze.height
      # 迷路の範囲外に移動しようとした場合は移動不可
      return false
    end
    if maze.data(y, x) == 1
      # 壁の位置に移動しようとした場合は移動不可
      return false
    end

    true
  end
end
