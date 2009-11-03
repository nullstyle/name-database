# The Open Name Database Project

This project aims to provide a list of names and associated meta-data, such that you as a developer can produce software that will generate random names in your own software.

## Motivation

So I go to start working on a video game that relies heavily upon procedurally generated content.  One part of this is the need to procedurally create NPCs, and those NPCs need names.  A little browsing on the internet, and a lot of online name generators later, I come to find that people with name lists seem to keep them close to the vest.

This project aims to change that.

## Directory Structure

The motivation for the file naming system is to keep file size down, especially for the family name section.  These data files are separated into 2 sections, given and family names, and then places into files based on the 2 letter prefix of the name. A 1 letter prefix is used as a folder to group files in.  Therefore, each section has 26 folders of 26 files each.

Some example files:

- given\_name/a/ad.yml:  would contain names such as adam or adrian
- family\_name/f/fl.yml: would contain names such as fleckenstein or flanders

In addition to the human savings around keeping file size small, we also get the benefit of faster text editor response times as well as removing the need to parse the entire database at once.
 
## Adding names to the database

Several options are planned or currently available to add names to the db:  currently these are manually, via rake command, or by writing an importer.

### Via rake

Ensuring a name is represented in the database is as simple as `rake name:given:adam` which will ensure that the adam name has an entry in the db.

## File Structure

Each data file is a single yaml document, whose root node is sequence.  Elements of the sequence can either be scalar string or a single-element mapping that maps a name to a set of meta data.  This may be easier to explain with an example:

    ---
    - scott  #single name with no meta data
    - scott: #maps the name scott to the meta data below
        gender: male
        origin: gaelic
        census1990:
          frequency: 0.546
          rank: 32
        

## TODO

- Add gender proportions data for unisex names
  - Should probably choose a gender when one gender vastly outweighs the other.  For example, Adam is generally considered a male name, but according to 1990 census data there are 0.001% of females named Adam.
- Build Freebase importer that will take a person article and populate their name into the data files
- Find some good mythological and historical name lists, such we can have data for creating genre-appropriate names
- Add a sqlite compiler that will produce a sqlite database from the input data files
