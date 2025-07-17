# frozen_string_literal: true

module AnkiKanjiAdd
  Deck = Struct.new(:name, :id)

  class DeckSelector
    def initialize(anki:, input: $stdin, output: $stdout)
      @anki = anki
      @in = input
      @out = output
    end

    def choose
      decks = @anki.deck_names_and_ids
      @out.puts 'Please select the deck to annotate with Kanji: '
      decks_array = decks.map { |deck| deck }
      decks.each_with_index { |(name, _id), i| @out.puts "#{i}: #{name}" }
      index = select_deck_index(decks_array)
      name, id = decks_array[index]
      @out.puts "Selected deck: #{name}"
      @out.puts '------------------------------'
      Deck.new(name, id)
    end

    def select_deck_index(decks_array)
      index = @in.gets.chomp.to_i
      while index.negative? || index > decks_array.length - 1
        @out.puts 'Number out of range, please provide valid number!'
        @out.puts '------------------------------'
        index = @in.gets.chomp.to_i
      end
      index
    end
  end
end
