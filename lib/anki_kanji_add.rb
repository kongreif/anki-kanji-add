# frozen_string_literal: true

require 'net/http'
require 'json'

module AnkiKanjiAdd
  class CLI
    def initialize
      @base_uri = URI('http://localhost:8765')
      @deck = []
      @deck_notes_info = []
      @models = {}
      @note_id_words = {}
    end

    def start
      puts 'Starting Anki Kanji Add'
      puts '---'

      get_deck_id

      get_model_names

      select_note_fields

      get_kanji_texts
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
    end

    def get_model_names
      puts 'Fetching deck notes info from Anki'
      puts '---'

      @deck_notes_info = anki_connection({ action: 'notesInfo', version: 6, params: { query: "deck:#{@deck[0]}" } })
      @deck_notes_info.map { |note_info| @models[:"#{note_info[:modelName]}"] = '' }.uniq
    end

    def select_note_fields
      @models.keys.each do |model_name|
        puts "Select fields that contains text you want to parse for kanji for note type: #{model_name}"
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
        @models[model_name] = if field_index < model_field_names.length
                          model_field_names[field_index]
                        else
                          'None'
                        end
        puts '---'
      end
      puts "You've selected the following note fields"
      @models.each do |(model_name, field_name)|
        puts "#{model_name}: #{field_name}"
      end
    end

    def get_kanji_texts
      @deck_notes_info.map do |note_info|
        
        id          = note_info[:noteId]
        puts "id", id
        model       = note_info[:modelName]
        puts "model", model
        byebug
        source_field= @models[ model ]
        puts "source_field", source_field
        field_hash  = note_info[:fields][ source_field ]
        puts "field_hash", field_hash

        @note_id_words[ id ] = field_hash[:value]
        # puts note_info
        # puts note_info[:noteId]
        # @note_id_words[:note_info[:noteId].to_sym] = note_info[:fields][:models[:note_info[:modelName].to_sym].to_sym]
      end
      puts @note_id_words
    end
  end
end
