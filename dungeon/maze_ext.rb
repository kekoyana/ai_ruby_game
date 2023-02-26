# frozen_string_literal: true

module MazeExt
  attr_accessor :height, :width

  def data(y, x)
    @data[y][x]
  end

  def modify(x, y)
    @data[y][x] = 0
  end

  def display(player_x, player_y)
    # 迷路の表示
    maze_str = ''
    (0..(@height - 1)).each do |y|
      (0..(@width - 1)).each do |x|
        maze_str += if x == player_x && y == player_y
                      'P' # プレイヤーの位置を表示
                    elsif @data[y][x] == 1
                      '#'  # 壁を表示
                    else
                      ' '  # 通路を表示
                    end
      end
      maze_str += "\n"
    end
    puts maze_str
  end
end
