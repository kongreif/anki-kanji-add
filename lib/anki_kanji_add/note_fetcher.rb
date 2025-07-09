# frozen_string_literal: true

module AnkiKanjiAdd
  class NoteFetcher
    def initialize(anki:, deck:)
      @anki = anki
      @deck = deck
    end

    def fetch
      @anki.notes_info(@deck.name)
    end
  end
end
