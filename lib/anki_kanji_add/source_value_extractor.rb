# frozen_string_literal: true

module AnkiKanjiAdd
  NoteSourceMap = Struct.new(:id, :source, :kanji)

  class SourceValueExtractor
    def initialize(notes:, model_field_map:)
      @notes = notes
      @model_field_map = model_field_map
      @note_source_maps = []
    end

    def extract
      @notes.map do |note|
        id = note[:noteId]
        model = note[:modelName]
        source_field = @model_field_map[model]
        source = note[:fields][source_field.to_sym]

        @note_source_maps << NoteSourceMap.new(id, source, nil)
      end
      @note_source_maps
    end
  end
end
