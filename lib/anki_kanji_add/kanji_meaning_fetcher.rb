# frozen_string_literal: true

require 'net/http'
require 'json'

module AnkiKanjiAdd
  class KanjiMeaningFetcher
    BASE_URI = URI('https://kanjiapi.dev/v1/kanji/')
    def initialize(note_source_maps)
      @note_source_maps = note_source_maps
    end

    def fetch
      @note_source_maps.each do |note_source_map|
        kanjis = extract_kanji(note_source_map)

        target_value = ''
        kanjis.each do |kanji|
          meaning = fetch_meaning(kanji)
          target_value += "#{kanji} #{meaning} "
        end
        note_source_map.kanji = target_value
      end
      @note_source_maps
    end

    def extract_kanji(note_source_map)
      note_source_map.source[:value].chars.grep(/\p{Han}/)
    end

    def fetch_meaning(kanji)
      res = Net::HTTP.get_response(URI(BASE_URI.to_s + URI.encode_www_form_component(kanji)))
      meaning = JSON.parse(res.body, symbolize_names: true)[:heisig_en]
      raise "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)

      meaning
    end
  end
end
