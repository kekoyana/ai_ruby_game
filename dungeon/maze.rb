# frozen_string_literal: true

class Maze
  include MazeExt
  WALL = 1
  PATH = 0

  def initialize(width, height)
    @width = width
    @height = height
    @data = Array.new(height) { Array.new(width, WALL) }
    generate
  end

  def generate
    set_start_position
    visited = Array.new(@height) { Array.new(@width, false) }
    dfs(visited, @start_x, @start_y)
  end

  def to_s
    @data.map { |row| row.map { |cell| cell == WALL ? '#' : ' ' }.join }.join("\n")
  end

  private

  def set_start_position
    @start_x = rand(@width)
    @start_y = rand(@height)
    @data[@start_y][@start_x] = PATH
  end

  def dfs(visited, x, y)
    visited[y][x] = true
    neighbors = [[x, y - 2], [x, y + 2], [x - 2, y], [x + 2, y]].shuffle
    neighbors.each do |nx, ny|
      next unless ny.between?(0, @height - 1) && nx.between?(0, @width - 1) && !visited[ny][nx]

      @data[ny][nx] = PATH
      @data[(y + ny) / 2][(x + nx) / 2] = PATH
      dfs(visited, nx, ny)
    end
  end
end
