# frozen_string_literal: true

module AnkiKanjiAdd
  class TargetSelector
    def select
      puts 'Please insert name of the field that should contain the kanji information: '
      target = gets.chomp
      puts "Following field will be added to note types with source field: #{target}"
      puts '------------------------------'
      target
    end
  end
end
