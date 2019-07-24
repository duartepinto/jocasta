# Jocasta
![Gem](https://img.shields.io/gem/v/jocasta.svg)


Utility to extract a section of a Markdown file and write it into a separate file.

## Installation 

`gem install jocasta`

## Usage

`jocasta [input] [output] [level] [section] [...options]`

* __input__ - input markdown file. 
* __output__ - Markdown file that will be written. 
* __level__ - Level of the section to be extracted (`# Level1` `## Level2` `### Level3`)
* __section__ - Section to be extracted. It will also extract sub-sections inside this section.

Options:
* __--title__ - Title that will replace the section title in the output file. If none, it will use the same title.

Named after [Jocasta Nu](https://starwars.fandom.com/wiki/Jocasta_Nu) from Star Wars.
Based on script made by [ReSwift](https://github.com/ReSwift/ReSwift/blob/master/.scripts/doc-preprocessor)
