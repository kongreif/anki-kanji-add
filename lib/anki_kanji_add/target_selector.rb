# frozen_string_literal: true

module AnkiKanjiAdd
  class TargetSelector
    def initialize(input: $stdin, output: $stdout)
      @in = input
      @out = output
    end

    def select
      @out.puts 'Please insert name of the existing or new field that should contain the kanji information: '
      target = @in.gets.chomp
      # TODO: Handle empty string
      # TODO: Check for inputs that anki won't be able to handle as field
      @out.puts "Following field will be added to note types with source field: #{target}"
      @out.puts '------------------------------'
      target
    end
  end
end
