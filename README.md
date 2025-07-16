# AnkiKanjiAdd
AnkiKanjiAdd is a command line tool to annotate all of your japanese Anki notes with the respective Kanji and their meaning. It does so by
1. Letting you select which deck you want to backfill
2. Letting you decide which field of which note type contains the target word you want to base the kanji information on
3. Parsing the respective kanji information from an excerpt of the [KANJIDIC](http://www.edrdg.org/wiki/index.php/KANJIDIC_Project) dictionary of the [Electronic Dictionary Research and Development Group (EDRDG)](https://www.edrdg.org/)
4. Adding or selecting a field to the selected note types (with a name of your choice)
5. Filling the new field with the kanji information for every note of the selected note types

## Installation
### Prerequisites
You have Ruby 3.2+ installed.
If you don't I recommend installing and managing it via [ruby-install](https://github.com/postmodern/ruby-install) and[ chruby](https://github.com/postmodern/chruby). [Here's](https://blog.viniciusrocha.com/posts/installing-ruby-using-chruby/) a guide how it works.

### Install
Cone the project
```terminal
git clone git@github.com:kongreif/anki-kanji-add.git
```
Install the gems in the project folder
```terminal
bundle install
```
## Running the tool
Run the executable from the project folder
```terminal
./bin/anki_kanji_add
```
You can also add the executable to your path, if you want.

## Usage guide
### Purpose
If you have a big collection of japanese Anki word or sentence flashcards that don't contain information about the kanji used in the target word and their meaning, you can use this tool to backfill all of your cards with kanji and their meanings.

E.g. if your target word is `四` it will add `四 four`

If your target word consists of a mix of kanji and kana, the tool can also handle that.  
E.g. if your target word is `開く` it will add `開 open, unfold, unseal`

If your target word contains multiple kanji, the tool will add information for all of them.
E.g. if your target word is `高校生` it will add `高 tall, high, expensive<br>校 exam, school, printing, proof, correction<br>生 life, genuine, birth`
