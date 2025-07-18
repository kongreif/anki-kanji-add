# frozen_string_literal: true

module AnkiKanjiAdd
  class ModelExtractor
    def initialize(anki:, deck:)
      @anki = anki
      @deck = deck
    end

    def extract
      infos = @anki.notes_info(@deck.name)

      infos.map { |info| info[:modelName] }.uniq
    end
  end
end
