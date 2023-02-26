# frozen_string_literal: true

class Tetromino
  # テトリミノの種類と形状を定義
  BLOCKS = {
    I: [[1, 1, 1, 1]],
    O: [[1, 1],
        [1, 1]],
    T: [[0, 1, 0],
        [1, 1, 1]],
    S: [[0, 1, 1],
        [1, 1, 0]],
    Z: [[1, 1, 0],
        [0, 1, 1]],
    J: [[1, 0, 0],
        [1, 1, 1]],
    L: [[0, 0, 1],
        [1, 1, 1]]
  }.freeze

  attr_accessor :shape, :type, :x, :y

  def initialize(type)
    @type = type
    @shape = BLOCKS[type].dup
    @x = 0
    @y = 0
  end

  # テトリミノを回転させる
  def rotate
    @shape = @shape.transpose.map(&:reverse)
  end

  # テトリミノの横幅を取得する
  def width
    @shape[0].size
  end

  # テトリミノの縦幅を取得する
  def height
    @shape.size
  end
end
