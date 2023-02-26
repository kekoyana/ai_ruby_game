# frozen_string_literal: true

class InputValidator
  def self.valid_guess?(guess, guesses)
    return false unless guess.length == 1
    return false unless guess.match?(/[a-zA-Z]/)
    return false if guesses.include?(guess)

    true
  end
end
