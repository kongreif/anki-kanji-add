# frozen_string_literal: true

require 'anki_kanji_add/anki_client'

RSpec.describe AnkiKanjiAdd::AnkiClient do
  subject { described_class.new }
  let(:deck_names_and_ids_json) do
    {
      result: ['Deck A', 'Deck B', 'Deck C'],
      error: nil
    }.to_json
  end

  let(:notes_info_json) do
    {
      result: [{ noteId: 1 }, { noteId: 2 }],
      error: nil
    }.to_json
  end

  let(:model_field_names_json) do
    {
      result: %w[Word Sentence Translation],
      error: nil
    }.to_json
  end

  let(:post_json) do
    {
      result: nil,
      error: nil
    }.to_json
  end

  let(:raw_json) { deck_names_and_ids_json }
  let(:http_response) do
    instance_double(
      Net::HTTPResponse,
      is_a?: true, # so `res.is_a?(Net::HTTPSuccess)` passes
      code: '200',
      body: raw_json
    )
  end

  before do
    allow(Net::HTTP).to receive(:post).and_return(http_response)
  end

  describe '#deck_names_and_ids' do
    let(:raw_json) { deck_names_and_ids_json }

    it 'makes one HTTP request' do
      subject.deck_names_and_ids

      expect(Net::HTTP).to have_received(:post).once
    end

    it 'returns the deck names' do
      decks = subject.deck_names_and_ids

      expect(decks).to eq(['Deck A', 'Deck B', 'Deck C'])
    end
  end

  describe '#notes_info' do
    let(:raw_json) { notes_info_json }

    it 'makes one HTTP request' do
      subject.notes_info('Deck A')

      expect(Net::HTTP).to have_received(:post).once
    end

    it 'returns the parsed notes infos' do
      note_infos = subject.notes_info('Deck A')

      expect(note_infos).to eq([{ noteId: 1 }, { noteId: 2 }])
    end
  end

  describe '#model_field_names' do
    let(:raw_json) { model_field_names_json }

    it 'makes one HTTP request' do
      subject.model_field_names('Model A')

      expect(Net::HTTP).to have_received(:post).once
    end

    it 'returns the model field names' do
      model_field_names = subject.model_field_names('Model A')

      expect(model_field_names).to eq(%w[Word Sentence Translation])
    end
  end

  describe '#model_field_add' do
    let(:raw_json) { post_json }

    it 'makes one HTTP request' do
      subject.model_field_add('Model A', 'Field A')

      expect(Net::HTTP).to have_received(:post).once
    end

    it 'returns the model field names' do
      result = subject.model_field_add('Model A', 'Field A')

      expect(result).to eq(nil)
    end
  end

  describe '#update_note_fields' do
    let(:raw_json) { post_json }

    it 'makes one HTTP request' do
      subject.update_note_fields(999_999_999, 'Field A', '一')

      expect(Net::HTTP).to have_received(:post).once
    end

    it 'returns the model field names' do
      result = subject.update_note_fields(999_999_999, 'Field A', '一')

      expect(result).to eq(nil)
    end
  end
end
