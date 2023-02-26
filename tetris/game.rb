# frozen_string_literal: true

require_relative 'board'
require_relative 'tetromino'
require 'io/console'
require 'timeout'

class Game
  def initialize
    @board = Board.new
    @tetromino = nil
    @score = 0
    @game_over = false
    @last_move_time = Time.now
  end

  def start
    loop do
      # 新しいテトリミノを生成する
      @tetromino = Tetromino.new(Tetromino::BLOCKS.keys.sample)
      @tetromino.x = Board::WIDTH / 2 - @tetromino.width / 2
      @tetromino.y = 0

      loop do
        # テトリミノをボードに配置する
        @board.place_tetromino(@tetromino, @tetromino.x, @tetromino.y)

        # 現在のスコアとボードの状態を表示する
        puts "Score: #{@score} #{Time.now}"
        puts @board

        # ユーザーからの入力を受け取る
        input = read_key

        # 入力に応じてテトリミノを移動・回転させる
        case input
        when 'a'
          @board.move_tetromino(@tetromino, -1, 0)
        when 'd'
          @board.move_tetromino(@tetromino, 1, 0)
        when 's'
          @board.move_tetromino(@tetromino, 0, 1)
        when 'w'
          @board.rotate_tetromino(@tetromino)
        when 'q'
          exit
        end

        # 一定時間ごとにテトリミノを1つ下に移動する
        next unless Time.now - @last_move_time > 0.5

        @last_move_time = Time.now
        break if @board.bottom_collision?(@tetromino) || @board.collision?(@tetromino)

        @board.move_tetromino(@tetromino, 0, 1)
      end

      # テトリミノが落ちた位置に固定する
      @board.place_tetromino(@tetromino, @tetromino.x, @tetromino.y - 1)

      # ラインがそろった場合にはスコアを加算する
      lines_cleared = @board.check_lines
      @score += lines_cleared * 100 if lines_cleared.positive?

      # ゲームオーバーかどうかを判定する
      if @board.collision?(@tetromino)
        @game_over = true
        break
      end
    end

    # ゲームオーバー画面を表示する
    puts "Game Over! Score: #{@score}"
  end

  private

  # 1文字だけ入力を受け取る
  def read_char
    begin
      system('stty raw -echo')
      input = $stdin.getc
    ensure
      system('stty -raw echo')
    end
    input.chr
  end

  def read_key
    system('stty raw -echo') # ユーザーが入力したキーを表示しないように設定
    input = nil
    Timeout.timeout(0.1) do # 0.1秒以内に入力がなければnilを返す
      input = $stdin.getc
    end
    input&.chr
  rescue Timeout::Error # タイムアウトエラーが発生した場合には、nilを返す
    nil
  ensure
    system('stty -raw echo') # 設定を元に戻す
  end
end
