# frozen_string_literal: true

require 'anki_kanji_add/field_selector'

RSpec.describe AnkiKanjiAdd::FieldSelector do
  let(:anki) do
    instance_double(
      'AnkiKanjiAdd::AnkiClient',
      model_field_names: %w[Word Sentence Translation]
    )
  end

  let(:models) { ['Japanese'] }
  let(:input) { StringIO.new("0\n") }
  let(:invalid_input) { StringIO.new("4\n1\n") }
  let(:none_input) { StringIO.new("3\n1\n") }
  let(:output) { StringIO.new }

  it 'prompts and returns the correct model field map' do
    model_field_map = described_class.new(anki:, models:, input:, output:).choose

    expect(anki).to have_received(:model_field_names).once

    expect(model_field_map).to eq({ 'Japanese' => 'Word' })
  end

  it 'reprompts, if the number is out of range' do
    described_class.new(anki:, models:, input: invalid_input, output:).choose

    out = output.string
    expect(out).to include('Number out of range, please provide valid number!')
  end

  it "selects 'None', if last option is selected" do
    model_field_map = described_class.new(anki:, models:, input: none_input, output:).choose

    expect(model_field_map).to eq({ 'Japanese' => 'None' })
  end
end
