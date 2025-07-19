# frozen_string_literal: true

require 'anki_kanji_add/kanji_meaning_parser'
require 'anki_kanji_add/source_value_extractor'

RSpec.describe AnkiKanjiAdd::KanjiMeaningParser do
  subject { described_class.new(output:).parse_meaning(note_source_maps) }

  let(:output) { StringIO.new }
  let(:note_source_maps) do
    [
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_998, { value: '一', position: 0 }, nil),
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_999, { value: '二', position: 0 }, nil)
    ]
  end

  let(:filled_note_source_maps) do
    [
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_998, { value: '一', position: 0 }, '一　one, one radical (no.1)<br>'),
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_999, { value: '二', position: 0 }, '二　two, two radical (no. 7)<br>')
    ]
  end

  let(:dict_hash) do
    {
      '一': ['one', 'one radical (no.1)'],
      '二': ['two', 'two radical (no. 7)']
    }
  end

  before do
    dict = instance_double('KanjiDictionary', entries: dict_hash)
    allow(AnkiKanjiAdd::KanjiDictionary).to receive(:new).and_return(dict)
  end

  describe '#parse_meaning' do
    it 'parses the kanji meanings and adds them to the note source maps' do
      filled_note_source_maps = subject

      expect(filled_note_source_maps).to eq(filled_note_source_maps)
    end
  end
end
