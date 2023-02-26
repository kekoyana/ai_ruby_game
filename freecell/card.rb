# frozen_string_literal: true

class Card
  attr_reader :rank, :suit

  def initialize(rank, suit)
    @rank = rank
    @suit = suit
  end

  def to_s
    "#{@rank}#{@suit}"
  end

  def ==(other)
    @rank == other.rank && @suit == other.suit
  end

  def >(other)
    if @suit == other.suit
      @rank > other.rank
    else
      suit_rank = { 'C' => 0, 'D' => 1, 'H' => 2, 'S' => 3 }
      suit_rank[@suit] > suit_rank[other.suit]
    end
  end

  def <(other)
    if @suit == other.suit
      @rank < other.rank
    else
      suit_rank = { 'C' => 0, 'D' => 1, 'H' => 2, 'S' => 3 }
      suit_rank[@suit] < suit_rank[other.suit]
    end
  end
end
