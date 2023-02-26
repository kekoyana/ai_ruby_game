# frozen_string_literal: true

class Board
  def initialize(width = 9, height = 9)
    @width = width
    @height = height
    @board = Array.new(@width) { Array.new(@height, nil) }
  end

  def display
    puts '  0 1 2 3 4 5 6 7 8'
    @board.each_with_index do |row, i|
      print "#{i} "
      row.each do |piece|
        print piece.nil? ? '. ' : "#{piece} "
      end
      puts ''
    end
  end

  def move(from_x, from_y, to_x, to_y, piece)
    # 駒を取り除く
    @board[from_y][from_x] = nil

    # 駒を移動する
    @board[to_y][to_x] = piece
  end
end
