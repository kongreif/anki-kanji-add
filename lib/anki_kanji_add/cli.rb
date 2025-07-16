# frozen_string_literal: true

require_relative 'anki_client'
require_relative 'deck_selector'
require_relative 'model_extractor'
require_relative 'field_selector'
require_relative 'note_fetcher'
require_relative 'target_selector'
require_relative 'source_value_extractor'
require_relative 'kanji_meaning_parser'
require_relative 'models_field_adder'
require_relative 'notes_updater'

module AnkiKanjiAdd
  class CLI
    def initialize
      @anki = AnkiClient.new
    end

    # rubocop:disable Metrics/AbcSize, Metrics/MethodLength
    def start
      puts 'Starting Anki Kanji Add'
      puts '------------------------------'

      deck = DeckSelector.new(anki: @anki).choose
      models = ModelExtractor.new(anki: @anki, deck: deck).extract
      model_field_map = FieldSelector.new(anki: @anki, models: models).choose
      target = TargetSelector.new.select
      notes = NoteFetcher.new(anki: @anki, deck: deck).fetch

      note_source_maps = SourceValueExtractor.new(notes: notes, model_field_map: model_field_map).extract
      filled_note_source_maps = KanjiMeaningParser.new.parse_meaning(note_source_maps)
      ModelsFieldAdder.new(anki: @anki, models: models, target:).add
      NotesUpdater.new(anki: @anki, filled_note_source_maps:, target:).update
      puts 'Done'
    end
    # rubocop:enable Metrics/AbcSize, Metrics/MethodLength
  end
end
