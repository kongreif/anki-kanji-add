# frozen_string_literal: true

require 'anki_kanji_add/source_value_extractor'

RSpec.describe AnkiKanjiAdd::SourceValueExtractor do
  let(:notes) do
    [
      {
        noteId: 9_999_999_999_998,
        modelName: 'JapaneseWordNoteType',
        fields: {
          Word: {
            value: '一'
          }
        }
      },
      {
        noteId: 9_999_999_999_999,
        modelName: 'JapaneseSentenceNoteType',
        fields: {
          'Target word': {
            value: '二'
          }
        }
      }
    ]
  end

  let(:model_field_map) do
    {
      'JapaneseWordNoteType' => 'Word',
      'JapaneseSentenceNoteType' => 'Target word'
    }
  end

  let(:expected_note_source_maps) do
    [
      AnkiKanjiAdd::NoteSourceMap.new(notes.first[:noteId], notes.first[:fields][:Word], nil),
      AnkiKanjiAdd::NoteSourceMap.new(notes[1][:noteId], notes[1][:fields][:'Target word'], nil)
    ]
  end

  subject { described_class.new(notes:, model_field_map:).extract }

  describe '#extract' do
    it 'creates the correct note_source_maps' do
      note_source_maps = subject

      expect(note_source_maps).to eq(expected_note_source_maps)
    end
  end
end
