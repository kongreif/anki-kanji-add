# frozen_string_literal: true

module AnkiKanjiAdd
  Deck = Struct.new(:name, :id)

  class DeckSelector
    def initialize(anki:)
      @anki = anki
    end

    def choose
      decks = @anki.deck_names_and_ids
      puts 'Please select the deck to annotate with Kanji: '
      decks_array = decks.map { |deck| deck }
      decks.each_with_index { |(name, _id), i| puts "#{i}: #{name}" }
      index = select_deck_index(decks_array)
      name, id = decks_array[index]
      puts "Selected deck: #{name}"
      Deck.new(name, id)
    end

    def select_deck_index(decks_array)
      index = gets.chomp.to_i
      while index.negative? || index > decks_array.length - 1
        puts 'Number out of range, please provide valid number!'
        puts '---'
        index = gets.chomp.to_i
      end
      index
    end
  end
end
