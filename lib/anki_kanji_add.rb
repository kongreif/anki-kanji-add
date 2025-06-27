# frozen_string_literal: true

require 'net/http'
require 'json'

module AnkiKanjiAdd
  class CLI
    def initialize
      @base_uri = URI('http://localhost:8765')
      @deck_id = ''
      @deck = []
      @deck_notes_info = []
      @model_names = []
    end

    def start
      puts 'Starting Anki Kanji Add'
      puts '---'

      get_deck_id

      get_notes_info

      # updateNoteFields
      puts 'end'
    end

    private

    def get_deck_id
      puts 'Fetching deck names from Anki'
      puts '---'

      res = Net::HTTP.post(@base_uri, {action: 'deckNamesAndIds', version: 6}.to_json)

      puts 'Please select the deck to annotate with Kanji:'
      # TODO: Add error handling
      decks = JSON.parse(res.body, symbolize_names: true)[:result]
      decks_array = decks.map { |deck| deck }

      decks_array.each_with_index do |(deck_name, _id), i|
        puts "#{i}: #{deck_name}"
      end

      deck_index = gets.chomp.to_i
      while deck_index < 0 || deck_index > decks_array.length - 1
        puts 'Number out of range, please provide valid number!'
        puts '---'
        deck_index = gets.chomp.to_i
      end

      puts "You selected #{deck_index}: #{decks_array[deck_index][0]}"
      @deck = decks_array[deck_index]
      @deck_id = decks_array[deck_index][1]
    end

    def get_notes_info
      puts 'Fetching deck notes info from Anki'
      puts '---'

      res = Net::HTTP.post(@base_uri, {action: 'notesInfo', version: 6, params: { query: "deck:#{@deck[0]}"}}.to_json)
      @deck_notes_info = JSON.parse(res.body, symbolize_names: true)[:result]
      p @deck_notes_info[0][:modelName]
      @model_names = @deck_notes_info.map { |note_info| note_info[:modelName] }.uniq
      p @model_names
    end
  end
end
