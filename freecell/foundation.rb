# frozen_string_literal: true

require_relative 'card'

class Foundation
  attr_reader :suit, :cards

  def initialize(suit)
    @suit = suit
    @cards = []
  end

  def add_card(card)
    if valid_move?(card)
      @cards << card
      true
    else
      false
    end
  end

  def remove_card(card)
    @cards.delete(card)
  end

  def valid_move?(card)
    if @cards.empty?
      card.rank == 'A' && card.suit == @suit
    else
      top_card = @cards.last
      card.suit == top_card.suit && card.rank == top_card.rank.to_i + 1
    end
  end

  def to_s
    if @cards.empty?
      "#{@suit}  "
    else
      @cards.map(&:to_s).join(' ')
    end
  end
end
