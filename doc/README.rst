|MIT|

.. |MIT| image:: https://img.shields.io/badge/License-MIT-green.svg

LuaNameGen - Lua Name Generator v1.0.0
=======================================

What if, instead of Bilbo and Frodo, Tolkien's characters were named Bill and Fred?

Or if, during the climax of a role-playing session, you face an Ancient Red Dragon called Bob...

LuaNameGen is an effort to quickly create random names for characters, objects and places. It is useful for both table-top games (run the script, grab the name) or to be used as a library for game development.

Free the syllables, create fantastic names, have fun, provide fun.

Table of contents
==================

* `Inspiration`_

  - `Code`_

  - `Names and syllables`_

* `Usage`_

  - `Basic usage`_

  - `Like-a-boss usage`_

* `How does it works?`_

  - `Basics`_

  - `Syllable Groups`_

  - `Rules`_

* `How to help`_

* `Example of generated names`_

* `Release News`_


Inspiration
============

Code
-----

This script is shamelessly inspired by the great `libtcod's namegen`_, written by Dominik "Mingos" Marczuk. It even uses its syntax for .cfg files, aiming to provide compatibility with its existing sets.

.. _`libtcod's namegen`: https://bitbucket.org/libtcod/libtcod/src/afba13253a79f16d10f596e2c9c99cf183f94b3c/src/namegen_c.c


Names and syllables
--------------------

Part of the patterns used in this this script were adapted from:

* `libtcod's namegen sets`, written by Mingos and Jice;

Inspiration came from sources such as:

* J.R.R. Tolkien's works;
* Gary Gygax's works;
* Many other fantasy novels;
* `d20pfsrd.com`_, the huge, free and beautiful PF SRD :)
* `fantasynamegenerators.com`_;
* `fantasynamegen.com`_;
* `creative-role-playing.com`_ fantasy-sounding-names;
* other generators that I shall remember someday.

.. _`d20pfsrd.com`: http://www.d20pfsrd.com/
.. _`fantasynamegenerators.com`: https://fantasynamegenerators.com/
.. _`fantasynamegen.com`: https://www.fantasynamegen.com/
.. _`creative-role-playing.com`: http://web.archive.org/web/20141009095317/https://www.creative-role-playing.com/fantasy-sounding-names/

Usage
======

Basic usage
------------

To get a dwarf name and surname, using default sets, just do:

.. code-block:: lua

   local namegen = require("namegen")

   local name = namegen.generate("dwarf male")  --  Dolin
   local surname = namegen.generate("dwarf surname")  --  Steelcutter

Like-a-boss usage
------------------

To get whatever you want, call for a name set with the rule you want:

.. code-block:: lua

   local namegen = require("namegen")

   local syllable_a = namegen.generate_custom(
       "orc female 2", "$A$10B")  --  Bragluk
   local syllable_b = namegen.generate_custom(
       "giant female", "$B$10B")  --  tuhli
   local syllable_c = namegen.generate_custom(
       "infernal 1", "-$B$B")  -- -mozraz
   print("It's alive!!!", syllable_a .. syllable_b .. syllable_c)
   -- It's alive!!!   Bragluktuhli-mozraz


How does it works?
===================

Basics
-------

When loaded/required, the module "namegen" parses the set files pointed by 'namegen.index' (a plain text file).

Each line of 'namegen.index' indicates the location of a set file to be readed. By default it only contains one: `namegen.cfg`.

Each set file (also plain text files) follows a simple syntax (libtcod's syntax, so any .cfg file from it can be used), and may contains multiple sets. This is an example of a basic set:

.. code-block:: none

   name "dwarf male" {
       syllablesStart  = "Do, Due"
       syllablesEnd = "lin, rin"
       rules = "$s$e"
   }

This set with its only rule would generate names such as:

* Dolin;

* Dorin;

* Duelin;

* Duerin;

Syllable Groups
----------------

Every syllable group has a matching symbol (used rules, `s` and `e` in the previous example) that matches it, and will, after parsed, be stored under a specific key on the parser data table:

.. code-block:: none

   symbol  group name          parser field
   ------  ----------          ------------
   s       syllablesStart      parser_data["start"]
   m       syllablesMiddle     parser_data["middle"]
   e       syllablesEnd        parser_data["end"]
   P       syllablesPre        parser_data["pre"]
   p       syllablesPost       parser_data["post"]
   v       phonemesVocals      parser_data["vocals"]
   c       phonemesConsonants  parser_data["consonants"]
   A       customGroupA        parser_data["cga"]
   B       customGroupB        parser_data["cgb"]
   ... (custom groups exist from `A` to `O`)
   N       customGroupN        parser_data["cgn"]
   O       customGroupO        parser_data["cgo"]
   ?       phonemesVocals/     parser_data["vocals"]/
           phonemesConsonants  parser_data["consonants"]

Rules
------

Considering the basic example above, if you replace its rule for "$e$s", that would swap syllables in the generated names.

It is possible to set a chance of adding a syllable. The rule "$s$e$50e" would have fifty percent chance of adding a third syllable from `syllablesEnd` group (or the matching group of the letter you pass).

If you want to have multiple rules for a same set, simply separate them with a comma:

.. code-block:: none

    rules = "$e$s, $s$e"

Each rule would have an equal chance to be used at each generation. If desired, you can give specific chances for each rule (by default they all have the same chance of being used):

.. code-block:: none

    rules = "%50$e$s, $s$e"

Instead of each rule having 1/2 chance to be used, the first one would have 1/2*50% chance.

How to help
============

* Improve the lua code, performance-wise, fix bugs, etc.

* You can help to test or improve content:

  - test existing syllable sets;

  - improve them:

    + create a new rule;

    + modify a new rule;

    + change/remove syllables or syllable groups;

    + add some illegal results to avoid weird combinations;

  - submit a new set.

  - `improve the documentation`.

On both cases the optimal way to it is by following github's workflow_: fork, fix, submit a pull request.

You can also report an issue_.

.. _workflow: https://help.github.com/articles/fork-a-repo/
.. _issue: https://github.com/LukeMS/lua-namegen/issues
.. _`improve the documentation`: https://github.com/LukeMS/lua-namegen/edit/master/README.rst

Example of generated names
===========================

This is a list of a few names genereated by the default sets:

.. literalinclude:: examples.rst


Release News
============

This describes the latest LuaNameGen changes.

1.0.1
------

* Fixed an critical error that prevented the data files (.cfg, .index) from being loaded at all while calling the library from outside of its own directory.

* Made a doc generator to provide sphynx-like basic `literalinclude` (github don't support it)
