# frozen_string_literal: true

require 'net/http'
require 'json'

module AnkiKanjiAdd
  class CLI
    def self.start
      puts 'Starting Anki Kanji Add'
      puts '---'

      self.ping_anki

      puts 'end'
    end

    private

    def self.ping_anki
      puts 'Fetching deck names from Anki'
      puts '---'

      uri = URI('http://localhost:8765')
      res = Net::HTTP.post(uri, {action: 'deckNames', version: 6}.to_json)

      puts 'Please select the deck to annotate with Kanji:'
      decks = JSON.parse(res.body)["result"]

      decks.each_with_index do |deck, i|
        puts "#{i}: #{deck}"
      end

      deck_index = gets.chomp.to_i
      puts "You selected #{deck_index}: #{decks[deck_index]}"
    end
  end
end
