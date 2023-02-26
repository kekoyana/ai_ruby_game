# frozen_string_literal: true

require_relative 'card'

class FreeCell
  attr_reader :card

  def initialize
    @card = nil
  end

  def add_card(card)
    if @card.nil?
      @card = card
      true
    else
      false
    end
  end

  def remove_card
    removed_card = @card
    @card = nil
    removed_card
  end

  def valid_move?(_card)
    @card.nil?
  end

  def to_s
    if @card.nil?
      '   '
    else
      @card.to_s
    end
  end
end
