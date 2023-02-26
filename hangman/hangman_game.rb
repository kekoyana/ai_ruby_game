# frozen_string_literal: true

class HangmanGame
  attr_accessor :word

  def initialize(word, max_guesses = 6)
    @word = word
    @max_guesses = max_guesses
    @guesses = []
    @incorrect_guesses = 0
  end

  def game_over?
    @incorrect_guesses >= @max_guesses || won?
  end

  def won?
    !hidden_word.include?('_')
  end

  def guess(letter)
    return false unless valid_guess?(letter)

    if @word.include?(letter)
      update_hidden_word(letter)
    else
      @incorrect_guesses += 1
    end

    @guesses << letter
  end

  def hidden_word
    @hidden_word ||= '_' * @word.length
  end

  def remaining_guesses
    @max_guesses - @incorrect_guesses
  end

  attr_reader :guesses

  private

  def valid_guess?(letter)
    return false if @guesses.include?(letter)
    return false if letter.length != 1
    return false if letter.match?(/[^a-zA-Z]/)

    true
  end

  def update_hidden_word(letter)
    @word.chars.each_with_index do |char, index|
      @hidden_word[index] = letter if char == letter
    end
  end
end
