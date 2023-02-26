# frozen_string_literal: true

class WordGenerator
  def self.generate_word(dictionary)
    words = dictionary.words
    words.sample.downcase
  end
end
