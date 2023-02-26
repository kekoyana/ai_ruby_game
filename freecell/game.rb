# frozen_string_literal: true

require_relative 'card'
require_relative 'deck'
require_relative 'tableau'
require_relative 'foundation'
require_relative 'free_cell'

class Game
  attr_reader :tableaus, :foundations, :free_cells, :deck

  def initialize
    @tableaus = Array.new(8) { Tableau.new }
    @foundations = {
      'C' => Foundation.new('C'),
      'D' => Foundation.new('D'),
      'H' => Foundation.new('H'),
      'S' => Foundation.new('S')
    }
    @free_cells = Array.new(4) { FreeCell.new }
    @deck = Deck.new
  end

  def play
    @deck.shuffle
    deal_cards
    loop do
      display_game
      move = get_move
      break if move == 'quit'

      process_move(move)
      if game_over?
        puts 'Congratulations! You won!'
        break
      end
    end
  end

  def deal_cards
    @tableaus.each_with_index do |tableau, _index|
      7.times do
        card = @deck.deal_card
        tableau.add_card(card)
      end
    end
  end

  def display_game
    system('clear')
    puts 'Foundations:'
    puts "C: #{foundations['C']}"
    puts "D: #{foundations['D']}"
    puts "H: #{foundations['H']}"
    puts "S: #{foundations['S']}"
    puts ''
    puts 'Free cells:'
    @free_cells.each_with_index do |free_cell, index|
      print "F#{index + 1}: #{free_cell}  "
    end
    puts ''
    puts ''
    puts 'Tableaus:'
    tableau_size = @tableaus.map { |tableau| tableau.cards.size }.max
    tableau_size.times do |row|
      @tableaus.each do |tableau|
        print "#{tableau.cards[row]}  "
      end
      puts ''
    end
    puts ''
  end

  def get_move
    print 'Enter move: '
    gets.chomp
  end

  def process_move(move)
    move_parts = move.split
    from = move_parts[0]
    to = move_parts[2]
    card_string = move_parts[1]
    card = Card.parse(card_string)
    from_object = get_object(from)
    to_object = get_object(to)
    return unless from_object.valid_move?(card) && to_object.add_card(card)

    from_object.remove_card(card)
  end

  def get_object(identifier)
    if identifier == 'd'
      @deck
    elsif identifier.start_with?('f')
      index = identifier[1].to_i - 1
      @free_cells[index]
    elsif identifier.start_with?('t')
      index = identifier[1].to_i - 1
      @tableaus[index]
    elsif identifier.start_with?('F')
      @foundations[identifier[1]]
    end
  end

  def game_over?
    @foundations.values.all? { |foundation| foundation.cards.size == 13 }
  end
end
