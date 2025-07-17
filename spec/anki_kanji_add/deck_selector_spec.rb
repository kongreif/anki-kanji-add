# frozen_string_literal: true

require 'anki_kanji_add/deck_selector'

RSpec.describe AnkiKanjiAdd::DeckSelector do
  let(:anki) do
    instance_double(
      'AnkiKanjiAdd::AnkiClient',
      deck_names_and_ids: [
        ['Default', 10],
        ['Japanese', 42],
        ['Misc', 99]
      ]
    )
  end

  let(:input) { StringIO.new("1\n") }
  let(:invalid_input) { StringIO.new("3\n1\n") }
  let(:output) { StringIO.new }

  subject { described_class.new(anki:, input:, output:) }

  it 'prompts and returns the chosen deck' do
    deck = described_class.new(anki:, input:, output:).choose

    expect(anki).to have_received(:deck_names_and_ids).once

    expect(deck.name).to eq('Japanese')
    expect(deck.id).to eq(42)
  end

  it 'reprompts, if the number is out of range' do
    described_class.new(anki:, input: invalid_input, output:).choose

    out = output.string
    expect(out).to include('Number out of range, please provide valid number!')
  end
end
