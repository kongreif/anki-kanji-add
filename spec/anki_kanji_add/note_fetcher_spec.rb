# frozen_string_literal: true

require 'anki_kanji_add/note_fetcher'
require 'anki_kanji_add/deck_selector'

RSpec.describe AnkiKanjiAdd::NoteFetcher do
  let(:anki) do
    instance_double(AnkiKanjiAdd::AnkiClient)
  end

  let(:deck) { AnkiKanjiAdd::Deck.new('Japanese', 9_999_999_999_999) }

  let(:notes_info) { [{ noteId: 9_999_999_999_998 }, { noteId: 9_999_999_999_999 }] }
  before do
    allow(anki).to receive(:notes_info).and_return(notes_info)
  end

  subject { described_class.new(anki:, deck:).fetch }

  describe '#fetch' do
    it 'calls anki one time' do
      subject

      expect(anki).to have_received(:notes_info).once
    end

    it 'receives the notes_info' do
      notes_info = subject
      expect(notes_info).to eq(notes_info)
    end
  end
end
