# frozen_string_literal: true

require 'anki_kanji_add/models_field_adder'

RSpec.describe AnkiKanjiAdd::ModelsFieldAdder do
  let(:anki) do
    instance_double(
      'AnkiKanjiAdd::AnkiClient',
      model_field_add: []
    )
  end

  let(:models) { %w[Japanese Nihongo] }
  let(:target) { 'kanji' }
  let(:output) { StringIO.new }

  subject { described_class.new(anki:, models:, target:, output:).add }

  it 'calls anki connect to add field to model' do
    subject

    expect(anki).to have_received(:model_field_add).twice
  end
end
