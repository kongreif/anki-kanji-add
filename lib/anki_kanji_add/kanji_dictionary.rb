# frozen_string_literal: true

require 'json'

module AnkiKanjiAdd
  class KanjiDictionary
    JSON_PATH = File.expand_path('../../data/kanjidic2-excerpt.json', __dir__)

    def initialize
      @file = File.read(JSON_PATH)
    end

    def entries
      JSON.parse(@file)
    end
  end
end
