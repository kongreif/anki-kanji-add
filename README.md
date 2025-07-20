# AnkiKanjiAdd
AnkiKanjiAdd is a command line tool to annotate all of your japanese Anki notes with the respective Kanji and their meaning. It does so by
1. Letting you select which deck you want to backfill with Kanji
2. Letting you decide which field of which note type contains the target word you want to base the kanji information on
3. Parsing the respective kanji information from an excerpt of the [KANJIDIC](http://www.edrdg.org/wiki/index.php/KANJIDIC_Project) dictionary
4. Adding or selecting a field to the selected note types (with a name of your choice)
5. Filling the new field with the kanji information for every note of the selected note types

## Installation
### Prerequisites
You have Ruby 3.2+ installed.
If you don't I recommend installing and managing it via [ruby-install](https://github.com/postmodern/ruby-install) and[ chruby](https://github.com/postmodern/chruby). [Here's](https://blog.viniciusrocha.com/posts/installing-ruby-using-chruby/) a guide how it works.

You have the [AnkiConnect](https://github.com/amikey/anki-connect) add-on installed in Anki.

Anki is running.

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

### Procedure
#### 1. Select deck
When starting the tool it displays all decks of your anki collection. You can select one deck by inserting the number (index) next to it and pressing enter.
The tool will display the selected deck.

#### 2. Source field selection
Next for each note type that's present in the selected deck the tool asks you to select a source field. The source field is the field that contains japanese script and for which you want to generate kanji information.
You can select the option 'None', if you don't want to backfill kanji for a specific note type.

#### 3. Define target field
Next your prompted to insert the name of the field that should contain the kanji information. This can be either an existing field (the tool will overwrite the contents of this field for every note of the note type in the selected deck) or a field that the tool should add to the note type. So for the first time you run the tool you could define a new field and if you want to run the tool in the future again, because you have new cards, you can use the same field again.

#### 4. Execution
After defining the target field the tool will add the field to all notes you haven't selected 'None' for in step 2. Then it will fill the target field for each note of the selected note types in the deck with kanji information based on the source field of the respective note type.


### Outcome
Here's the output the tool will generate for 
E.g. if your source field is `四` it will add `四 four<br>` to the target field.

If your source field consists of a mix of kanji and kana, the tool can also handle that.  
E.g. if your source field is `開く` it will add `開 open, unfold, unseal<br>` to the target field.

If your source field contains multiple kanji, the tool will add information for all of them.
E.g. if your source field is `高校生` it will add `高 tall, high, expensive<br>校 exam, school, printing, proof, correction<br>生 life, genuine, birth<br>` to the target field.

## Data licence
This tool includes an excerpt of [KANJIDIC2](https://www.edrdg.org/edrdg/licence.html) (© Jim Breen & [EDRDG](https://www.edrdg.org/edrdg/licence.html)) in `data/kanjidic2-excerpt.json`.  
That data is governed by the **[EDRDG Licence](https://www.edrdg.org/edrdg/licence.html)**
