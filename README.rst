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


"aasimar female"
-----------------

.. code-block:: lua

   "Adrasteleth", "Areseth", "Arken", "Atareleth", "Avareseth", "Avlantenth", "Daalla", "Dadrea", "Dasinoe", "Drinramou", "Imesinoe", "Jal-atar", "Jal-varam", "Jaljena", "Jasaner", "Jasarmeth", "Kalares", "Kaljena", "Kalsah", "Kavalel", "Maenth", "Masozi", "Nienth", "Niereth", "Nies", "Nieth", "Nijena", "Nivina", "Onma", "Pal-aman", "Ral-talar", "Ranalen", "Sardareleth", "Sardareth", "Sarma", "Sarnateleth", "Sartyra", "Talasen", "Taldrea", "Talsinoe", "Taltyra", "Taranenth", "Tarma", "Valdoreleth", "Valnoreth", "Vanarel", "Varaleth", "Varaleth", "Vardaret", "Voltareth"

"aasimar male"
---------------

.. code-block:: lua

   "Ar-avar", "Ar-ravan", "Aranas", "Arat", "Aritian", "Arran", "Asanal", "Asanas", "Asarnanth", "Astaral", "Avaran", "Avarathas", "Avralathal", "Belan", "Cerath", "Crongan", "Cronwier", "Cronwier", "Eran", "Ilan", "Jalanathal", "Jalkaranth", "Kalarat", "Kalarathar", "Mauathar", "Maudril", "Maunan", "Oran", "Paanth", "Palamin", "Palorath", "Paral", "Rasanathas", "Samaral", "Samaras", "Sardanat", "Solaranth", "Talamin", "Talanathal", "Talarath", "Talgan", "Tural", "Valdoral", "Valkarathal", "Valnarathas", "Valnorathal", "Valoral", "Var-aman", "Zainan", "Zairan"

"catfolk female"
-----------------

.. code-block:: lua

   "Alirra", "Amiau", "Dusash", "Duslif", "Holina", "Homiah", "Hosheer", "Hoslif", "Hosyau", "Jilirri", "Jilissi", "Jishim", "Jiyi", "Lithlahi", "Lithyera", "Maulyana", "Meerline", "Miaulithi", "Miaumew", "Miaumihr", "Mihrmeeri", "Mihrsharr", "Milaha", "Milaha", "Milissa", "Milyara", "Mimeere", "Mipurrh", "Mirrmeera", "Mirrserr", "Misfee", "Saflahe", "Safsharr", "Safyeri", "Sashlyara", "Sfeelyani", "Sheerlirre", "Sheerlithi", "Sheeyi", "Shimserr", "Shurrlyani", "Shurrsaf", "Siphelahi", "Siphemau", "Sipheyeri", "Siythlirri", "Syaulina", "Tilini", "Timirr", "Tiyera"

"catfolk male"
---------------

.. code-block:: lua

   "Carmau", "Carmew", "Carshah", "Carsharr", "Carshau", "Dremew", "Dreran", "Ferlirr", "Fersaf", "Fershim", "Germau", "Gerslif", "Lithshurr", "Mausyau", "Meershau", "Meershurr", "Mewsheer", "Miahsharr", "Miaupurrh", "Mirrgar", "Mirrshah", "Nykserr", "Nykserr", "Nyksharr", "Nyksiyth", "Nyksiyth", "Purrhlyau", "Purrhsyau", "Purrhus", "Rousharr", "Safus", "Sashus", "Serrshurr", "Sfeemeer", "Shahlyau", "Shahmeer", "Sharrsiyth", "Sheerruth", "Sheerwan", "Sheeshim", "Shimembe", "Shimshah", "Shurrmiau", "Shurrsiyth", "Syausfee", "Syausiyth", "Zithlyau", "Zithmiu", "Zithpurrh", "Zithsaf"

"dragon female"
----------------

.. code-block:: lua

   "Abrazzemalis", "Archovoraxis", "Archozzebraxis", "Atraxenoris", "Baracalchaxis", "Barmanthysa", "Barxenoris", "Berulagonis", "Beruzzebraxis", "Bramordaxis", "Brimalagonis", "Glaumanthysa", "Glaumordaxis", "Glauxenoris", "Harlagonis", "Harxenoris", "Heliophylaxis", "Heliovorunga", "Heliozuthraxis", "Heliozzemalis", "Huromandrossa", "Jalanphylaxis", "Jarzemvorunga", "Jarzemzzebraxis", "Jazrazuthraxis", "Jurgalagonis", "Jurgavoraxis", "Keruxacalchaxis", "Keruxavorunga", "Kralkazuthraxis", "Lazulophylaxis", "Majurizuthraxis", "Melkarmanthysa", "Ouromandrossa", "Peridomordaxis", "Porphyroneriaxis", "Rhadazuthraxis", "Rhodocalchaxis", "Sarcuvorunga", "Sarmordaxis", "Scarvabazia", "Sidereoborossa", "Sulchrubazia", "Sulchrumandrossa", "Tchalcedophylaxis", "Tchazarmandrossa", "Tchazarnaluxis", "Trocholagonis", "Trochomalaxis", "Trochonaluxis"

"dragon male"
--------------

.. code-block:: lua

   "Abramanthys", "Adranalux", "Ancacordax", "Ancacordax", "Andramandros", "Andramordax", "Aragnalux", "Atramanthys", "Baramalax", "Barzuthrax", "Beruboros", "Biamandros", "Biazuthrax", "Braxenor", "Brazuthrax", "Cadrazuthrax", "Chrobradax", "Chroneriax", "Chrysonadral", "Chrysozuthrax", "Harneriax", "Hurocordax", "Hurovorung", "Jarzemboros", "Jarzemmanthys", "Jazrabradax", "Jurgabazius", "Jurganalux", "Keruxaboros", "Keruxaneriax", "Melkarxenor", "Ourocordax", "Ouromanthys", "Ourozzemal", "Porphyrozzemal", "Pyraboros", "Pyracordax", "Pyravorung", "Rhadaphylax", "Rhodobazius", "Sarcumordax", "Sulchrubazius", "Sulchruneriax", "Tchalcedomanthys", "Tchazarphylax", "Vramandros", "Vraneriax", "Zalarmandros", "Zalarzuthrax", "Zerulcalchax"

"drow female"
--------------

.. code-block:: lua

   "Balcilin", "Bersolira", "Bursinith", "Buryelene", "Charsylrin", "Chorruvia", "Coliza", "Colthalth", "Colyolia", "Cysinvia", "Divmarelis", "Divpanth", "Doliza", "Dollelhel", "Dolvaan", "Dolvril", "Driporhel", "Drommyrna", "Dulniss", "Durolgira", "Dursulene", "Ekthalrin", "Ennilis", "Envolis", "Enyshel", "Gullunia", "Imnoil", "Johtenis", "Losith", "Losyolislin", "Lulorgdeil", "Mabsinan", "Mabtelralan", "Mabvolira", "Marra", "Marsusertra", "Maztormth", "Merlenniss", "Mezsoltra", "Mezth", "Mezvana", "Mezvoria", "Molnilith", "Morsabbra", "Norrhaistra", "Norsulvra", "Nothvapeliln", "Olniss", "Ulvilidiln", "Votormiln"

"drow male"
------------

.. code-block:: lua

   "Arverurn", "Aryolnaz", "Bervekurn", "Charyelrinvim", "Chorverrim", "Colrennaz", "Decavim", "Divsussylurn", "Dolvir", "Dorrellim", "Driporviz", "Dritorild", "Dromtornaz", "Drorenvir", "Drosekid", "Dulelriv", "Dulmyrird", "Dultenriv", "Durnaz", "Durolgeld", "Durtelvid", "Eiltenriv", "Ekvekul", "Ekvrilred", "Filivin", "Firenild", "Gulyelvid", "Imlim", "Imsulrim", "Insvilred", "Jegsabred", "Jersulnil", "Kilnould", "Kilthalurn", "Lulvilnil", "Mazrim", "Mazsuneld", "Meznylid", "Mezrenild", "Mirvicrileld", "Molmyrvir", "Molnid", "Nothnonim", "Nothrysinurn", "Nothviculd", "Pharyelnaz", "Zcarid", "Zelul", "Zsolnid", "Zvrilnid"

"dwarf female"
---------------

.. code-block:: lua

   "Ama", "Bial", "Bila", "Bogna", "Bonuda", "Bylthiel", "Dargret", "Dedy", "Denuda", "Duetu", "Dulona", "Duvara", "Dwanuda", "Fariha", "Feridy", "Ferifra", "Filona", "Fraflera", "Frebida", "Freka", "Gemnyl", "Glodeth", "Glody", "Gronuda", "Henden", "Herev", "Janirigg", "Jegna", "Kadomia", "Kazda", "Kilda", "Kilnda", "Kilsi", "Kivara", "Maden", "Medeth", "Metha", "Olaani", "Oya", "Rasma", "Relona", "Renryn", "Rimala", "Rovara", "Sentha", "Taja", "Torkala", "Tyshwyn", "Veta", "Voniess"

"dwarf female 2"
-----------------

.. code-block:: lua

   "Balrith", "Borddis", "Bordrith", "Bornis", "Brimda", "Brimga", "Brimlind", "Broddis", "Bromis", "Burlis", "Burllis", "Darith", "Dromdis", "Dromis", "Durmdis", "Durvis", "Frorrith", "Fundna", "Gimnis", "Glorun", "Gondis", "Gondnis", "Gormbis", "Gormhild", "Gormrun", "Gradhild", "Grimga", "Gurdis", "Gurhild", "Hornbis", "Hornda", "Horndis", "Hornna", "Nabis", "Narun", "Norrun", "Storndis", "Stornis", "Stromvis", "Sturna", "Thorlif", "Thornrun", "Thrais", "Thrarith", "Throllif", "Thrurdis", "Thruris", "Thrurrun", "Thundlis", "Thundrun"

"dwarf male"
-------------

.. code-block:: lua

   "Achar", "Atri", "Atri", "Danvim", "Darbur", "Dari", "Dedir", "Delin", "Dochar", "Donur", "Duevil", "Dunur", "Dwaran", "Emkom", "Fain", "Fari", "Firimm", "Firtag", "Funbil", "Funrin", "Galbin", "Galur", "Gamrimm", "Gamvim", "Gartri", "Gimbil", "Gobil", "Gomran", "Grolin", "Groulf", "Jorni", "Kari", "Kilulf", "Kilvri", "Kotdrom", "Lochar", "Marbin", "Marrimm", "Nalli", "Nugnumri", "Ovi", "Rasdur", "Strodreac", "Tarril", "Therdur", "Thermun", "Thramur", "Vonulf", "Webur", "Werthur"

"dwarf male 2"
---------------

.. code-block:: lua

   "Balin", "Bordin", "Bornnir", "Brimin", "Brimin", "Bromdin", "Dalor", "Dolgir", "Dolglin", "Dolgor", "Dorir", "Dormli", "Dormvir", "Dralir", "Dralnir", "Drimin", "Dromli", "Durin", "Durmin", "Durmror", "Durnror", "Fromri", "Fromri", "Gimir", "Gloir", "Gordli", "Gormror", "Grodir", "Guldri", "Gundri", "Gurrin", "Skandror", "Storndin", "Stornli", "Sturbor", "Sturlri", "Sturrok", "Sundror", "Sundvor", "Thornin", "Thorrin", "Throlin", "Throlin", "Throllin", "Throlvi", "Throlvir", "Throrin", "Throrli", "Thrunir", "Thrurin"

"dwarf surname"
----------------

.. code-block:: lua

   "Bloodfinger", "Bouldercrusher", "Boulderforger", "Bouldersmith", "Bronzeaxe", "Bronzebrand", "Bronzedigger", "Bronzepick", "Coalfist", "Coalheart", "Copperclub", "Coppercutter", "Elf-Battler", "Fairshield", "Gembreaker", "Gianteater", "Giantpuncher", "Giantslayer", "Gnomecrusher", "Goblin-Battler", "Goldbreaker", "Goldfist", "Hammercutter", "Hammerforger", "Hammersmasher", "Hardblade", "Hardhood", "Ironaxe", "Ironhood", "Marblecrusher", "Marblecrusher", "Marblecutter", "Marblesmasher", "Mithrilfoot", "Noblechest", "Noblehood", "Noblemace", "Orcripper", "Orcslasher", "Redhand", "Rockdigger", "Rockfist", "Silverhood", "Silversword", "Steelsmasher", "Stonehand", "Stoneheart", "Thundercutter", "Whitebelly", "Wolf-Garrotter"

"elf female"
-------------

.. code-block:: lua

   "Alais", "Alais", "Alea", "Alea", "Almithara", "Amlaruil", "Arielimnda", "Arielimnda", "Axilya", "Bellaluna", "Bellaluna", "Braerindra", "Caerthynna", "Claire", "Cyithrel", "Deularla", "Elanil", "Elanil", "Elasha", "Elmyra", "Elmyra", "Eloimaya", "Eloimaya", "Esta", "Falenas", "Filauria", "Haera", "Jeardra", "Kasula", "Keishara", "Liluth", "Lyndis", "Lyre", "Nushala", "Nyna", "Phyrra", "Rubrae", "Shadowmoon", "Shandalar", "Shandalar", "Shanyrria", "Sheedra", "Sheedra", "Soliania", "Soliania", "Syndra", "Tsarra", "Urmicca", "Viessa", "Wynnter"

"elf female 2"
---------------

.. code-block:: lua

   "Aelrindadriel", "Aerrindasiel", "Aessaredmir", "Aesseldirriel", "Aesserarrial", "Aesthelirwen", "Anlirelloth", "Ansaerthonedel", "Armindaswë", "Arnirilriel", "Bernitherril", "Calraelalrian", "Celiroliel", "Celmeresriel", "Celrelarriel", "Celrilalwen", "Cirimelril", "Clarninedian", "Crissaranedel", "Cristhaelebien", "Cristhaerelwen", "Elthsareliel", "Eolinoliel", "Eolsilareth", "Erlimolroël", "Erlreleriel", "Erlrilevwen", "Erlseroledel", "Erninebeth", "Faerthelenriel", "Farimthonriel", "Farraelirsil", "Feannithalriel", "Feansarolmir", "Findliremedel", "Findrindanel", "Findsarolrien", "Findseldinroël", "Findthaleneth", "Finistalrial", "Finrilinrien", "Finthaelanwen", "Finthaeraredel", "Gillorerriel", "Ilmlarerroël", "Ithrelersil", "Ithserevwen", "Ithsilmthaleth", "Lendseldoledel", "Lindrindaseth"

"elf male"
-----------

.. code-block:: lua

   "Agandaur", "Agandaur", "Aimon", "Bellas", "Cluhurach", "Connak", "Ettrian", "Ettrian", "Folmon", "Goll", "Goll", "Ilimitar", "Iliphar", "Inialos", "Jorildyn", "Juppar", "Khatar", "Khidell", "Kolvar", "Kolvar", "Kolvar", "Kuornos", "Lathlaeril", "Lhoris", "Lhoris", "Lhoris", "Maiele", "Maiele", "Molostroi", "Nym", "Oenel", "Oenel", "Orym", "Phaendar", "Phraan", "Rhys", "Rhys", "Rilitar", "Riluaneth", "Ruvyn", "Ruvyn", "Ruvyn", "Samblar", "Shaundyl", "Tehlmar", "Thalanil", "Theodred", "Theodred", "Theodred", "Vesstan"

"elf male 2"
-------------

.. code-block:: lua

   "Aelnithenrior", "Aelraelanor", "Aelsindolrond", "Aesraelesras", "Aesrindiror", "Aesthiranthir", "Aethmaeginad", "Aethsarolrod", "Anlirandir", "Arrinaldel", "Belmindaldir", "Bermindebrond", "Bersilmilion", "Berthalinion", "Caelmaegendil", "Caerraelirion", "Caerseroldil", "Celistebor", "Clarreledlin", "Earmerirorn", "Earsilandan", "Elbmerarlad", "Elbralirdan", "Elninenthir", "Elrilanlas", "Elsaeralrond", "Elsarerdir", "Eolraelilras", "Erlarevorn", "Erlrilirdan", "Estrimadfal", "Faerthaelebad", "Faerthalednar", "Feanmaegebros", "Findmirevthir", "Findmirthonlas", "Findnithenorn", "Finrinasrior", "Galnimaddan", "Galnimemfal", "Galrelanorn", "Galrelevlin", "Ganistarros", "Garlirasorn", "Gilrelamad", "Ilmninthonlin", "Ithninasthir", "Ithralthaldel", "Laeglithilthir", "Lindtheresrond"

"fetchling female"
-------------------

.. code-block:: lua

   "Bronora", "Drizonur", "Ehitil", "Ehugi", "Ehuza", "Gramohel", "Grimah", "Grudura", "Grura", "Hajone", "Hevi", "Hodoco", "Ikacotim", "Ikehon", "Ikuvotal", "Ileke", "Jamum", "Jovih", "Mena", "Qegoc", "Qizec", "Quti", "Rilih", "Sagem", "Tezunam", "Trahomoh", "Trenohe", "Trohel", "Truhe", "Ucezunir", "Ugata", "Ugezol", "Uguloha", "Umazar", "Umuno", "Umuzel", "Usesit", "Usuhohi", "Utidu", "Utiseh", "Uveta", "Xati", "Xoduli", "Xudu", "Yedi", "Yoteh", "Yuda", "Zanuhac", "Zejutot", "Zuhohi"

"fetchling male"
-----------------

.. code-block:: lua

   "Bratoh", "Brevu", "Draka", "Drejum", "Drimo", "Ecaco", "Ecohu", "Ehilu", "Ehucu", "Gralu", "Grehoh", "Ikasoc", "Ikuzom", "Ilage", "Ileco", "Mato", "Meve", "Micu", "Nadul", "Nezoh", "Oroto", "Qehin", "Qraso", "Qratur", "Qrezit", "Recom", "Recur", "Serot", "Socu", "Ucavuc", "Ucuhul", "Ucuro", "Ugahu", "Uguhu", "Umemit", "Umode", "Usidul", "Utedac", "Utila", "Uvugeh", "Xelec", "Xetum", "Yasu", "Yaval", "Yizom", "Yizu", "Yokot", "Zimoc", "Zuna", "Zuto"

"giant female"
---------------

.. code-block:: lua

   "Bulmih", "Chahfah", "Daoh-Ahg", "Daoh-Naohyih", "DaohEhm", "DaohGhanshul", "DaohUbbuli", "Doh-Shour", "DohTuhliig", "Ehmlah", "Ehmsoh", "Fah-Guh", "Fah-Pehpugh", "Fah-Thom", "Ghahdumtih", "Gham-Daoh", "Gham-Tih", "Ghammih", "Hehburh-Mih", "Hoosoh", "Khaz-Daoh", "Khurigireesoh", "Lah-Naroo", "LahEhm", "LahMeh", "MihDhak", "Naroo-Tih", "Nhamdoh", "Nuhmouh-Soh", "Oliush-Rei", "Oughrahoo-Daoh", "Ouhtoudhfah", "Puh-Doh", "Rei-Pugh", "Rei-Shour", "ReiBohrshlo", "Ronkhmih", "Saorilah", "Shom-Doh", "SohBuli", "SohGhadnaroo", "SohGuhpogh", "SohYih", "Suhimih", "Suhisoh", "Suthpehdoh", "Thom-Soh", "Tih-Ghish", "Treghyaum-Mih", "Urushzhamlah"

"giant male"
-------------

.. code-block:: lua

   "Ahg-Pugh", "Beegh-Beegh", "Burh", "Buri", "Buriurush", "Digrilogh", "Dum", "Feehm-Zham", "Ghat", "Ghat-Orf", "Giree-Suhiheh", "Goun", "Gounush", "Goush-Feehm", "Guh-Yeeh", "Heghi", "Heghi-Buri", "Heghisuhi", "Hree-Ghan", "Kham", "Khem", "Khem-Digri", "Logh", "Loghshul", "Maoh-Ronkh", "Mouh", "Naohkhee", "Oli", "Peh", "Peh", "Pogh", "Pughhani", "Pughpuh", "Puh", "Puh-Yih", "Quagi-Ahg", "Ronkh", "Rouk-Ghaw", "Rouk-Ob", "Shehi", "Suhi-Ghat", "Suth", "Suth-Heh", "Tebouh", "Thom", "Thom-Yauth", "Tregh", "Vuh", "Yaum", "Yauth"

"gnome female"
---------------

.. code-block:: lua

   "Banus", "Bilgus", "Bilgus", "Bimkiulo", "Binkwin", "Binkwin", "Bipflonk", "Bipvizz", "Byloflink", "Cargus", "Carvizz", "Dinkulo", "Elbeefinkle", "Elsizzle", "Fenflynk", "Fenyvizzle", "Fenyvizzle", "Fildilinkey", "Filgus", "Gelulo", "Gynndeedus", "Gynndomink", "Gynnulo", "Juldeeulo", "Katkiflonk", "Katlofizzy", "Kelwick", "Ketris", "Klofizzy", "Klokiwack", "Lisble", "Lokeefizzy", "Lymtink", "Lysflonk", "Lysskyago", "Merdiwack", "Mitbus", "Mitbus", "Mittlesizzle", "Mittlesizzle", "Nitly", "Talkink", "Tankoflonk", "Thenlinkey", "Thinkkeesizzle", "Thinklinkey", "Thinklinkey", "Tilthink", "Tindinkey", "Tyllofizzy"

"gnome male"
-------------

.. code-block:: lua

   "Bawick", "Bimliarn", "Binaris", "Binkflonk", "Binklbus", "Binklbus", "Bolink", "Bolink", "Bomdable", "Bonboris", "Buris", "Buris", "Buris", "Buwick", "Carlobrick", "Carlobrick", "Dimlank", "Dinlebrick", "Dobeeble", "Fenklink", "Fenklink", "Fenlflonk", "Fensizz", "Filgus", "Filkeewick", "Finflonk", "Finflonk", "Gimfizz", "Glinnus", "Glinnus", "Gnofinkle", "Gnokargo", "Gnokargo", "Hinklosizz", "Hinlidink", "Lago", "Lago", "Lago", "Lawizz", "Mittlegus", "Pitfinkle", "Pithosizz", "Thinkflonk", "Tinfizz", "Tinfizz", "Tolosizz", "Tolosizz", "Tolosizz", "Tomink", "Tovash"

"gnome surname"
----------------

.. code-block:: lua

   "Berrycrank", "Berrycrank", "Bizzblast", "Bizzgauge", "Bizzgauge", "Bizzspan", "Castfuse", "Castspring", "Castspring", "Draxlepipe", "Draxlepipe", "Fastspring", "Finegauge", "Finestrip", "Fizzletorque", "Gearwhistle", "Gearwhistle", "Grinddwadle", "Mechacrank", "Mechasteel", "Mechasteel", "Mekkakettle", "Mekkapipe", "Overkettle", "Porterblast", "Puddlefuzz", "Puddlespinner", "Puddlesteel", "Shinespring", "Shorthouse", "Shortspark", "Spannercrank", "Spannerwizzle", "Sparkfizzle", "Sparkspanner", "Sparkspanner", "Sparksprocket", "Springcrank", "Springgear", "Springhouse", "Sprygrinder", "Steamfuzz", "Stormbonk", "Swiftnozzle", "Swiftwizzle", "Thistlegrinder", "Thistlenozzle", "Tinkkettle", "Twistwhistle", "Wobblecrank"

"goblin female"
----------------

.. code-block:: lua

   "Balgya", "Bloksloge", "Blotya", "Boormubgah", "Botee", "Gaday", "Gakgligee", "Garya", "Gawy", "Gazee", "Ghornazy", "Gityipe", "Glagshrigah", "Glate", "Gligay", "Glizay", "Glizay", "Gnatay", "Grakah", "Grakghy", "Gratah", "Gratmakya", "Likke", "Luky", "Naggratee", "Nige", "Nikky", "Noggdufe", "Nukkligya", "Nukky", "Nukkya", "Shrigay", "Slaie", "Sligghy", "Snigay", "Sniggrakah", "Snikkhady", "Sogay", "Sogya", "Spikee", "Unkee", "Yaggah", "Yakee", "Yarkee", "Yigah", "Yipgah", "Yipyakah", "Zatghy", "Zibsligy", "Zitvarkghy"

"goblin male"
--------------

.. code-block:: lua

   "Achnazadz", "Akrag", "Azbot", "Bilgroksog", "Bliggat", "Blot", "Blotdokh", "Boorghag", "Burksnark", "Dokhsligark", "Dokhyak", "Drikak", "Driznok", "Gadslog", "Gagg", "Garloz", "Gatziz", "Ghakbilg", "Gitsnig", "Glaklikk", "Gligrat", "Glizgah", "Gogus", "Kavdokhburk", "Khadblot", "Khadglat", "Lag", "Luksna", "Lunligluk", "Mazmiz", "Mogghak", "Mogloz", "Murskrag", "Nagrat", "Nagshukdrik", "Nazguk", "Nokblid", "Noksnit", "Rakgit", "Roknaz", "Rokyak", "Rotffy", "Snityiggub", "Stoggmub", "Vogffy", "Yadbalgrak", "Yadslaigag", "Yarkhig", "Zatratgaz", "Zordyig"

"half-demon female"
--------------------

.. code-block:: lua

   "Alurrhyl", "Alurrula", "Alurskiu", "Azdusla", "Braldusla", "Bruhanil", "Bruhjiul", "Drulglyrr", "Idrulihyl", "Jhaaljiul", "Jhaallin", "Jidanil", "Jiudusla", "Jiusula", "Jurrhyl", "Kharkgiu", "Kharklin", "Kharkrhyl", "Kharkxhiu", "Krivdiu", "Krivulla", "Kuduzihyl", "Mulkzihyl", "Nidizil", "Nidlihyl", "Nymziu", "Ranagulla", "Ranagziu", "Ranagziu", "Rukrula", "Rulkzihyl", "Skaurdiu", "Skaurizil", "Skaurizil", "Ulthulin", "Urzbau", "Utiulla", "Uznidizil", "Vlagrhyl", "Vlagziu", "Vlashzihyl", "Vrazanil", "Vrazlin", "Vulkanil", "Vulklihyl", "Vulkziu", "Xaudiu", "Xidxhiu", "Xulskiu", "Zugizil"

"half-demon male"
------------------

.. code-block:: lua

   "Aaglurr", "Aagnal", "Alursuruk", "Araklank", "Araknal", "Braluvik", "Brazlurug", "Bruhinu", "Bruhlurr", "Idrusuruk", "Jiulun", "Jiuruzuk", "Jiuuvik", "Jurguvik", "Jurguvik", "Kaazsuruk", "Kargarag", "Kargsuruk", "Kharksuruk", "Kraunal", "Krivlurr", "Krivlurug", "Kuazarag", "Kuazarag", "Kuazrul", "Kuazull", "Kuduzu", "Nauarag", "Nausalk", "Nidrul", "Nidsalk", "Ninjsul", "Nymxulg", "Rilthusalk", "Ruksuruk", "Skaursalk", "Skaurzu", "Ulthuull", "Urzsuruk", "Utiarag", "Utiinu", "Utisuruk", "Utiull", "Uznidlun", "Vlaguvik", "Xausuruk", "Xidull", "Xurajdrul", "Xurajsul", "Xurajull"

"halfling female"
------------------

.. code-block:: lua

   "Adelheid", "Adelheid", "Aregund", "Audofleda", "Bave", "Begga", "Berenga", "Bertha", "Camelia", "Cheryl", "Chrodechildis", "Chrodechildis", "Cora", "Darby", "Emma", "Engelberga", "Erica", "Esmee", "Esmee", "Fatima", "Genofeva", "Gomatrudis", "Gudula", "Haley", "Jenna", "Jenna", "Kunegund", "Leesha", "Leesha", "Madison", "Mary", "Mary", "Melissa", "Menegilda", "Monica", "Natalie", "Ragnachilde", "Regnetrudis", "Rotrud", "Saffron", "Saffron", "Scarlet", "Shelby", "Tabitha", "Tasha", "Teutberga", "Theodelinda", "Tiffany", "Tiffany", "Vulfegundis"

"halfling female 2"
--------------------

.. code-block:: lua

   "Adela", "Adra", "Adrice", "Aila", "Aila", "Aila", "Alba", "Alba", "Almice", "Ambia", "Bardia", "Biffa", "Bildina", "Bombice", "Bombily", "Bunga", "Droca", "Drocily", "Durlia", "Durlwisa", "Emmina", "Emmina", "Erdice", "Evera", "Ferdwina", "Frobice", "Gamwina", "Halda", "Hascia", "Hodia", "Huga", "Hugice", "Hugwina", "Hugwisa", "Ivina", "Marka", "Markily", "Markwina", "Munga", "Munga", "Otha", "Otha", "Sega", "Serla", "Serla", "Tobice", "Tobina", "Tobwina", "Wania", "Wiga"

"halfling male"
----------------

.. code-block:: lua

   "Arculf", "Arculf", "Arnoul", "Audoneus", "Basso", "Bero", "Blanco", "Carambo", "Carambo", "Cassyon", "Corbus", "Dalfin", "Enurchus", "Enurchus", "Erard", "Farabert", "Fredegar", "Giseler", "Giseler", "Guntram", "Guntramn", "Habaccuc", "Harding", "Hildebald", "Hildibrand", "Ilberic", "Imbert", "Imbert", "Imbert", "Imbert", "Lo", "Lo", "Lo", "Madoc", "Magnus", "Marachar", "Merimac", "Riquier", "Riquier", "Samson", "Suidger", "Sunnegisil", "Thankmar", "Thankmar", "Waldolanus", "Waldolanus", "Waldolanus", "Waltgaud", "Willibrord", "Willibrord"

"halfling male 2"
------------------

.. code-block:: lua

   "Adrwin", "Ailo", "Ailwise", "Almard", "Almo", "Ambwin", "Ambwise", "Beno", "Beno", "Biffert", "Blanco", "Blanco", "Blanco", "Boffald", "Boffo", "Drocard", "Drocert", "Drocold", "Drocold", "Drocwin", "Drogald", "Drogo", "Emmo", "Emmold", "Erdo", "Erdwin", "Ernfast", "Everfast", "Ferdfast", "Ferdold", "Fulbard", "Gamo", "Hamwise", "Hasco", "Hasco", "Markard", "Markwise", "Milo", "Milold", "Mungo", "Mungo", "Odald", "Odo", "Sabo", "Sabo", "Samo", "Serlald", "Wigo", "Wydo", "Wydwin"

"halfling surname"
-------------------

.. code-block:: lua

   "Banks", "Bilberry", "Boffin", "Boffin", "Boffin", "Boulderhill", "Bracegirdle", "Brandagamba", "Brockhouse", "Brown", "Brownlock", "Brownlock", "Cotton", "Dewfoot", "Dewfoot", "Dewfoot", "Elvellon", "Fleetfoot", "Fleetfoot", "Fleetfoot", "Gaukrogers", "Gawkroger", "Gawkroger", "Goodchild", "Goodchild", "Greenhill", "Greenhill", "Hairyfoot", "Heathertoes", "Hlothran", "Hlothran", "Labingi", "Labingi", "Langham", "Leafwalker", "Lightfoot", "Littlefoot", "Longfoot", "Longfoot", "Longfoot", "Longfoot", "Longfoot", "Lothran", "Puddifoot", "Rumblebelly", "Sandheaver", "Silentfoot", "Thornburrow", "Twofoot", "Underlake"

"hobgoblin female"
-------------------

.. code-block:: lua

   "Afatot", "Afhora", "Afra", "Ceyrima", "Daruki", "Dirda", "Dirimat", "Esma", "Esuti", "Haemi", "Hahore", "Haleta", "Harima", "Harota", "Kethhor", "Kethhori", "Kethleta", "Kethlita", "Kethme", "Kolgrame", "Kolgtari", "Malglete", "Malglite", "Malgrima", "Okatak", "Okatin", "Okema", "Okhat", "Poldhara", "Poldharer", "Roldha", "Roldhori", "Roldima", "Saltati", "Salthore", "Tetima", "Tetmi", "Totate", "Toteme", "Totratar", "Turgdora", "Turgima", "Turglata", "Turgrima", "Uteme", "Utleta", "Utrate", "Uttare", "Zildrate", "Zilduki"

"hobgoblin male"
-----------------

.. code-block:: lua

   "Akat", "Akok", "Akok", "Akrot", "Bekla", "Bekot", "Bektar", "Dorram", "Durlut", "Fethi", "Fetok", "Fetom", "Fetrot", "Haot", "Hatar", "Hauk", "Kolgot", "Kolgrim", "Kurlut", "Malghi", "Mevla", "Mevtar", "Okat", "Okhar", "Okluk", "Oklut", "Okut", "Poldok", "Poldom", "Roldhor", "Roldram", "Roldrot", "Rolduk", "Saltok", "Saltram", "Tetram", "Tetrim", "Tetrim", "Totri", "Turgot", "Turguk", "Turgung", "Utram", "Utung", "Zildram", "Zildri", "Zoldhi", "Zoldlut", "Zoldram", "Zoldri"

"human female"
---------------

.. code-block:: lua

   "Belor", "Breguson", "Ce'Nebeth", "Cenleod", "Cwenthryth", "Derwa", "Eadsig", "Eadstrang", "Eadwig", "Ealdgyth", "Ealdric", "Ealdric", "Glavena", "Gloramivea", "Glorarin", "Glorobretha", "Godburg", "Godor", "Gotha", "Islita", "Isomina", "Joan-Marie", "Layemira", "Mabyn", "Mayawen", "Mayuwyn", "Melyar", "Melyonen", "Mildflaed", "Mildhaele", "Mildwini", "Mildwyn", "Nerylaith", "Oshild", "Polita", "Saewyn", "Salekira", "Sigebeorht", "Sigebeorn", "Sigeraed", "Sigwise", "Thurwaru", "Thurweald", "Wenna", "Wilweald", "Wineecg", "Wulfbeorn", "Wulfsige", "Yvura", "Yvytha"

"human male"
-------------

.. code-block:: lua

   "Aethelrand", "Armbeald", "Armran", "Bealdheah", "Bealdhere", "Bealdwulf", "Beorhthere", "Beorhtuald", "Beranweard", "Cuthgeat", "Cynenoth", "Cyneweard", "Deorraed", "Eadweald", "Eadwig", "Ealdgild", "Eanhere", "Ecgnoth", "Godhere", "Godweard", "Godwine", "Goran", "Grinubar", "Heathuheard", "Heorthere", "Heresige", "Inheard", "Jacca", "Jacca", "Jory", "Leofwulf", "Lorrion", "Malbar", "Marsden", "Nothhard", "Perran", "Samtir", "Thureofer", "Thurfrith", "Thurwulf", "Tortsig", "Trath", "Trilri", "Tristan", "Urkan", "Waltsunu", "Wigsige", "Wineheard", "Zanndil", "Zhir"

"human surname"
----------------

.. code-block:: lua

   "'Long' Rudd", "'Sharp' Anvil-Nose", "'Sweltering' Sidney", "Aerlalian", "Aerlalian", "Alrardessen", "Baird", "Bentham", "Blake", "Bradman", "Cundy", "Earle", "Facilalian", "Fine-Sage", "Free-Jumper", "Frenzied", "Frozen-Plank", "Garside", "Graeme", "Hammer-Tooth", "Helton", "Honey-Colossus", "Inch", "Jeraler", "Kempthorne", "Lang", "Moor", "Moorrush", "Noall", "Northerner", "Peagrim", "Philne", "Quick", "Riendicci", "Rock-Hewer", "Rose", "Storm-Fist", "Summer-Skinner", "Swift-Spring", "Tredinnick", "Troll-Toes", "Trollsbane", "Valteance", "Vonver", "Vonver", "Wheatley", "Whitley", "Williams", "Yeardley", "the 'Elfkiller' Catelian"

"ifrit female"
---------------

.. code-block:: lua

   "Ala", "Citya", "Edu", "Emwirh", "Emwirh", "Faah", "Feem", "Fetyula", "Firlu", "Funyi", "Futhe", "Gami", "Getyi", "Guhi", "Guly", "Hiqriwirh", "Hirlun", "Irry", "Irya", "Lahu", "Larlu", "Lawume", "Laye", "Lurhanhi", "Madru", "Marlutyulyu", "Nidu", "Qiryrludre", "Qityu", "Saya", "Sidre", "Sihe", "Siqehta", "Siqhi", "Siyi", "Sudruta", "Uqdru", "Uqra", "Utatwa", "Wilhi", "Wilin", "Willu", "Wuemra", "Zehu", "Zeryn", "Zuis", "Zumi", "Zuqhi", "Zutathe", "Zuthi"

"ifrit male"
-------------

.. code-block:: lua

   "Acij", "Aja", "Ana", "Arut", "Avu", "Banu", "Bela", "Bena", "Bule", "Bunu", "Darut", "Decil", "Gake", "Gekin", "Gekuj", "Gijig", "Giqig", "Jaket", "Jakin", "Jana", "Jejig", "Jekug", "Jemag", "Jinim", "Kele", "Kivin", "Makel", "Mala", "Mavit", "Mejig", "Merut", "Micil", "Mule", "Muva", "Nefit", "Nevin", "Raja", "Raneh", "Rikin", "Rile", "Rufit", "Tavig", "Tecij", "Tere", "Vamag", "Vamiq", "Vefim", "Veqil", "Vikun", "Zalum"

"infernal 1"
-------------

.. code-block:: lua

   "Aiazyamuz", "Alu-ujgaru", "Aluladuoi", "Baalirgla", "Baaluyiuz", "Breuytzau", "Bulishu", "Buljeduoi", "Buuzidrau", "Buzipaz", "Drau-uzshai", "Dromu-alnasu", "Dromu-iridrau", "Dromu-vocha", "Fraz-urhra", "Frazaydru", "Gellakul", "Ghauzughaa", "Ghuijtze", "Glaujhriz", "Glauuvnee", "Gro-yodre", "Gura-jughau", "Guraluitha", "Guzovchru", "Guzuralz", "Gyauvoxu", "Gyayonahu", "Hezzadrau", "Lurhzluaiaz", "Mau-jirez", "Muzaldrau", "Nalzaidrau", "Neeyaulchru", "Oazoavgel", "Oxuzirezu", "Pazoygla", "Razarzu", "Rezualshu", "Rezuayriz", "Ruiydre", "Rujogura", "Shaioyrezu", "Tha-ludru", "Thaluvohuz", "Vul-zudre", "Vulizpaz", "Vuulurvul", "Yilejgro", "Zulijulchru"

"infernal 2"
-------------

.. code-block:: lua

   "Aagovdaurg", "Aig-yugrag", "Aigivbub", "Baugzirung", "Brelgjoiub", "Bulg-josaug", "Draug-urjub", "Drelb-iyagh", "Drogazmog", "Drogivxub", "Droguyszug", "Ghadjoleegh", "Ghadurfelg", "Glabijszug", "Haaguzleegh", "Hrudirhrud", "Iugulolb", "Jubjeboaj", "Jubriboaj", "Kolgardregh", "Kolgluvogt", "Leeghjuurb", "Leeghviszug", "Magariog", "Mauglanalb", "Mauglubaug", "Mogjonud", "Naagrisaug", "Nog-laraug", "Nudzustug", "Nug-luyibb", "Nuglohrud", "Nulb-rutrulg", "Oggalzub", "Riggzanalb", "Sag-rorigg", "Saugajfulg", "Strogizmag", "Sugviaug", "Tharg-jibaug", "Thaug-ujdraug", "Thaug-zenog", "Thogyeszug", "Thogzubarg", "Uagazmaug", "Urberbrelg", "Vulb-elsaug", "Zubortharg", "Zug-oysug", "Zugteldaurg"

"infernal 3"
-------------

.. code-block:: lua

   "Ashivtlizit", "Azt-ilhaerx", "Bahoreyirsch", "Basolsut", "Blik-yitash", "Boralglaur", "Charnvunoc", "Dekjedak", "Dun-rahoth", "Gaanorlach", "Geklutash", "Githlaszut", "Goch-lolith", "Gor-ojloch", "Goriynuur", "Gorrunuur", "Gothulutuk", "Gureyrolk", "Gurzasaur", "Hothuzrhast", "Iex-ulnoc", "Inaxizruun", "Krychujlith", "Krychurgor", "Krychzesaur", "Lechlimuth", "Liskuzmoth", "Lithurluth", "Lochzigaur", "Matvibar", "Mocharash", "Nuurleyalm", "Nyth-ojruaak", "Raukezdraum", "Rothlairsch", "Ruaak-ejech", "Ruaak-yuszut", "Ruaakyaigm", "Saurezxaas", "Sauryislyth", "Sotherloch", "Tashezoth", "Teravmuth", "Thalk-yutur", "Turejbar", "Uztilurt", "Vach-ivach", "Vapizhaerx", "Vapjerolk", "Vrokozchon"

"kobold female"
----------------

.. code-block:: lua

   "Aso", "Azor", "Azro", "Azsi", "Easazas", "Esoo", "Essro", "Finonzra", "Gase", "Gazok", "Gazu", "Harazor", "Harzu", "Idse", "Lulrek", "Lulsruse", "Lulsusdu", "Modros", "Mogru", "Mokru", "Nerosroa", "Nosgar", "Nosilka", "Nosso", "Ogar", "Parhoo", "Parnon", "Parsisoo", "Pokohoo", "Rigar", "Rilis", "Risra", "Risro", "Sadil", "Sados", "Sadre", "Sadsru", "Saritro", "Sokazas", "Sokrekkru", "Tarre", "Tolkuk", "Vise", "Visle", "Vola", "Vosro", "Zare", "Zigra", "Zirekuk", "Zizu"

"kobold male"
--------------

.. code-block:: lua

   "Dhezzad", "Dhime", "Dhiog", "Dhireniah", "Driir", "Droxarknri", "Droxma", "Drunal", "Eaghe", "Eatradholkxeb", "Gaknalp", "Gakre", "Ghazep", "Ghelob", "Gheze", "Gredholk", "Gredmak", "Iar", "Ilmakgag", "Imaalp", "Imak", "Ipodroo", "Irad", "Jeld", "Jelob", "Kibod", "Kibog", "Kognosk", "Makghe", "Qear", "Qraodmak", "Qrarzor", "Qrazad", "Qrazenra", "Qrilnal", "Ruskolk", "Rusnri", "Ruszor", "Vadnalpxas", "Venalpan", "Vezinnalp", "Vhopzi", "Vhopzorgag", "Votla", "Zeekre", "Zoark", "Zonal", "Zorah", "Zorlobzad", "Zornalp"

"ogre female"
--------------

.. code-block:: lua

   "Arghguhlghy", "Bogguhlya", "Burzobbah", "Dofgrukgharay", "Dofmudy", "Drugmakhya", "Duggluzah", "Duggrumgah", "Duzmudghy", "Ghashkurshrufay", "Glubnakhah", "Gludglubghy", "Gluzgrashya", "Gomdulay", "Grobzugya", "Grokdugay", "Grokshurglubya", "Grolthulkah", "Grulkuggah", "Grumgroggya", "Grumnakhah", "Gruzguhly", "Guhlmulurday", "Haishrufay", "Hurgghakhah", "Hurgrumah", "Lukhgruly", "Lumlurzya", "Lurzdugah", "Lurzkrodthurkgah", "Lushdrokya", "Makhghorya", "Makhobbghy", "Muddugay", "Mugmaugy", "Nakhdushghy", "Rolbyugya", "Ruzdushya", "Shudklobay", "Shurglubhury", "Shuzgrutay", "Slubruzya", "Sludgharghy", "Sludzugya", "Sluggluzay", "Thragarghgah", "Thurkhurghy", "Thurksludy", "Zugbogah", "Zugnakhya"

"ogre male"
------------

.. code-block:: lua

   "Arghlush", "Burzlukhburz", "Burzmudzug", "Drubmakh", "Dubgrol", "Duggrul", "Durshobbhur", "Dushkrod", "Dushurthrag", "Duzrukh", "Duzyur", "Fugrukhnarg", "Fugslub", "Ghakhgrol", "Ghorkur", "Ghukkur", "Glubobb", "Gluzgulv", "Grashbarsh", "Groggshur", "Grolburz", "Grolghar", "Grufurgh", "Grumthulk", "Grutghash", "Grutlukh", "Guhllug", "Haimud", "Hurgrut", "Hursluggrok", "Krodrolb", "Kurghul", "Luzdrok", "Luzghakh", "Makhmaug", "Makhzud", "Muldrub", "Rolblurzdrub", "Ruzgom", "Shugrukh", "Shurdul", "Shuruz", "Shuzdub", "Slubzud", "Slugmakh", "Thragkur", "Thragluz", "Thurkklob", "Urdlug", "Urghluz"

"orc female"
-------------

.. code-block:: lua

   "Bashat", "Bashramph", "Bashuk", "Bashuk", "Bolar", "Borba", "Bula", "Burfim", "Dulug", "Dulug", "Duratharz", "Durz", "Gashbul", "Glurarz", "Gonk", "Grat", "Gratzush", "Gul", "Lagrzug", "Lagrzug", "Mazramph", "Mazrzug", "Mogak", "Mogak", "Mogak", "Mornga", "Morza", "Murbraz", "Murmalah", "Murzum", "Orbugol", "Orbuh", "Rulfgdub", "Rulurz", "Rulurz", "Shadbak", "Shagdub", "Shal", "Shardurz", "Sharog", "Shelmalah", "Slout", "Ugak", "Uglaim", "Ugozush", "Ulumt", "Ulumt", "Urzoth", "Yazgash", "Yazgash"

"orc female 2"
---------------

.. code-block:: lua

   "Agshagya", "Badgrotah", "Bagaugghy", "Bagshagy", "Blaglobgah", "Dobnary", "Dobrorgy", "Dogruftay", "Ghazbragah", "Ghazoggah", "Glufkhagghy", "Gnublufah", "Gokhglakhy", "Gorrutghy", "Gorsluray", "Grashdobghy", "Grazdagghy", "Grudgudya", "Hakkdagghy", "Hakkdugy", "Hratraggah", "Hroglashhakkya", "Hrugludghy", "Khaguthghy", "Lubtroggah", "Lufgrubah", "Lukrugy", "Molksnurrah", "Mukdagya", "Muzyobgah", "Ragkrudah", "Rashblagah", "Roggdaggah", "Roggdugah", "Rotglobgah", "Rotgrazah", "Rudbaggah", "Rufttrogghy", "Shazlashah", "Shogsnurrgah", "Skulggrakhay", "Slurbakhah", "Stulggnubah", "Ungbruzah", "Ungrutya", "Uthbashay", "Yashsnurray", "Yobagglazah", "Yobbraggah", "Yobdakkah"

"orc male"
-----------

.. code-block:: lua

   "Azukb", "Baroulakh", "Bashrz", "Bazgulakh", "Brugbagorn", "Crothu", "Duraug", "Durbrag", "Ekganit", "Fogugh", "Ghamrlorz", "Ghamulakh", "Ghamulakh", "Gratgnak", "Gratgnak", "Gratgnak", "Grufish", "Igmut", "Larek", "Lumdk", "Lurodum", "Mabub", "Mahkmba", "Mahlak", "Mashkul", "Murgob", "Muzgrbash", "Muzgrbash", "Narhbub", "Oglha", "Olpel", "Owkbanok", "Podagog", "Sharmonk", "Shumborz", "Snagmash", "Snakzum", "Ulagak", "Ulmumonk", "Ulmuong", "Umugok", "Urul", "Uzgash", "Uzgba", "Wanug", "Woghuglat", "Yador", "Zarfu", "Zilge", "Zorgulg"

"orc male 2"
-------------

.. code-block:: lua

   "Bagbad", "Baggnarl", "Bazug", "Bruztrog", "Doblash", "Dobrag", "Dobstulg", "Dogglur", "Doglobdarg", "Drabluk", "Drabsnub", "Ghazluk", "Glakhsnar", "Globung", "Glurkhar", "Gnashdakk", "Gnubsnubgluf", "Gobsnar", "Grathrorgskulg", "Grudgnarl", "Grudtrog", "Gutrug", "Gutshag", "Hratgash", "Khagdug", "Khargluf", "Krudmuk", "Luddob", "Molkgut", "Mukluk", "Narshazrut", "Olghrug", "Roggrorgtrog", "Rottrog", "Rugshog", "Shaglashghaz", "Shakhrug", "Shakrogg", "Shaktrog", "Shogshak", "Skulgmuz", "Snorlruft", "Snorlyakh", "Snubdug", "Snubsnar", "Snubyakh", "Uthluf", "Uthsnar", "Yashhrug", "Zahkluk"

"orc surname"
--------------

.. code-block:: lua

   "Aglharzol", "Atugdu", "Atulor", "Atuwog", "Azorrish", "Bargzuf", "Bashar", "Batrak", "Baturba", "Bogrug", "Borgham", "Burbba", "Buzrat", "Dulamgog", "Glogob", "Gluhnag", "Glurkh", "Gorum", "Gramim", "Hubor", "Kasmakh", "Kasmgog", "Khazbul", "Logook", "Logrgul", "Maroilslag", "Masrag", "Masrag", "Mogan", "Mogdgramph", "Morggurz", "Mughrump", "Mukug", "Muzgdbuk", "Nayba", "Nayba", "Naybar", "Naydborgob", "Ogduborgob", "Olurob", "Orbuduk", "Rugga", "Shulharzol", "Skangur", "Traamph", "Trairbag", "Ugduku", "Uzgrat", "Yagbu", "Yarurga"

"oread female"
---------------

.. code-block:: lua

   "Bhenhe", "Bhifa", "Bufhu", "Bury", "Dehryhe", "Evi", "Ghoffinish", "Hanishce", "Henhe", "Hilfhi", "Ifhes", "Lahuhef", "Lenhe", "Lesele", "Nanhe", "Nanhi", "Nanrura", "Nirinshor", "Nuschosi", "Nusryohe", "Nustye", "Nyhi", "Nytyefhu", "Pamalit", "Pimnishya", "Pofa", "Pohsy", "Poleti", "Polihuh", "Rahyihe", "Recutye", "Rhema", "Rhesnish", "Rhomanry", "Rihir", "Rilar", "Serya", "Shalcu", "Summohi", "Sumtyu", "Thascihsa", "Thasty", "Tomelfhu", "Tuha", "Unli", "Vacharyene", "Vifi", "Vosan", "Vosti", "Vutho"

"oread male"
-------------

.. code-block:: lua

   "Ahdar", "Ahmum", "Anlah", "Bonmimfo", "Bovum", "Danvetdos", "Dethonmor", "Gundumdu", "Gunfam", "Irinmym", "Ivroshom", "Jalus", "Jamon", "Jeymimrun", "Jeytor", "Junlod", "Junlu", "Junnat", "Lalmus", "Maldumvet", "Mendusmum", "Menmu", "Menvrosnan", "Montorlod", "Montormus", "Nahunret", "Namumvhat", "Nanvython", "Nathu", "Nyvrortan", "Onan", "Onvu", "Pylvharmon", "Rodan", "Rodosrin", "Ronutrer", "Rovot", "Runvir", "Rython", "Sarnom", "Sondur", "Suldarin", "Tohutdam", "Tothotmon", "Tyretdol", "Urmum", "Vomrmu", "Vomvoh", "Vydarmum", "Vymomtar"

"sprite female 1"
------------------

.. code-block:: lua

   "Dexasti", "Flimanel", "Flissinel", "Flixamer", "Flixarel", "Flixerel", "Fossimer", "Fossimer", "Friskasti", "Friskifer", "Gesserel", "Glanamer", "Glanarel", "Glaninel", "Glanirel", "Glaxafer", "Glaxirel", "Gliminel", "Glissirel", "Gossanel", "Hexerel", "Raffarel", "Raffifer", "Ressafer", "Ressefer", "Ressenti", "Riffamer", "Rillasti", "Saffamer", "Saffanel", "Saffarel", "Saffinel", "Shimafer", "Shimarel", "Tissinel", "Tissinel", "Tissirel", "Trillinel", "Tristifer", "Twillerel", "Twillinel", "Twispirel", "Twissamer", "Twixarel", "Winnarel", "Winninel", "Wispamer", "Wisparel", "Wispinel", "Wispinel"

"sprite female 2"
------------------

.. code-block:: lua

   "Crylkiss", "Crylniss", "Crylree", "Elsidee", "Elsikiss", "Elsiliss", "Emberliss", "Embernyx", "Eskla", "Eskliss", "Eskriss", "Esksa", "Feristiss", "Gandee", "Glinkriss", "Glinkriss", "Halnyx", "Iphilree", "Iphilsa", "Ispeltiss", "Istletiss", "Jattiss", "Jatynx", "Jostdee", "Jostnyx", "Maliriss", "Minkkiss", "Minkla", "Mistleniss", "Ninkala", "Ninkamee", "Ninkanyx", "Opaldee", "Opalree", "Orifree", "Oristiss", "Orisynx", "Periree", "Sarmsa", "Sprinniss", "Stithriss", "Tansikiss", "Tirraniss", "Tirraree", "Trumpdee", "Trumpsa", "Whisree", "Zandoliss", "Zandoynx", "Zandoynx"

"sprite male 1"
----------------

.. code-block:: lua

   "Dexando", "Dexaron", "Flaxaldo", "Flaxeroll", "Flaxesto", "Flissamo", "Flissamo", "Flixando", "Fossallo", "Friskendo", "Friskeroll", "Frissaldo", "Gessaldo", "Gessando", "Glanallo", "Glaneron", "Glanesto", "Glaxasto", "Glaxeron", "Glaxondo", "Glissallo", "Glissando", "Glissaron", "Gossallo", "Gossamo", "Gossendo", "Hexando", "Hexondo", "Hexondo", "Lissondo", "Miskallo", "Raffaroll", "Rafferon", "Ressaroll", "Rillallo", "Rillaron", "Saffando", "Saffaron", "Safferon", "Shimasto", "Shimendo", "Trillasto", "Tristaron", "Twilleron", "Twispando", "Winnando", "Winnendo", "Winnondo", "Wispaldo", "Wisparon"

"sprite male 2"
----------------

.. code-block:: lua

   "Brisfrell", "Briszisk", "Crylbrix", "Cryltross", "Elsifrell", "Elsifret", "Elsifret", "Elsiwin", "Elsizisk", "Emberfret", "Eskfret", "Esktwik", "Ferisfret", "Ganrix", "Halfret", "Halmist", "Helbik", "Helwin", "Iphilrix", "Istlebik", "Istlebik", "Istlemit", "Jattwik", "Jostkin", "Josttross", "Jusmist", "Lirrafret", "Malitwik", "Minkfrell", "Minkkin", "Minkrix", "Mirratwik", "Mistlemist", "Mistlezisk", "Ninkafret", "Ninkarix", "Ninkawin", "Orifbrix", "Orifrix", "Oriftwik", "Orisbik", "Orisfret", "Sarmmit", "Stithmist", "Tirrakin", "Tirramit", "Trumpmist", "Whismist", "Whistwik", "Whiswin"
