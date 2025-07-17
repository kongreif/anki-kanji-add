# frozen_string_literal: true

module AnkiKanjiAdd
  class FieldSelector
    def initialize(anki:, models:, input: $stdin, output: $stdout)
      @anki   = anki
      @models = models
      @model_field_map = {}
      @in = input
      @out = output
    end

    def choose
      @models.each do |model|
        @out.puts "Select fields that contains text you want to parse for kanji for note type: #{model}"
        @out.puts
        fields = @anki.model_field_names(model)
        print_fields(fields)
        index = select_field_index(fields)
        map_model_fields(index, model, fields)
      end
      @model_field_map
    end

    def print_fields(fields)
      fields.each_with_index do |f, i|
        @out.puts "#{i}: #{f}"
        @out.puts "#{i + 1}: None" if i == fields.length - 1
      end
    end

    def select_field_index(fields)
      index = @in.gets.chomp.to_i
      while index.negative? || index > fields.length
        @out.puts 'Number out of range, please provide valid number!'
        @out.puts '------------------------------'
        index = @in.gets.chomp.to_i
      end
      @out.puts '------------------------------'
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
