# frozen_string_literal: true

class Dictionary
  attr_reader :words

  def initialize(file_path)
    @words = File.readlines(file_path).map(&:chomp)
  end

  def add(word)
    @words << word
  end

  def remove(word)
    @words.delete(word)
  end
end
