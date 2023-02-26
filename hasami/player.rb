# frozen_string_literal: true

class Player
  attr_accessor :pieces

  def initialize(name, pieces)
    @name = name
    @pieces = pieces
  end

  def move(board, from_x, from_y, to_x, to_y)
    # 指定された駒を取得する
    piece = @pieces.find { |p| p.position[:x] == from_x && p.position[:y] == from_y }

    # 駒を移動する
    piece.move(to_x, to_y)

    # 盤面を更新する
    board.move(from_x, from_y, to_x, to_y, piece)
  end

  def choose_move
    # 次の手を決定する
    # この実装例ではランダムに手を選択する
    pieces = @pieces.reject { |p| p.position.nil? }
    piece = pieces.sample
    moves = piece.moves
    move = moves.sample
    from_x = piece.position[:x]
    from_y = piece.position[:y]
    to_x = from_x + move[0]
    to_y = from_y + move[1]
    [from_x, from_y, to_x, to_y]
  end
end
