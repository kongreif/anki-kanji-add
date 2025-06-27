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
      @note_fields = []
    end

    def start
      puts 'Starting Anki Kanji Add'
      puts '---'

      get_deck_id

      get_model_names

      select_note_fields
      # updateNoteFields
      puts 'end'
    end

    private

    def anki_connection(params)
      res = Net::HTTP.post(@base_uri, params.to_json)
      # TODO: Add error handling
      JSON.parse(res.body, symbolize_names: true)[:result]
    end

    def get_deck_id
      puts 'Fetching deck names from Anki'
      puts '---'

      # res = Net::HTTP.post(@base_uri, { action: 'deckNamesAndIds', version: 6 }.to_json)

      puts 'Please select the deck to annotate with Kanji:'
      decks = anki_connection({ action: 'deckNamesAndIds', version: 6 })
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

    def get_model_names
      puts 'Fetching deck notes info from Anki'
      puts '---'

      @deck_notes_info = anki_connection({ action: 'notesInfo', version: 6, params: { query: "deck:#{@deck[0]}" } })
      @model_names = @deck_notes_info.map { |note_info| note_info[:modelName] }.uniq
    end

    def select_note_fields
      @model_names.each do |model_name|
        model_field_names = anki_connection({ action: 'modelFieldNames', version: 6,
                                              params: { modelName: model_name } })
        model_field_names.each_with_index do |field, i|
          puts "#{i}: #{field}"
          puts "#{i + 1}: None" if i == model_field_names.length - 1
        end

        field_index = gets.chomp.to_i
        while field_index < 0 || field_index > model_field_names.length
          puts 'Number out of range, please provide valid number!'
          puts '---'
          field_index = gets.chomp.to_i
        end
        @note_fields << if field_index < model_field_names.length
                          model_field_names[field_index]
                        else
                          'None'
                        end
      end
      puts @note_fields
    end
  end
end
