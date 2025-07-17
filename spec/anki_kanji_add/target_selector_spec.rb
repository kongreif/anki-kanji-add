# frozen_string_literal: true

require 'anki_kanji_add/target_selector'

RSpec.describe AnkiKanjiAdd::TargetSelector do
  let(:input) { StringIO.new("kanji\n") }
  let(:output) { StringIO.new }

  subject { described_class.new(input:, output:).select }

  it 'prompts and returns the selected target field' do
    target = described_class.new(input:, output:).select

    expect(target).to eq('kanji')
  end
end
