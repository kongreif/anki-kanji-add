# frozen_string_literal: true

require_relative 'kanji_dictionary'

module AnkiKanjiAdd
  class KanjiMeaningParser
    def initialize(output: $stdout)
      @dict = KanjiDictionary.new.entries
      @missing_kanji_meanings = []
      @out = output
    end

    def parse_meaning(note_source_maps)
      note_source_maps.each do |note_source_map|
        kanjis = extract_source_kanji(note_source_map)

        target_value = define_target_value(kanjis)
        note_source_map.kanji = target_value
      end
      print_missing_kanji_meanings if @missing_kanji_meanings.any?

      note_source_maps
    end

    private

    def extract_source_kanji(note_source_map)
      note_source_map.source[:value].chars.grep(/\p{Han}/)
    end

    def define_target_value(kanjis)
      target_value = ''
      kanjis.each do |kanji|
        target_value += "#{kanji} #{@dict[kanji].join(', ')}<br>" if @dict[kanji]
        @missing_kanji_meanings << kanji unless @dict[kanji]
      end
      target_value
    end

    def print_missing_kanji_meanings
      @out.puts 'No meanings found for following kanji:'
      @out.puts @missing_kanji_meanings.uniq.join(', ')
      @out.puts '------------------------------'
    end
  end
end
