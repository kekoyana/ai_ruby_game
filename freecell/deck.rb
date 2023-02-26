# frozen_string_literal: true

require_relative 'card'

class Deck
  attr_reader :cards

  SUITS = %w[C D H S].freeze
  RANKS = %w[A 2 3 4 5 6 7 8 9 10 J Q K].freeze

  def initialize
    @cards = []
    RANKS.each do |rank|
      SUITS.each do |suit|
        card = Card.new(rank, suit)
        @cards << card
      end
    end
  end

  def shuffle
    @cards.shuffle!
  end

  def deal_card
    @cards.pop
  end
end
