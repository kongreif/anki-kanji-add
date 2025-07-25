# frozen_string_literal: true

require 'net/http'
require 'json'

module AnkiKanjiAdd
  class AnkiClient
    BASE_URI = URI('http://localhost:8765')
    HEADERS = { 'Content-Type' => 'application/json' }.freeze

    def request(action:, params: {})
      payload = { action: action, version: 6, params: params }.to_json
      res     = Net::HTTP.post(BASE_URI, payload, HEADERS)
      raise "HTTP #{res.code}" unless res.is_a?(Net::HTTPSuccess)

      JSON.parse(res.body, symbolize_names: true)[:result]
    end

    def deck_names_and_ids
      request(action: 'deckNamesAndIds')
    end

    def notes_info(deck_name)
      request(action: 'notesInfo', params: { query: "deck:\"#{deck_name}\"" })
    end

    def model_field_names(model_name)
      request(action: 'modelFieldNames', params: { modelName: model_name })
    end

    def model_field_add(model_name, field_name)
      request(action: 'modelFieldAdd', params: { modelName: model_name, fieldName: field_name })
    end

    def update_note_fields(note_id, field_name, field_value)
      request(action: 'updateNoteFields', params: { note: { id: note_id, fields: { field_name => field_value } } })
    end
  end
end
