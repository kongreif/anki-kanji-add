# frozen_string_literal: true

require_relative 'anki_client'

module AnkiKanjiAdd
  class ModelsFieldAdder
    def initialize(anki:, models:, target:)
      @anki = anki
      @models = models
      @target = target
    end

    def add
      @models.each do |model|
        @anki.model_field_add(model, @target)
        puts "Added field '#{@target}' to model '#{model}', if it didn't exist before"
      end

      puts '------------------------------'
    end
  end
end
