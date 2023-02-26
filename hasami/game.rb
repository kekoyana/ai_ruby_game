# frozen_string_literal: true

class Game
  def initialize(players, board)
    @players = players
    @board = board
    @current_player = players.first
    @winner = nil
  end

  def play
    while @winner.nil?
      # 盤面を表示する
      @board.display

      # 手を選択する
      from_x, from_y, to_x, to_y = @current_player.choose_move

      # 駒を移動する
      @current_player.move(@board, from_x, from_y, to_x, to_y)

      # 勝敗を判定する
      @winner = determine_winner
      break if @winner

      # プレイヤーを交代する
      @current_player = (@players - [@current_player]).first
    end

    # 結果を表示する
    if @winner == :draw
      puts '引き分けです'
    else
      puts "#{@winner}の勝ちです"
    end
  end

  private

  def determine_winner
    # 各プレイヤーが持つ駒の数を数える
    pieces_count = @players.map { |p| p.pieces.count { |piece| !piece.position.nil? } }

    # 両プレイヤーが1つずつしか駒を持っていない場合は引き分けとする
    if pieces_count.all? { |count| count <= 1 }
      :draw
    elsif pieces_count.any?(&:zero?)
      # 片方のプレイヤーが全ての駒を失っている場合、もう一方のプレイヤーの勝利とする
      winner_player = @players.find { |p| p.pieces.count { |piece| !piece.position.nil? }.positive? }
      winner_player.name
    end
  end
end
