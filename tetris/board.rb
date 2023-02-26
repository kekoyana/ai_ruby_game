# frozen_string_literal: true

class Board
  WIDTH = 10
  HEIGHT = 20

  attr_reader :grid

  def initialize
    @grid = Array.new(HEIGHT) { Array.new(WIDTH, 0) }
  end

  # テトリミノをボードに配置する
  def place_tetromino(tetromino, x, y)
    tetromino.shape.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @grid[y + i][x + j] = tetromino.type if cell == 1
      end
    end
  end

  # テトリミノを移動させる
  def move_tetromino(tetromino, dx, dy)
    # テトリミノを一旦削除する
    remove_tetromino(tetromino)
    # 移動後の位置にテトリミノを配置する
    place_tetromino(tetromino, tetromino.x + dx, tetromino.y + dy)
  end

  # テトリミノを回転させる
  def rotate_tetromino(tetromino)
    # 回転前の形状を保存する
    old_shape = tetromino.shape.dup
    # テトリミノを回転させる
    tetromino.rotate
    # 回転後の形状がボードの外に出る場合は回転を取り消す
    if tetromino.x.negative? || tetromino.x + tetromino.width > WIDTH || tetromino.y + tetromino.height > HEIGHT || collision?(tetromino)
      tetromino.shape = old_shape
    end
  end

  # テトリミノを削除する
  def remove_tetromino(tetromino)
    tetromino.shape.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        @grid[tetromino.y + i][tetromino.x + j] = 0 if cell == 1
      end
    end
  end

  # テトリミノがボードの底に接触しているかどうかを判定する
  def bottom_collision?(tetromino)
    tetromino.shape.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        if cell == 1
          if tetromino.y + i == HEIGHT - 1
            return true
          elsif @grid[tetromino.y + i + 1][tetromino.x + j] != 0
            return true
          end
        end
      end
    end
    false
  end

  # テトリミノがボードの他のブロックに接触しているかどうかを判定する
  def collision?(tetromino)
    tetromino.shape.each_with_index do |row, i|
      row.each_with_index do |cell, j|
        next unless cell == 1
        if (tetromino.x + j).negative? || tetromino.x + j >= WIDTH || tetromino.y + i >= HEIGHT || @grid[tetromino.y + i][tetromino.x + j] != 0
          return true
        end
      end
    end
    false
  end

  # ラインがそろったかどうかを判定する
  def check_lines
    lines_cleared = 0
    @grid.each_with_index do |row, i|
      next unless row.all? { |cell| cell != 0 }

      @grid.delete_at(i)
      @grid.unshift(Array.new(WIDTH, 0))
      lines_cleared += 1
    end
    lines_cleared
  end

  def to_s
    rows = @grid.map do |row|
      row.map do |cell|
        case cell
        when 0
          ' '
        when 1
          'X'
        when 2
          'O'
        else
          '*'
        end
      end.join
    end

    rows.join("\n")
  end
end
