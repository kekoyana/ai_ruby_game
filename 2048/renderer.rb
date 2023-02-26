# frozen_string_literal: true

class Renderer
  def render(board)
    system('clear')
    puts '2048'.center(30)
    puts ''
    4.times do |y|
      row = (0..3).map { |x| board.tiles.find { |t| t.position == y * 4 + x } }
      puts row.map { |t| t ? t.value.to_s.center(6) : ''.center(6) }.join('|')
      puts '-' * 29
    end
    puts ''
  end
end
