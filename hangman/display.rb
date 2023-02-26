# frozen_string_literal: true

class Display
  def self.show_game_state(game)
    puts "The word is: #{game.hidden_word}"
    puts "You have #{game.remaining_guesses} guesses remaining."
    puts "Letters guessed: #{game.guesses.join(', ')}"
  end

  def self.show_game_over(game)
    if game.won?
      puts 'Congratulations! You won the game.'
    else
      puts 'Game over. You have run out of guesses.'
      puts "The word was: #{game.word}"
    end
  end
end
