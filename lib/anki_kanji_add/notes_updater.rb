# frozen_string_literal: true

require_relative 'anki_client'
require 'ruby-progressbar'

module AnkiKanjiAdd
  class NotesUpdater
    def initialize(anki:, filled_note_source_maps:, target:, output: $stdout)
      @anki = anki
      @filled_note_source_maps = filled_note_source_maps
      @target = target
      @out = output
    end

    def update
      # TODO: Prompt for confirmation before updating notes
      @out.puts 'Adding kanji meanings to notes:'
      progress = ProgressBar.create(
        total: @filled_note_source_maps.size,
        format: '[%B] %c/%C',
        length: 100,
        output: @out
      )

      update_note_fields(progress)
    end

    def update_note_fields(progress)
      @filled_note_source_maps.each do |filled_note_source_map|
        @anki.update_note_fields(filled_note_source_map.id, @target, filled_note_source_map.kanji)
        progress.increment
      end
    end
  end
end
