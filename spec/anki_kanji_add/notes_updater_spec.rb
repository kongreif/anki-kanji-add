# frozen_string_literal: true

require 'anki_kanji_add/notes_updater'
require 'anki_kanji_add/source_value_extractor'

RSpec.describe AnkiKanjiAdd::NotesUpdater do
  let(:anki) do
    instance_double(AnkiKanjiAdd::AnkiClient)
  end

  let(:filled_note_source_maps) do
    [
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_998, { value: '一', position: 0 }, '一 one'),
      AnkiKanjiAdd::NoteSourceMap.new(9_999_999_999_999, { value: '二', position: 0 }, '二 two')
    ]
  end
  let(:target) { 'kanji' }
  let(:output) { StringIO.new }

  before do
    allow(anki).to receive(:update_note_fields)
  end

  subject { described_class.new(anki:, filled_note_source_maps:, target:, output:).update }

  describe '#update' do
    it 'calls anki one time per source map' do
      subject

      expect(anki).to have_received(:update_note_fields).twice
    end
  end
end
