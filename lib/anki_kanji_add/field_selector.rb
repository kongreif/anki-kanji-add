# frozen_string_literal: true

module AnkiKanjiAdd
  FieldChoice = Struct.new(:source, :target)

  class FieldSelector
    def initialize(anki:, models:)
      @anki   = anki
      @models = models
      @model_field_map = {}
    end

    def choose
      @models.each do |model|
        puts "Select fields that contains text you want to parse for kanji for note type: #{model}"
        fields = @anki.model_field_names(model)
        print_fields(fields)
        index = select_field_index(fields)
        map_model_fields(index, model, fields)
      end
      @model_field_map
    end

    def print_fields(fields)
      fields.each_with_index do |f, i|
        puts "#{i}: #{f}"
        puts "#{i + 1}: None" if i == fields.length - 1
      end
    end

    def select_field_index(fields)
      index = gets.chomp.to_i
      while index.negative? || index > fields.length
        puts 'Number out of range, please provide valid number!'
        puts '---'
        index = gets.chomp.to_i
      end
      index
    end

    def map_model_fields(index, model, fields)
      @model_field_map[model] = if index < @models.length
                                  fields[index]
                                else
                                  'None'
                                end
    end
  end
end
