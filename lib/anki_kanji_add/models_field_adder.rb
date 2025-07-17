# frozen_string_literal: true

require_relative 'anki_client'

module AnkiKanjiAdd
  class ModelsFieldAdder
    def initialize(anki:, models:, target:, output: $stdout)
      @anki = anki
      @models = models
      @target = target
      @out = output
    end

    def add
      # TODO: Handle empty target
      # TODO: Handle empty models
      # TODO: Prompt
      @models.each do |model|
        @anki.model_field_add(model, @target)
        @out.puts "Added field '#{@target}' to model '#{model}', if it didn't exist before"
      end

      @out.puts '------------------------------'
    end
  end
end
