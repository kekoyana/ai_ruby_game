# frozen_string_literal: true

class Piece
  attr_accessor :position

  def initialize(type, player, x, y)
    @type = type
    @player = player
    @position = { x: x, y: y }
  end

  def move(to_x, to_y)
    # 駒を新しい位置に移動する
    @position = { x: to_x, y: to_y }
  end

  def moves
    # 駒の移動範囲を定義する
    case @type
    when 'X'
      moves = [[1, 0], [0, 1], [1, 1], [-1, 0], [0, -1], [-1, -1]]
    when 'O'
      moves = [[1, 0], [0, 1], [1, 1], [-1, 0], [0, -1], [-1, 1]]
    end

    # 移動可能範囲を画面内に収める
    moves.select do |move|
      new_x = @position[:x] + move[0]
      new_y = @position[:y] + move[1]
      (0..8).cover?(new_x) && (0..4).cover?(new_y)
    end
  end

  def to_s
    # 駒の表示方法を定義する
    case @type
    when 'X'
      'X'
    when 'O'
      'O'
    end
  end
end
