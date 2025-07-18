# frozen_string_literal: true

require 'tempfile'
require 'anki_kanji_add/kanji_dictionary'

RSpec.describe AnkiKanjiAdd::KanjiDictionary do
  let(:json_entries) do
    [
      '一' => ['one'],
      '二' => ['two']
    ]
  end

  let(:temp_file) { Tempfile.new('kanjidic_test') }

  before do
    temp_file.write(JSON.generate(json_entries))
    temp_file.flush
    stub_const('AnkiKanjiAdd::KanjiDictionary::JSON_PATH', temp_file.path)
  end

  after do
    temp_file.close!
  end

  describe '#entries' do
    it 'reads the JSON file and returns parsed entries' do
      dictionary = described_class.new
      expect(dictionary.entries).to eq(json_entries)
    end

    it 'actually reads from disk via JSON_PATH' do
      expect(File).to receive(:read).with(temp_file.path).and_call_original
      described_class.new.entries
    end
  end
end
