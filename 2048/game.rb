# frozen_string_literal: true

class Game
  def initialize
    @board = Board.new
    @renderer = Renderer.new
    @input_handler = InputHandler.new
  end

  def play
    @renderer.render(@board)
    until @board.game_over?
      input = @input_handler.get_input
      case input
      when :left
        @board.move_left
      when :right
        @board.move_right
      when :up
        @board.move_up
      when :down
        @board.move_down
      end
      @board.add_random_tile
      @renderer.render(@board)
    end
    puts 'Game Over!'
  end
end
