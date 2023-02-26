# frozen_string_literal: true

require_relative 'dictionary'
require_relative 'word_generator'
require_relative 'hangman_game'
require_relative 'display'
require_relative 'input_validator'

dictionary = Dictionary.new('dictionary.txt')

word = WordGenerator.generate_word(dictionary)
game = HangmanGame.new(word)

until game.game_over?
  Display.show_game_state(game)

  print 'Guess a letter: '
  guess = gets.chomp.downcase

  unless InputValidator.valid_guess?(guess, game.guesses)
    puts 'Invalid guess. Please try again.'
    next
  end

  game.guess(guess)
end

Display.show_game_over(game)
