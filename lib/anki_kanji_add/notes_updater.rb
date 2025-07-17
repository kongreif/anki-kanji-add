# frozen_string_literal: true

require_relative 'anki_client'
require 'ruby-progressbar'

module AnkiKanjiAdd
  class NotesUpdater
    def initialize(anki:, filled_note_source_maps:, target:)
      @anki = anki
      @filled_note_source_maps = filled_note_source_maps
      @target = target
    end

    def update
      progress = ProgressBar.create(
        total: @filled_note_source_maps.size,
        format: '[%B] %c/%C',
        length: 100
      )

      # TODO: Prompt for confirmation before updating notes
      puts 'Adding kanji meanings to notes:'
      @filled_note_source_maps.each do |filled_note_source_map|
        @anki.update_note_fields(filled_note_source_map.id, @target, filled_note_source_map.kanji)
        progress.increment
      end
    end
  end
end
