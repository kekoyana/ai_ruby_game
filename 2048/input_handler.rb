# frozen_string_literal: true

class InputHandler
  def get_input
    case $stdin.getc
    when 'a'
      :left
    when 'd'
      :right
    when 'w'
      :up
    when 's'
      :down
    else
      :invalid
    end
  end
end
