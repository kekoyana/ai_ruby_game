# frozen_string_literal: true

require_relative 'board'
require_relative 'piece'
require_relative 'player'
require_relative 'game'

# ボードを作成する
board = Board.new(9, 9)

# 先手プレイヤーを作成する
player1 = Player.new('Player1', [])
player1_pieces = [
  Piece.new('X', player1, 0, 0),
  Piece.new('X', player1, 2, 0),
  Piece.new('X', player1, 4, 0)
]
player1.instance_variable_set(:@pieces, player1_pieces)

# 後手プレイヤーを作成する
player2 = Player.new('Player2', [])
player2_pieces = [
  Piece.new('O', player2, 0, 4),
  Piece.new('O', player2, 2, 4),
  Piece.new('O', player2, 4, 4)
]
player2.instance_variable_set(:@pieces, player2_pieces)

# ゲームを作成する
game = Game.new([player1, player2], board)

# ゲームを実行する
game.play
