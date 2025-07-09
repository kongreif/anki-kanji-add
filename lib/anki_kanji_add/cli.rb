# frozen_string_literal: true

require_relative 'anki_client'
require_relative 'deck_selector'
require_relative 'model_extractor'
require_relative 'field_selector'
require_relative 'note_fetcher'
require_relative 'target_selector'
require_relative 'source_value_extractor'
require_relative 'kanji_meaning_fetcher'

module AnkiKanjiAdd
  class CLI
    def initialize
      @anki = AnkiClient.new
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def start
      puts 'Starting Anki Kanji Add'
      puts '---'

      deck = DeckSelector.new(anki: @anki).choose
      models = ModelExtractor.new(anki: @anki, deck: deck).extract
      model_field_map = FieldSelector.new(anki: @anki, models: models).choose
      p model_field_map
      TargetSelector.new.select
      notes = NoteFetcher.new(anki: @anki, deck: deck).fetch

      # Create Struct array with [{id, source, kanji}
      note_source_maps = SourceValueExtractor.new(notes: notes, model_field_map: model_field_map).extract
      KanjiMeaningFetcher.new(note_source_maps).fetch
      # p note_source_target_maps
      #
      # puts 'Collected kanji data:'
      # p kanji
      #
      # modelFieldAdd
      # updateNoteFields
      puts 'Done.'
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
