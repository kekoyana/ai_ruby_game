# frozen_string_literal: true

require_relative 'card'

class Tableau
  attr_reader :cards

  def initialize
    @cards = []
  end

  def add_card(card)
    @cards << card
  end

  def remove_card(card)
    @cards.delete(card)
  end

  def valid_move?(card)
    if @cards.empty?
      card.rank == 'K'
    else
      top_card = @cards.last
      card.color != top_card.color && card.rank == top_card.rank.to_i - 1
    end
  end

  def to_s
    if @cards.empty?
      '   '
    else
      @cards.map(&:to_s).join(' ')
    end
  end
end
