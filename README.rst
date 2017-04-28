|MIT|

.. |MIT| image:: https://img.shields.io/badge/License-MIT-green.svg


LuaNameGen - Lua Name Generator v1.1.0
=======================================

LuaNameGen is a tool to quickly generate random names for characters, objects and places. It is useful for both table-top games (run the script, grab the name) or to be used as a library for game development.

Never again face an Ancient Red Dragon named Bob!


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

* `Release notes`_

* `Example of generated names`_

  - `Books`_

  - `Creatures`_

  - `Potions`_

  - `Towns`_


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

Help is always appreciated. Those are the main forms to get involved:

* Test and improve content:

  - test existing name sets;

  - improve them:

    + create a new rule;

    + modify a new rule;

    + change/remove syllables or syllable groups;

    + add some illegal results to avoid weird combinations;

  - create a new set.

* Make changes to the Lua code, improving performance, fixing bugs, etc;

* `Improve the documentation`.

On all cases, the optimal way to proceed is by following github's workflow_: fork this repo, change it and then submit a pull request.

You can also report an issue_ (and add a fix for it on the comments).

.. _workflow: https://help.github.com/articles/fork-a-repo/
.. _issue: https://github.com/LukeMS/lua-namegen/issues
.. _`Improve the documentation`: https://github.com/LukeMS/lua-namegen/edit/master/README.rst


Release notes
============

1.2.0
------
* Added name set for inns (thanks to `Hikitsune-Red, for his pull request`_):

  - `inns.cfg`;

  - updated the docs to include the new set examples.

.. _`Hikitsune-Red, for his pull request`: https://github.com/LukeMS/lua-namegen/pull/1

1.1.0
------
* Added books, potions and towns name sets:

  - `towns.cfg` is a copy of Mingos and Jice town name sets for libtcod's namegen;

  - `books.cfg` and `potions.cfg` were based on common roguelike names for unidentified items.

1.0.1
------

* Fixed a critical error that prevented the data files (.cfg, .index) from being loaded at all while calling the library from outside of its own directory.

* Made a doc generator to provide sphynx-like basic `literalinclude` (github don't support it)


Example of generated names
===========================

  - `Books`_

  - `Creatures`_

  - `Potions`_

  - `Towns`_

  - `Inns`_


Below are examples of generated names for each of the sets packed with LuaNameGen:



Books
--------

"books"
********

.. code-block:: lua

   "black", "blue", "brown", "charred brown", "compact gray", "compact orange", "compact slender black", "compact tattered orange", "compact worn orange", "gilted brown", "gilted green", "green", "heavy decorated white", "heavy tattered orange", "huge brown", "iron-bound yellow", "large embroidered black", "leather green", "mangled gray", "orange", "purple", "red", "small blue", "thick dusty white", "thick yellow", "tiny red", "tiny yellow", "used green", "used white", "white" 


Creatures
------------

"aasimar female"
*****************

.. code-block:: lua

   "Adrasteleth", "Ansameth", "Ar-valnor", "Aret", "Arken", "Daen", "Daeth", "Drinma", "Imesinoe", "Jal-atar", "Jaljena", "Jasarmeth", "Kalareth", "Kaljena", "Masah", "Nier", "Niereth", "Nieth", "Niramour", "Nivina", "Onalla", "Palken", "Ral-talar", "Sardareleth", "Tarma", "Valdorel", "Valdoreleth", "Valnares", "Valsah", "Varaleth" 


"aasimar male"
***************

.. code-block:: lua

   "Adanal", "Amaranth", "Ar-valon", "Aradal", "Belal", "Cernan", "Cerran", "Ilat", "Jalrant", "Kaladathar", "Kalwier", "Klaronas", "Mauar", "Maunan", "Oathas", "Paath", "Paldril", "Ral-raman", "Ravanathal", "Sar-palad", "Sardanat", "Talanath", "Talonath", "Tarnan", "Tuath", "Tural", "Tutin", "Valnarathas", "Valnorathal", "Vardaral" 


"catfolk female"
*****************

.. code-block:: lua

   "Dumihr", "Dusash", "Duslif", "Holina", "Homiah", "Hoslif", "Jilirri", "Jisharr", "Jishim", "Jiyi", "Lithlahi", "Lithyera", "Maulyana", "Meerline", "Miaumihr", "Mihrsharr", "Milaha", "Misfee", "Saflahe", "Safyeri", "Sashlyara", "Sfeelyani", "Sheerlirre", "Sheerlithi", "Sheeyi", "Siphemau", "Sipheyeri", "Siythlirri", "Tilini", "Tiyera" 


"catfolk male"
***************

.. code-block:: lua

   "Dreran", "Dreruth", "Dreshah", "Ferswish", "Gerlyau", "Germiau", "Gerslif", "Lirrmau", "Lirrwan", "Maumew", "Maumiu", "Miauserr", "Mirrlirr", "Nykmiu", "Nykshee", "Nykus", "Safgar", "Sashgar", "Sfeesiyth", "Shahsash", "Sharrmeer", "Sharrserr", "Sheermau", "Slifshim", "Syausash", "Syaushim", "Zithmihr", "Zithpurrh", "Zithshau", "Zithtan" 


"dragon female"
****************

.. code-block:: lua

   "Adastralagonis", "Adastramanthysa", "Adrazzemalis", "Andracalchaxis", "Archozuthraxis", "Atrazzebraxis", "Brimacalchaxis", "Cadranadralix", "Chrysonaluxis", "Chrysovoraxis", "Glaucalchaxis", "Heliophylaxis", "Huromanthysa", "Hurovoraxis", "Jalanmordaxis", "Jalanvoraxis", "Kralkavoraxis", "Majurizzemalis", "Ouromalaxis", "Phrixumandrossa", "Pyranaluxis", "Rhadaneriaxis", "Sarcuzzebraxis", "Sardacalchaxis", "Sidereomordaxis", "Sidereovorunga", "Tchalcedomandrossa", "Tchazarlagonis", "Tchazarmordaxis", "Vramalaxis" 


"dragon male"
**************

.. code-block:: lua

   "Abrabazius", "Ancazzemal", "Atramalax", "Beruvorax", "Bhakricalchax", "Bramalax", "Brimacalchax", "Cadracordax", "Chroxenor", "Chrysolagon", "Heliobradax", "Jazrabradax", "Jurganalux", "Lazulozuthrax", "Majuribazius", "Malachobazius", "Phrixuvorung", "Porphyrocalchax", "Porphyromandros", "Pyraneriax", "Pyraphylax", "Rhadalagon", "Sarcucordax", "Sarcuneriax", "Sarcuvorax", "Sardanadral", "Sidereophylax", "Sulchruphylax", "Tchalcedolagon", "Trochocordax" 


"drow female"
**************

.. code-block:: lua

   "Balsekth", "Burvilistra", "Colthalistra", "Dulmyrdeil", "Dulmyrvra", "Dulrhaira", "Dulthalis", "Dulysvia", "Durnildril", "Enothvra", "Erilra", "Ermyran", "Gonlya", "Ilorgvril", "Jegteltra", "Jendorniss", "Jysonlavil", "Kilna", "Lilnevia", "Lilvekira", "Maboria", "Mazmyrth", "Molpelith", "Molsabra", "Molthaltra", "Nothpeliln", "Ulsunbra", "Voira", "Voothiln", "Vosullevlin" 


"drow male"
************

.. code-block:: lua

   "Arred", "Chorlim", "Divsoluld", "Doryolild", "Dromryild", "Dulsinnid", "Durtorvid", "Eilorgald", "Ernourn", "Ernoxird", "Fipelul", "Immyrurn", "Imyelul", "Inssabvir", "Istnelvim", "Jernelvid", "Jervrileld", "Kaornid", "Lilald", "Lilrelurn", "Lulcaid", "Mazreluld", "Mirorgvim", "Nortulird", "Noruld", "Nothvekid", "Nothyolralim", "Olvilnil", "Syryeld", "Zvriler" 


"dwarf female"
***************

.. code-block:: lua

   "Anvara", "Arra", "Bylthiel", "Danden", "Deba", "Dona", "Fretala", "Futha", "Gadi", "Garyn", "Gimca", "Hema", "Hirinka", "Hralna", "Kathsyl", "Kilta", "Kituna", "Lasryn", "Ligret", "Maba", "Miali", "Olina", "Relov", "Reniess", "Rilinda", "Ritu", "Sita", "Thogra", "Thondy", "Yenev" 


"dwarf female 2"
*****************

.. code-block:: lua

   "Ballind", "Broddis", "Brunis", "Daga", "Darith", "Dorhild", "Dormnis", "Dralrun", "Drimdis", "Fromrith", "Gonddis", "Gondvis", "Gordbis", "Gordhild", "Gradlis", "Grimda", "Grimis", "Gurdis", "Horddis", "Hornga", "Hrais", "Norddis", "Skanddis", "Sundna", "Thranis", "Throda", "Throlda", "Thrordis", "Thrulis", "Thundis" 


"dwarf male"
*************

.. code-block:: lua

   "Bifur", "Biril", "Bonthur", "Danbur", "Darethog", "Darrimm", "Dein", "Duerran", "Duerthur", "Duerulf", "Duervim", "Faril", "Fibroir", "Galvri", "Gimin", "Gwarri", "Hargurn", "Kiur", "Lothur", "Ori", "Renden", "Tadur", "Taur", "Telrimm", "Thoden", "Thoni", "Torun", "Ummun", "Vonin", "Vonrimm" 


"dwarf male 2"
***************

.. code-block:: lua

   "Bordnir", "Bornbor", "Bornlin", "Brimin", "Brimnir", "Brokkri", "Bromor", "Burlli", "Dolgvor", "Dorin", "Dormvor", "Dralin", "Fromli", "Gimrur", "Gondir", "Gordrok", "Gordvi", "Gradror", "Guldvir", "Gundnir", "Hornror", "Norbor", "Nordrok", "Norrin", "Skandnir", "Skondvor", "Strombor", "Sundror", "Thornror", "Throlin" 


"dwarf surname"
****************

.. code-block:: lua

   "Bearcleaver", "Bearstriker", "Bloodspear", "Dragonripper", "Ettinsmasher", "Fairaxe", "Foe-Grappler", "Foeboxer", "Gemminer", "Gnome-Grappler", "Goblinbasher", "Goldfoot", "Goldsmith", "Greychest", "Greysword", "Ironfoot", "Kobold-Strangler", "Koboldslayer", "Mithrilbender", "Oakshield", "Ogre-Strangler", "Silvershield", "Spiderslasher", "Steelsmith", "Stonecutter", "Strongfoot", "Trollmauler", "Wyvern-Garrotter", "Wyvernbutcher", "Wyverncutter" 


"elf female"
*************

.. code-block:: lua

   "Alais", "Alea", "Bellaluna", "Braerindra", "Chandrelle", "Cyithrel", "Daratrine", "Darunia", "Delshandra", "Eirika", "Elanil", "Eloimaya", "Gweyr", "Ilmadia", "Keishara", "Kethryllia", "Liluth", "Lura", "Lyndis", "Lyre", "Morgwais", "Nephenee", "Phelorna", "Pyria", "Rathiain", "Shadowmoon", "Shandalar", "Sheedra", "Tsarra", "Urmicca" 


"elf female 2"
***************

.. code-block:: lua

   "Aegthelebmir", "Aerthaelerwen", "Aerthaelthalwen", "Aethraelerrian", "Anrimevwen", "Arsareliel", "Caelrelolrian", "Calireviel", "Carmarthalrien", "Celrinaliel", "Cirninaniel", "Clarinolriel", "Earmaegemroël", "Elbrinelsil", "Elthlitheswë", "Erimaswen", "Erlrilirel", "Ermaranwë", "Estloreleth", "Farmithalriel", "Farnithenmir", "Feanthalthonrian", "Findranthonmir", "Findsaresmir", "Galrinthonian", "Gannitherrian", "Gilralthonwë", "Ithmindadloth", "Laeglitharrial", "Laegsaeriledel" 


"elf male"
***********

.. code-block:: lua

   "Aimon", "Alabyran", "Almon", "Aywin", "Bellas", "Connak", "Dakath", "Ettrian", "Hagwin", "Iliphar", "Ilrune", "Jorildyn", "Keletheryl", "Kendel", "Khatar", "Khidell", "Lhoris", "Malon", "Melandrach", "Myriil", "Pleufan", "Samblar", "Shaundyl", "Taegen", "Theodred", "Triandal", "Vaalyun", "Vander", "Vulmon", "Xhalth" 


"elf male 2"
*************

.. code-block:: lua

   "Aegsilerrod", "Aethlorallin", "Aethraelamnar", "Aethseldelnar", "Belmitholdil", "Caelsaeremrior", "Caelsaerthaldan", "Caerlithirrod", "Caerrindesros", "Calimilorn", "Calrinerdir", "Cellaredorn", "Celmithanros", "Earthaeramion", "Elbnithinrond", "Elrilirion", "Elsarerdil", "Eolmelandel", "Erimirfal", "Eristindel", "Faersilinorn", "Findninevion", "Findnithamdel", "Findthaleslad", "Galinolrior", "Gelseldenion", "Ithmelalthir", "Ithserevlad", "Laegranaslin", "Lendtherirdan" 


"fetchling female"
*******************

.. code-block:: lua

   "Drevoha", "Ecotel", "Eheter", "Hulohir", "Ikadolo", "Ikecutam", "Ikuculin", "Ilerac", "Jejuti", "Jolurac", "Mukurat", "Oronora", "Qitomeh", "Qraholim", "Ravoh", "Rede", "Rode", "Siten", "Suseh", "Trigal", "Ucenoma", "Ucilolah", "Ucosoha", "Usohomal", "Utecucil", "Utigi", "Yerum", "Yuci", "Zavotec", "Zovi" 


"fetchling male"
*****************

.. code-block:: lua

   "Bridu", "Brusol", "Drasot", "Ecotim", "Ehozon", "Graju", "Ikadu", "Iliki", "Jajoh", "Jizu", "Joko", "Natol", "Oravur", "Oreho", "Oruju", "Qrera", "Trame", "Treci", "Treja", "Trovi", "Truso", "Ucoku", "Ugemu", "Uguket", "Utezu", "Uvuho", "Yejoh", "Yiko", "Zese", "Zesuc" 


"giant female"
***************

.. code-block:: lua

   "Baod-Daoh", "Baod-Doh", "Bulimih", "Daoh-Ig", "Doh-Mugh", "FahEghinuh", "Ghadrei", "Ghadtih", "Ghat-Daoh", "Gireekheedoh", "Hahsuthrei", "Haoghfah", "Khanfah", "LahFeehmburi", "MihGiree", "MihOb", "MihOugh", "MihWuh", "Ouh-Doh", "Rei-Tebrahoo", "Rei-Thom", "ReiChah", "ReiMehsuth", "Rifoonarootih", "Shul-Mih", "Soh-Nham", "Tih-Shehi", "Tuhlighadsoh", "Tuhlimughsoh", "Ushrahoodaoh" 


"giant male"
*************

.. code-block:: lua

   "Bohr", "Bul-Yeeh", "Ehm-Shom", "Ghatrifoo", "Ghee", "Ghish", "Goush-Faogh", "Gunri", "Hoo", "Hoo-Heh", "Hooshehi", "Khankham", "Khaz", "Lugh", "Moghquagi", "Mouh", "Nham", "Peh-Yaum", "Pogh", "Puh", "Rhoo-Shom", "Shlo", "Suhi-Meh", "Thom", "Tuhli", "Ub-Ahg", "Ubghat", "Wah", "Yaum-Loghkhaz", "Zhamchah" 


"gnome female"
***************

.. code-block:: lua

   "Bilbeefonk", "Billeklinkle", "Bimrgo", "Bipflonk", "Bipsizz", "Cargus", "Dinkulo", "Ditink", "Dosizz", "Filble", "Filgus", "Gynndomink", "Juladink", "Katdomink", "Ketris", "Klofizzy", "Liskink", "Lokeefizzy", "Lymtink", "Lyssfizzy", "Lysskyago", "Merdiwack", "Mitthinkle", "Nittlebik", "Talkink", "Tallinkey", "Tannus", "Thinbythin", "Tilkitinkle", "Tindinkey" 


"gnome male"
*************

.. code-block:: lua

   "Babimac", "Balibik", "Bawack", "Bimleeble", "Bimliarn", "Binkflonk", "Binwick", "Bolink", "Bonkbus", "Bonleble", "Burtink", "Dinkbitank", "Dobeeble", "Dodibrick", "Donkleedink", "Fenklink", "Fenlflonk", "Filbik", "Filgo", "Finflonk", "Finkvash", "Gelklink", "Gelsizz", "Hinbmink", "Hinklosizz", "Laflink", "Nitkeeklonk", "Tenlink", "Tockawick", "Tovash" 


"gnome surname"
****************

.. code-block:: lua

   "Acerpipe", "Blackbus", "Castfuse", "Castspinner", "Castspring", "Clickgear", "Clicksteel", "Draxlespindle", "Gearwhistle", "Gearwizzle", "Overgear", "Porterfuzz", "Puddlepipe", "Sadbonk", "Shinenozzle", "Shinepipe", "Shinespinner", "Shortpipe", "Spannerblast", "Sparkfizzle", "Sparkspanner", "Sparksprocket", "Stormgrinder", "Stormtorque", "Stormwizzle", "Thistleblast", "Thistlebus", "Thistlegrinder", "Thistlenozzle", "Thistlepipe" 


"goblin female"
****************

.. code-block:: lua

   "Akghy", "Arkghakah", "Bilgyipee", "Blidgah", "Bugghy", "Chutogghy", "Dokhay", "Drikrakgah", "Drubkrige", "Fluge", "Glaggaday", "Glagya", "Gnaty", "Graty", "Kakghy", "Kavee", "Lukay", "Mizya", "Mubay", "Mubzatee", "Naggah", "Nikkghy", "Nogge", "Nure", "Ragya", "Slogya", "Sniky", "Sogay", "Zity", "Zobghy" 


"goblin male"
**************

.. code-block:: lua

   "Blidgah", "Blotbolg", "Bolgadz", "Bolgsnitnikk", "Bot", "Chunag", "Drizark", "Gazbilg", "Ghaklikk", "Ghorirk", "Glagrag", "Glakkak", "Glakus", "Glatkak", "Gloksog", "Kriggag", "Nazflug", "Niggat", "Rotadz", "Rotgak", "Shukrok", "Slogark", "Snignukk", "Snitshuk", "Togbilg", "Yaggbolg", "Zatgnat", "Zatspik", "Zizblig", "Zobsna" 


"half-demon female"
********************

.. code-block:: lua

   "Aagnalu", "Alurnalu", "Arakskiu", "Draanzihyl", "Idruxhiu", "Jhaaldiu", "Jidija", "Jiulihyl", "Jiuzihyl", "Kaazsula", "Mulkjiul", "Mulklin", "Nidija", "Nulxhiu", "Rukdiu", "Saaggiu", "Saagzihyl", "Urzlihyl", "Urzzihyl", "Urzziu", "Uznidizil", "Virndiu", "Virngiu", "Virnrhyl", "Virnzihyl", "Virnziu", "Vlaajanil", "Vlagdiu", "Vrazgiu", "Vulkgiu" 


"half-demon male"
******************

.. code-block:: lua

   "Azikruzuk", "Azuvik", "Brallank", "Bruhlurug", "Draanlurr", "Draanlurug", "Drulgsul", "Jhaalundak", "Jurglurr", "Jurzbru", "Karglurr", "Krauruzuk", "Krivnal", "Luridrul", "Lurilurr", "Nauxulg", "Ninjdrul", "Ranaguvik", "Urzarag", "Utilurr", "Utinal", "Utixulg", "Uznidsul", "Uznidundak", "Virnundak", "Vluklun", "Vrazbru", "Xidsuruk", "Zauvinu", "Zauvlank" 


"halfling female"
******************

.. code-block:: lua

   "Allison", "Amanda", "Amber", "Berenga", "Bertha", "Caitlin", "Chrodechildis", "Darby", "Emma", "Engelberga", "Fatima", "Kaitlyn", "Luitgarde", "Madison", "Marcatrude", "Marigold", "Mary", "Moschia", "Myrna", "Myrtle", "Natalie", "Prima", "Rotrud", "Rotrudis", "Saffron", "Scarlet", "Selina", "Shelby", "Tasha", "Theutberga" 


"halfling female 2"
********************

.. code-block:: lua

   "Adice", "Adily", "Adra", "Adria", "Alba", "Amba", "Banda", "Brama", "Bramia", "Bramwisa", "Durla", "Durlily", "Erna", "Fulbia", "Halda", "Hama", "Hoda", "Hodina", "Ivia", "Markily", "Munga", "Oda", "Otha", "Sabina", "Samia", "Sega", "Tobice", "Wiga", "Wydia", "Wydina" 


"halfling male"
****************

.. code-block:: lua

   "Aega", "Arnoul", "Balbo", "Bero", "Bertin", "Bilbo", "Blanco", "Drogon", "Erard", "Faro", "Fastred", "Fredegar", "Giseler", "Guntram", "Heribert", "Hildibrand", "Madoc", "Majorian", "Marachar", "Mauger", "Melampus", "Merimac", "Rathar", "Sadoc", "Taurin", "Thankmar", "Togo", "Unroch", "Waltgaud", "Willibrord" 


"halfling male 2"
******************

.. code-block:: lua

   "Ado", "Ailard", "Ailwise", "Albo", "Albwise", "Bardfast", "Bardo", "Bildert", "Blancald", "Blanco", "Boffald", "Drogert", "Drogo", "Durlo", "Emmald", "Erdard", "Erdo", "Falco", "Ferdard", "Ferdold", "Gamo", "Hamo", "Hamold", "Hugert", "Ivwise", "Markfast", "Marko", "Otho", "Serlard", "Wigold" 


"halfling surname"
*******************

.. code-block:: lua

   "Banks", "Barrowes", "Boffin", "Bophin", "Bramblethorn", "Brandagamba", "Brown", "Brownlock", "Chubb", "Cotton", "Diggle", "Fairbairn", "Gawkroger", "Gluttonbelly", "Greenhill", "Harfoot", "Hayward", "Hlothran", "Hornwood", "Leafwalker", "Longfoot", "Noakes", "Oldbuck", "Puddifoot", "Sandheaver", "Sandyman", "Took-Brandybuck", "Underfoot", "Underlake", "Wanderfoot" 


"hobgoblin female"
*******************

.. code-block:: lua

   "Afrata", "Beyekam", "Beylata", "Ceytarak", "Darate", "Dirleta", "Dirtaruk", "Esrima", "Fetdora", "Kolgha", "Kurde", "Kurhe", "Kuruke", "Malghoran", "Mevleta", "Mevletem", "Poldletan", "Poldrama", "Polduki", "Roldluka", "Saltema", "Tetma", "Totma", "Tottarim", "Turgikum", "Turglater", "Turgrata", "Turguko", "Utrata", "Zoldhora" 


"hobgoblin male"
*****************

.. code-block:: lua

   "Akhi", "Akrim", "Dorlut", "Durat", "Durluk", "Fethar", "Fethi", "Haat", "Harim", "Kethluk", "Kethlut", "Kolgot", "Kurung", "Okhar", "Poldok", "Poldrim", "Roldhi", "Roldtar", "Rolduk", "Roldung", "Saltlut", "Tetrot", "Tettar", "Totat", "Totlut", "Turghar", "Uthar", "Zoldat", "Zoldrot", "Zoldut" 


"human female"
***************

.. code-block:: lua

   "Aelfsig", "Aethelmaer", "Aethelraed", "Bealdthorne", "Beorhtric", "Cwenburg", "Cynein", "Eirudo", "Elida", "Gruistae", "Heathusige", "Helmsige", "Hildsige", "Islynn", "Isothra", "Ivithra", "Kerenza", "Leofmaer", "Leofor", "Lowenna", "Mayetta", "Mundkettil", "Nerama", "Osgrim", "Salenor", "Salywyn", "Voroth", "Winewaru", "Zubuwyn", "Zubylaith" 


"human male"
*************

.. code-block:: lua

   "Aelfkettil", "Aenesric", "Balrach", "Bardahard", "Bregudeor", "Breguson", "Cenarm", "Censige", "Chalrochak", "Chaltorek", "Cynebeorht", "Delmkor", "Deorgar", "Deorweald", "Ervan", "Garsige", "Garweard", "Godbeorht", "Godweard", "Herebrand", "Hrofweard", "Instan", "Leodhere", "Sigeleof", "Sigeweard", "Thurheard", "Winegar", "Winewulf", "Wulfheard", "Zlen" 


"human surname"
****************

.. code-block:: lua

   "'Frenzied' Lortavan", "'Haggard' Stanton", "'Hare' Seven-Shaper", "'Pratt' Clayden", "'Small' Summer", "'Stout' Spalding", "Bjoornsdottir", "Brodie", "Brown", "Bunce", "Colenso", "Curicinnius", "Doom-Foot", "Ebonhand", "Finch", "Kjaldssen", "Lencreinace", "Lilly", "Lincoln", "Locippe", "Midal", "Mojisversdottir", "Newbury", "Padley", "Plaelius", "Plenceia", "Secret-Drums", "Stanton", "Ulfransson", "Wavrustiris" 


"ifrit female"
***************

.. code-block:: lua

   "Atwa", "Edu", "Erya", "Fadri", "Fetwi", "Fudru", "Fulhe", "Fullulyu", "Garlun", "Gatwa", "Gethis", "Gula", "Haen", "Hanu", "Hathethi", "Hima", "Himerhu", "Hira", "Hirya", "Hitwa", "Iriswirh", "Irranthis", "Itin", "Lary", "Ludre", "Man", "Satwarhe", "Wilwu", "Zetyi", "Zunu" 


"ifrit male"
*************

.. code-block:: lua

   "Baviq", "Bukut", "Daci", "Dajad", "Dame", "Egel", "Galum", "Gare", "Giviq", "Jicut", "Kele", "Kivaj", "Maci", "Maluh", "Marut", "Mecun", "Mirut", "Takuh", "Tenim", "Tevel", "Tikin", "Tiqa", "Uvin", "Vakin", "Vila", "Vineh", "Virat", "Vugam", "Vukel", "Vure" 


"infernal 1"
*************

.. code-block:: lua

   "Baphorgya", "Breilghu", "Chruarghu", "Chrulinal", "Drauurshai", "Dromuizbaph", "Garu-lunee", "Garuzabaz", "Ghauvekraa", "Ghurugarl", "Glau-vivuul", "Gle-ovbaal", "Gleiyrezu", "Gre-azrez", "Gura-jeglau", "Hzivassu", "Muzojhez", "Pazulghu", "Pazzarezu", "Razavcha", "Rez-elyaa", "Saa-zetzau", "Saavathu", "Sau-ivzu", "Shu-evidrau", "Ssuvebael", "Szuluyrez", "Tzaurabaz", "Utuovtzau", "Zuavziel" 


"infernal 2"
*************

.. code-block:: lua

   "Aigelboaj", "Aigoyshub", "Algirglab", "Blog-aysag", "Bulgayjulb", "Drujvibarg", "Felgvudergh", "Ghadvusug", "Glaaglonalb", "Glaagurjub", "Hegazleegh", "Hrud-voboaj", "Hrudlekolg", "Krolgjinog", "Magviiub", "Magzudergh", "Morguyzub", "Naag-uyurb", "Nauglahaag", "Nuglushub", "Nugyiigg", "Nyogzaghad", "Shubevdrog", "Szugvinaug", "Trobuvkwarg", "Xubvithog", "Yebvaalg", "Yeeg-radregh", "Zugjunulb", "Zugvoogg" 


"infernal 3"
*************

.. code-block:: lua

   "Ashevgaur", "Aztratlizit", "Bliklaszut", "Boak-ezazt", "Boakuzhrek", "Boakuzsoth", "Brax-ursark", "Dunjaoch", "Duumolblik", "Gaanozduum", "Gaurilchon", "Gorivinax", "Hraxlosark", "Hrekuyner", "Khorjurolk", "Kireyter", "Mat-yidraum", "Met-ajash", "Mothejgoth", "Namruuzt", "Nerirhoth", "Nythovruaak", "Sarklaazt", "Sarkujszut", "Sotyaboak", "Sutovralk", "Terejloch", "Thakuvthalk", "Utukurgith", "Uztrulok" 


"kobold female"
****************

.. code-block:: lua

   "Ari", "Aslemko", "Asral", "Degees", "Degra", "Ekara", "Gahoo", "Gurli", "Gurzok", "Harkro", "Ia", "Igra", "Ligu", "Matroso", "Nekri", "Noske", "Pogar", "Pokrora", "Potroil", "Pozra", "Rasuskas", "Rolsus", "Sasoo", "Sizlem", "Sokehtro", "Sokzra", "Tolkru", "Tollemkoo", "Tollire", "Zasi" 


"kobold male"
**************

.. code-block:: lua

   "Crurad", "Dhelal", "Dhelzor", "Dhimaholk", "Drazax", "Eaalp", "Gakni", "Getghe", "Ghenuld", "Ghexas", "Ilnri", "Ilxas", "Jaod", "Makme", "Molnesk", "Orod", "Orze", "Qeerk", "Qrelra", "Rusxas", "Ruszore", "Vadnri", "Vemerk", "Vipir", "Zalxasdoo", "Zalzin", "Zeeark", "Zeedoo", "Zoir", "Zorzad" 


"ogre female"
**************

.. code-block:: lua

   "Dugshrufy", "Durshglugay", "Duzdrubgah", "Ghulghakhgah", "Gradbarshghy", "Gradyuggah", "Grobkurya", "Grokgharah", "Grukurghay", "Grulobbgah", "Gruzmakhgah", "Hurslubay", "Kulkzuggah", "Lumkulkya", "Luzfugghy", "Luzkaiy", "Molggharay", "Molghrungah", "Muddrokay", "Mudlorgghy", "Mulobbkaighy", "Murkshargy", "Muzdghakhya", "Obbghashgah", "Rolbshurya", "Shrufmuzday", "Slubdruggah", "Sludlukhgah", "Snadthurkah", "Thulkgruya" 


"ogre male"
************

.. code-block:: lua

   "Bogdug", "Burzgruz", "Drokgrumf", "Drubdushhurg", "Duzyur", "Fuglush", "Gholgom", "Gludduz", "Gludlug", "Grashdrok", "Grufulg", "Grulsnog", "Grumthrag", "Gruzmud", "Guhlkaislug", "Guhlmakh", "Kugtrug", "Kurlug", "Lorgklobgrut", "Lumklob", "Lurzghash", "Makhgruk", "Nakhkrodurgh", "Nakhnarg", "Obbhrung", "Rolbgrum", "Shargkurmug", "Sludghakhslub", "Urdghar", "Zuglush" 


"orc female"
*************

.. code-block:: lua

   "Bashat", "Basht", "Bolar", "Bulfol", "Bum", "Burzob", "Burzraz", "Dulug", "Ghak", "Globh", "Gonk", "Grat", "Gul", "Lambug", "Lamut", "Mazsha", "Mogak", "Morn", "Morza", "Murbraz", "Murmalah", "Orbugol", "Rogbut", "Shagdub", "Shelur", "Ulumt", "Umog", "Uroga", "Ushat", "Volrog" 


"orc female 2"
***************

.. code-block:: lua

   "Bakhskaray", "Bruzkragghy", "Dakkolgay", "Dargtrogay", "Gashhrogya", "Gashlakhy", "Ghazgrubgrudah", "Gokhhrugay", "Gokhkrudbrogy", "Grathlufya", "Grazskulgay", "Grubdargy", "Gudsnubya", "Hratoggah", "Hruggrashay", "Khagglufghy", "Kragluby", "Lubgashya", "Lukmolkgah", "Rorgslurghy", "Rotagghy", "Rudgnubay", "Rugzogya", "Shazgasholgah", "Snurrbragya", "Sodrugghy", "Thakbashgah", "Troglakhya", "Umshhakky", "Yobgutgah" 


"orc male"
***********

.. code-block:: lua

   "Bashrz", "Bogakh", "Brokrkub", "Bugbumol", "Buomaugh", "Ghamrlorz", "Gluh", "Grusur", "Gunaakt", "Kurdburz", "Lurodum", "Malz", "Mashgob", "Mugarod", "Mulunok", "Muzorz", "Nagrutto", "Olug", "Olurgash", "Owkbanok", "Shobrkul", "Shumborz", "Slapdud", "Urul", "Ushnong", "Ushnurz", "Yadba", "Yargron", "Yasog", "Zugorim" 


"orc male 2"
*************

.. code-block:: lua

   "Baglub", "Gashhrog", "Glurlub", "Gnubglaz", "Gnubskar", "Grazmuz", "Grubdag", "Grubgrath", "Hagbad", "Hagbag", "Kharglaz", "Lashbrag", "Lashstulg", "Lobbag", "Lobshaz", "Lobsnorl", "Lufdrab", "Lufnar", "Mukyob", "Narskulg", "Olgrag", "Rashgraz", "Rorgrud", "Rudogg", "Skaroggshaz", "Snubstulg", "Snurrshad", "Thakhrug", "Uthgrath", "Yashdarg" 


"orc surname"
**************

.. code-block:: lua

   "Aglhel", "Atugdu", "Atuwog", "Basrn", "Batrak", "Bogath", "Bogugk", "Brou", "Bugpok", "Burbrzog", "Burgul", "Burorz", "Draharzol", "Dullump", "Gargham", "Gasrak", "Gluul", "Gorum", "Gurwog", "Khazbul", "Lagdra", "Lumbl", "Malgdum", "Marh", "Maroar", "Ogduborgob", "Olorzgub", "Shulharzol", "Trairbag", "Urgaharz" 


"oread female"
***************

.. code-block:: lua

   "Asy", "Bhese", "Buti", "Danisi", "Dehshacha", "Dehtha", "Hilla", "Hilnahise", "Hinlarrin", "Ine", "Irye", "Nannynhe", "Nuannhe", "Pafa", "Pimne", "Pohle", "Pohnyu", "Raseniya", "Rece", "Rhomshude", "Rhomsy", "Riyin", "Rohthodha", "Tolnish", "Tuha", "Tura", "Vifhes", "Vosmalar", "Vunhishu", "Vushe" 


"oread male"
*************

.. code-block:: lua

   "Ahvu", "Anmallus", "Bondatmom", "Bontor", "Bontormu", "Dantorrin", "Gundurhat", "Jeydurnom", "Lordanlen", "Lorhutmus", "Menha", "Menhutlom", "Monvotdon", "Nudtordur", "Nynomdur", "Pyllun", "Pylmon", "Pylrinlur", "Rotys", "Rundanfam", "Rundusvros", "Runnatdom", "Runrmu", "Sarlenlun", "Solhatys", "Urdum", "Vydat", "Vylurhut", "Vyrud", "Ylmumem" 


"ratfolk female"
*****************

.. code-block:: lua

   "Ageekiz", "Binc", "Driv", "Gleev", "Gneldeen", "Hivin", "Icrind", "Ikeesnik", "Ikelgeek", "Iteeh", "Iteen", "Jar", "Jelnig", "Jih", "Keec", "Kreldet", "Peeq", "Pinl", "Preheek", "Relh", "Rinden", "Sceln", "Skelk", "Stelvin", "Stesneek", "Tineed", "Tis", "Velneek", "Vins", "Zrit" 


"ratfolk male"
***************

.. code-block:: lua

   "Amel", "Branz", "Djeetir", "Dreel", "Geg", "Gleez", "Gnimeeq", "Honik", "Hotch", "Icreskreek", "Ikil", "Itinhing", "Knand", "Nen", "Nik", "Pang", "Peris", "Peter", "Pretch", "Rimvim", "Rinmev", "Skind", "Sreqink", "Stel", "Tinansins", "Tinez", "Vreenez", "Vrir", "Zehnih", "Zreec" 


"sprite female 1"
******************

.. code-block:: lua

   "Dexefer", "Flaxafer", "Flaximer", "Flaxirel", "Flissamer", "Flissinel", "Flixarel", "Flixirel", "Friskifer", "Frissanel", "Glanefer", "Glanimer", "Glissirel", "Gossinel", "Heximer", "Lissamer", "Minafer", "Raffirel", "Resserel", "Riffarel", "Shimafer", "Shimenti", "Tinkimer", "Tristirel", "Twissanel", "Twissinel", "Twixasti", "Weftanel", "Weskasti", "Weskenti" 


"sprite female 2"
******************

.. code-block:: lua

   "Brismee", "Crylnyx", "Crylynx", "Elsitiss", "Eskdee", "Eskriss", "Frimikiss", "Frimila", "Frimisa", "Gannyx", "Ganynx", "Halkiss", "Helsa", "Histriss", "Histsa", "Iphilnyx", "Ispeltiss", "Jostla", "Lirrariss", "Mistlekiss", "Mistlenyx", "Opalla", "Orifdee", "Sarmliss", "Sprinliss", "Stithsa", "Tansidee", "Tirramee", "Zandoniss", "Zandosa" 


"sprite male 1"
****************

.. code-block:: lua

   "Dexendo", "Flaxaron", "Flaxasto", "Flixaron", "Flixeroll", "Flixeron", "Fossaroll", "Fossaron", "Gessaroll", "Gessendo", "Glaxaldo", "Glaxallo", "Glaxendo", "Glimallo", "Glimeroll", "Glissallo", "Gossaron", "Hexaroll", "Lissendo", "Minaldo", "Raffando", "Resseron", "Riffando", "Riffesto", "Twilleron", "Twissamo", "Twixallo", "Weftaroll", "Wisparoll", "Wispesto" 


"sprite male 2"
****************

.. code-block:: lua

   "Crylmit", "Elsitross", "Elsizisk", "Emberbik", "Emberzisk", "Ferisbik", "Ganwin", "Glinkbik", "Helmist", "Heltwik", "Histfrell", "Iphilbik", "Iphilmit", "Istlebik", "Jatbrix", "Jatrix", "Jostmit", "Jusbrix", "Lirrabik", "Malitwik", "Minktross", "Mirrazisk", "Oriftross", "Orisfrell", "Oristross", "Oriswin", "Tansibik", "Tirramit", "Trumpzisk", "Zandokin" 


"sylph female"
***************

.. code-block:: lua

   "Anuju", "Caadju", "Ceammi", "Cenalmi", "Cisenmu", "Cuzadife", "Dadenidi", "Damul", "Fakadsa", "Fusedfamu", "Gaeduna", "Ganunded", "Gaudju", "Haansa", "Heldulvu", "Helfinsi", "Helkelsa", "Hifalvu", "Huzdedkada", "Idalfi", "Iinkima", "Iisvuna", "Laashi", "Sukuda", "Vaazinu", "Vadedfi", "Vawenvu", "Wuad", "Wuine", "Zugelvama" 


"sylph male"
*************

.. code-block:: lua

   "Adan", "Analma", "Cila", "Faduniv", "Feifmi", "Fijid", "Gaven", "Geim", "Gevilin", "Hafalid", "Hemi", "Hezadis", "Huansum", "Iden", "Lased", "Liwen", "Luul", "Mased", "Mimunal", "Muudmun", "Muunam", "Muwingum", "Nifinif", "Niudfil", "Sejid", "Sima", "Ulaash", "Vuadim", "Wavun", "Zudul" 


"tengu female"
***************

.. code-block:: lua

   "Ahta", "Bekka", "Belugh", "Chakzack", "Chakzullee", "Chuk-Qro", "Gaakquz", "Kaakcha", "Krepeegaak", "Oun", "Ounck", "Pinlee", "Pra", "Pragh", "Prichor", "Prizack", "Prizotaa", "Qrekraak", "Qro", "Qrocha", "Qroqekmeck", "Qrozack", "Qrune", "Razul", "Rokzo", "Rukraje", "Taitoair", "Tchi", "Xeeppee", "Xeepyi" 


"tengu male"
*************

.. code-block:: lua

   "Aahtack", "Baayoi", "Beel-Bel", "Beelah", "Biuk-Pee", "Caw", "Chakzul", "Chiukzecroa", "Eenkoa", "Gaa-Pee", "Kaarqoon", "Kraaknemeck", "Kragaak", "Krane", "Krazul", "Peeyi", "Poo-Biuk", "Poo-Gaa", "Pookraah", "Preekaak", "Preekamu", "Prigh", "Pu-Oun", "Qack", "Qraah", "Qrayoi", "Qriu-Pu", "Tchirek", "Xaitee", "Xeepun" 


Potions
----------

"potions"
**********

.. code-block:: lua

   "blubbery light silvery", "bright", "bubbly light green", "clear", "clotted dark turquoise", "clotted dark white", "clotted dark yellow", "clotted light green", "dull", "heavy light gray", "heavy light red", "misty light golden", "oily mercury", "opaque light magenta", "rusty", "shiny", "smelly light magenta", "smelly light mercury", "sparkling light yellow", "sparkling orange", "swirly light orange", "thick light brown", "thick pink", "thick violet", "thin dark cyan", "thin dark golden", "thin dark purple", "translucent light gray", "viscous light violet", "viscous white" 


Towns
--------

"jice towns"
*************

.. code-block:: lua

   "Aelmount", "Barrowash", "Barrowiron", "Beldale", "Crystalbarrow", "Deepdor", "Edgefall", "Fallford", "Glassash", "Golddale", "Goldfall", "Iceshade", "Millcoast", "Moonhill", "Raypond", "Rayshore", "Rockhaven", "Rockmist", "Rockmount", "Shadowiron", "Shadowshore", "Spellfield", "Springcastle", "Springhill", "Stonehaven", "Stonetown", "Summerbridge", "Swyncastle", "Winterlake", "Wintershore" 


"mingos towns"
***************

.. code-block:: lua

   "Alesbank", "Aleswick", "Bellburg", "Bellton", "Browndorf", "Brunsholm", "Camppool", "Crystalmont", "Darkwood", "Dracwood", "Esterbrook Grove", "Fleetley", "Hazeston", "High Mableside", "Ironmoor", "Mareshire", "Marshbrook", "Middle Bellkirk", "Middle Fleetstead", "Old Brightway", "Oxstead", "Purpleham Annex", "Sowsburgh", "Stillburgh", "Watermoor", "Wolfriver", "Woolminster Crossing", "Woolshire", "Worcliff", "Worvale" 


Inns
-------

"inns"
*******

.. code-block:: lua

   "The Babbling Staff", "The Bountiful Chipmunk", "The Cerulean Helmet", "The Crying Tankard", "The Emerald Tiger", "The Fair Giant", "The Flying Wentiko", "The Grey Pine", "The Grey Vixen", "The Grinning Dog", "The Hopping Bobcat", "The Indigo Otter", "The Leaping Mug", "The Low Vixen", "The Maroon Giant", "The Mended Maiden", "The Old Moose", "The Orange Badger", "The Orange Giant", "The Risen Cougar", "The Rolling Vixen", "The Royal Sceptre", "The Running Alerion", "The Silver Staff", "The Sparkling Peasant", "The Tall Wolf", "The Velvet Cask", "The Vile Crown", "The Weeping Tiger", "The Winding Ass" 


