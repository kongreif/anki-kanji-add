# frozen_string_literal: true

require 'anki_kanji_add/model_extractor'
require 'anki_kanji_add/deck_selector'

RSpec.describe AnkiKanjiAdd::ModelExtractor do
  subject { described_class.new(anki:, deck:).extract }

  let(:deck) { AnkiKanjiAdd::Deck.new(name: 'japanese', id: 9_999_999_999_999) }
  let(:anki) { instance_double(AnkiKanjiAdd::AnkiClient) }

  before do
    allow(anki).to receive(:notes_info).and_return(notes_info)
  end

  let(:unique_notes) do
    [
      { modelName: 'Japanese' },
      { modelName: 'Chinese' }
    ]
  end

  let(:duplicate_notes) do
    [
      { modelName: 'Japanese' },
      { modelName: 'Japanese' }
    ]
  end

  context 'when notes have unique model names' do
    let(:notes_info) { unique_notes }

    it 'requests notes_info once' do
      subject

      expect(anki).to have_received(:notes_info).once
    end

    it 'returns the model names' do
      models = subject

      expect(models).to eq(%w[Japanese Chinese])
    end
  end

  context 'when there are duplicate model names' do
    let(:notes_info) { duplicate_notes }

    it 'removes duplicate model names' do
      models = subject

      expect(models).to eq(%w[Japanese])
    end
  end
end
