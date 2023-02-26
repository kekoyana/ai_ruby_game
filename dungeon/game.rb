# frozen_string_literal: true

class Game
  def initialize(maze, player)
    @maze = maze
    @player = player
    @gameover = false
  end

  def run
    until @gameover
      @maze.display(@player.x, @player.y)
      handle_input
      update
    end
    puts 'ゲームオーバー'
  end

  def handle_input
    puts '移動する方向を入力してください。[u(p), d(own), l(eft), r(ight)]'
    input = gets.chomp
    case input
    when 'u', 'up'
      @player.move(0, -1, @maze)
    when 'd', 'down'
      @player.move(0, 1, @maze)
    when 'l', 'left'
      @player.move(-1, 0, @maze)
    when 'r', 'right'
      @player.move(1, 0, @maze)
    end
  end

  def update
    return unless @player.x == @maze.width - 1 && @player.y == @maze.height - 1

    # ゴールに到達した場合はゲームクリア
    @gameover = true
  end
end
