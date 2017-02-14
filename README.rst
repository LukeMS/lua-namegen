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

* `Release News`_

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


Release News
============

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


Below are examples of generated names for each of the sets packed with LuaNameGen:



Books
--------

"books"
********

.. code-block:: lua

   "ancient green", "black", "blue", "blue", "blue", "brown", "charred brown", "compact gray", "compact orange", "compact slender black", "compact tattered orange", "compact worn orange", "embossed red", "gilted brown", "gilted green", "green", "heavy decorated white", "heavy tattered orange", "hide-covered blue", "hide-covered white", "huge black", "huge brown", "iron-bound yellow", "large embroidered black", "large purple", "leather green", "mangled gray", "orange", "orange", "orange", "purple", "purple", "ragged green", "red", "silvery", "small blue", "small brass-bound white", "thick dusty white", "thick leather gray", "thick silvery", "thick white", "thick yellow", "tiny brass-bound yellow", "tiny leather-bound gray", "tiny red", "tiny yellow", "used green", "used white", "white", "yellow" 


Creatures
------------

"potions"
**********

.. code-block:: lua

   "amber", "blazing", "blood red", "blubbery dark orange", "blubbery light silvery", "blubbery silvery", "clotted dark black", "clotted light brown", "clotted light golden", "clotted purple", "flickering dark mercury", "flickering dark pink", "icky", "icky", "misty dark orange", "misty light brown", "misty white", "mottled", "mottled", "oily dark mercury", "oily light mercury", "opaque light magenta", "opaque light red", "opaque light turquoise", "rusty", "sandy dark orange", "sandy pink", "shimmering", "shimmering", "shiny", "slimy", "sparkling black", "sparkling magenta", "swirly cyan", "swirly dark cyan", "swirly dark orange", "swirly light golden", "swirly light green", "swirly light yellow", "thick dark golden", "thick dark white", "thick light black", "thick light gray", "thick light red", "thick light yellow", "thick violet", "translucent light green", "viscous light turquoise", "viscous yellow", "watery" 


Potions
----------

"jice towns"
*************

.. code-block:: lua

   "Aeldell", "Aelgate", "Belhold", "Belmist", "Belsummer", "Blackcastle", "Blackcrest", "Clearcoast", "Clearfort", "Coldshore", "Coldtown", "Crystalshade", "Deepcrest", "Edgeshore", "Fairlake", "Fairlake", "Falconmill", "Fallhill", "Icemoor", "Ironcrest", "Irondor", "Millhollow", "Millshore", "Moonash", "Moondale", "Rayash", "Redcastle", "Rockfield", "Rockhaven", "Rocklake", "Rosefield", "Rosepond", "Shadowcliff", "Silverfield", "Silverhaven", "Silverlake", "Silvermist", "Silverpond", "Spellford", "Spellhaven", "Stonecliff", "Stonecliff", "Stonegate", "Strongdell", "Strongshore", "Strongwick", "Westerwick", "Winterash", "Wintercliff", "Winteriron" 


"mingos towns"
***************

.. code-block:: lua

   "Aleston", "Ashbrook", "Bedwood", "Birdlingborne", "Branland", "Brightness", "Clearmill", "Cornshore Junction", "Crystalmoor", "Darkburgh", "Dracshire Corner", "Dracway", "East Bullsmoor", "East Eaglemouth", "Elkway Barrens", "Estercroft", "Estermill", "Ewesdorf Meadow", "Firedale", "Fort Clarkwood", "Foxford", "Foxton", "Greenmill", "Guildriver", "Hazeside", "Hemlockburg", "Kentmouth", "Kingspool", "Mapleton", "Marblecastle", "Middle Morbury", "Mount Rossminster", "Mudmoor Junction", "New Whiteside", "Old Swordcroft Barrens", "Portmouth", "Rockmill", "Rockvale Dell", "Silverbury Landing", "Sowshall", "Stockpool", "Swanmill", "Swanstoke", "Swordmere", "Upper Cherryburg", "West Sworddam", "West Worpool", "Whiteburg Springs", "Winterford", "Yellowcroft" 


Towns
--------

"aasimar female"
*****************

.. code-block:: lua

   "Adrasteth", "Amarset", "Ar-kasal", "Ardrea", "Arsinoe", "Artyra", "Astares", "Atarenth", "Avlanteth", "Dama", "Davina", "Drinma", "Imema", "Imesah", "Imesah", "Jalkarel", "Jalma", "Jasalereth", "Javrales", "Kalarer", "Kaldrea", "Kaljena", "Kaltyra", "Kasaler", "Mael", "Maet", "Nialla", "Niel", "Nienth", "Nier", "Nieseth", "Nieseth", "Nijena", "Nisozi", "Nityra", "Oneth", "Palma", "Palvina", "Ral-jasarm", "Ralken", "Rhienth", "Rhiken", "Rhivina", "Saraneleth", "Solareth", "Talma", "Talsinoe", "Valorel", "Var-aran", "Voltaren" 


"aasimar male"
***************

.. code-block:: lua

   "Amaras", "Aranath", "Aranth", "Aritian", "Aritian", "Arrant", "Belnan", "Ceramin", "Cergan", "Cernan", "Cerrant", "Cronal", "Cronath", "Cronath", "Cronitian", "Cronral", "Eathar", "Egan", "Eran", "Ilamin", "Jalitian", "Jasalath", "Jasarmat", "Kalgan", "Mauat", "Mauath", "Mauath", "Paladat", "Palantat", "Palorathas", "Pawier", "Ramanas", "Rasanas", "Samarathal", "Saranar", "Saritian", "Talanath", "Talarath", "Taldril", "Talonar", "Tarwier", "Tavalar", "Tavalathal", "Tuamin", "Tuamin", "Tuas", "Tugan", "Tural", "Vartin", "Wyran" 


"catfolk female"
*****************

.. code-block:: lua

   "Dumiau", "Dusash", "Dusfee", "Dushau", "Duya", "Holyau", "Homeeri", "Hoswish", "Hoyera", "Hoyeri", "Jilaha", "Jilithe", "Jimihr", "Lirrlisse", "Lithserr", "Lyausfee", "Maumeeri", "Mewlithi", "Miahmiau", "Miaulahi", "Miausyau", "Mirrshim", "Mirryi", "Miuniri", "Purrhlahi", "Purrhlithi", "Purrhmirr", "Serrpurrh", "Shahmiah", "Sharrlini", "Sharrlissi", "Sharrsiyth", "Shaulyara", "Sheelissi", "Sheemau", "Sheemiu", "Sheerlissa", "Shurrshee", "Siphelirra", "Siphelisse", "Siphelissi", "Siphemau", "Sipheshim", "Slifsiyth", "Swishlina", "Swishmau", "Syaumiu", "Tilirri", "Tilithi", "Tiyi" 


"catfolk male"
***************

.. code-block:: lua

   "Carmew", "Carruth", "Carsaf", "Carsfee", "Carwan", "Dremihr", "Dresaf", "Dresiyth", "Fermirr", "Fersheer", "Ferslif", "Fersyau", "Gerlith", "Gershau", "Gershee", "Gerus", "Lirrmiah", "Lisslyau", "Lissmirr", "Lithsfee", "Lyaumiah", "Lyaushau", "Mauliss", "Mauserr", "Meerlyau", "Mewshah", "Miahsharr", "Miahshau", "Miauslif", "Mirrlyau", "Mirrsash", "Miuwan", "Nyksfee", "Nykshau", "Nyksheer", "Purrhmau", "Rougar", "Roumiah", "Sashmew", "Sashpurrh", "Shahsyau", "Sharrmau", "Shaulith", "Shaupurrh", "Shausyau", "Sheelith", "Sheermihr", "Sheesiyth", "Slifshee", "Swishlyau" 


"dragon female"
****************

.. code-block:: lua

   "Adastramordaxis", "Andraneriaxis", "Aragxenoris", "Aragzzebraxis", "Archobazia", "Baramanthysa", "Baranaluxis", "Bhakribazia", "Bhakrimanthysa", "Bianeriaxis", "Braborossa", "Bradobazia", "Bradomandrossa", "Bravorunga", "Chrysobradaxis", "Harnadralix", "Heliomanthysa", "Iulmalaxis", "Iulmordaxis", "Iulxenoris", "Jalanvoraxis", "Jarzembazia", "Jarzemzzemalis", "Jazramanthysa", "Jazraphylaxis", "Jazraxenoris", "Jurgazuthraxis", "Kralkamandrossa", "Kralkavoraxis", "Marmorazzebraxis", "Melkarzzebraxis", "Ourolagonis", "Peridobazia", "Peridonadralix", "Peridoxenoris", "Phrixuphylaxis", "Porphyrozzebraxis", "Pyrazuthraxis", "Rauphylaxis", "Sarcuzzebraxis", "Sardamandrossa", "Sarnaluxis", "Sidereomordaxis", "Skhiacordaxis", "Skhiaxenoris", "Sulchrumalaxis", "Tchalcedoborossa", "Vramandrossa", "Zalarzuthraxis", "Zerulcordaxis" 


"dragon male"
**************

.. code-block:: lua

   "Aragmalax", "Aragxenor", "Atrabradax", "Atrabradax", "Barazzemal", "Barvorax", "Barxenor", "Barzzemal", "Berumanthys", "Bhakrizzebrax", "Brabazius", "Brabazius", "Brimaboros", "Cadramordax", "Chroboros", "Chrobradax", "Chromandros", "Chrysozuthrax", "Glaucalchax", "Harmandros", "Harphylax", "Iulboros", "Jalanmordax", "Jalanzzebrax", "Jarzemcordax", "Jarzemnalux", "Jurgazzebrax", "Lazulozuthrax", "Marmorazzebrax", "Melkarmalax", "Ouronadral", "Peridoboros", "Phoronadral", "Rauboros", "Rhemordax", "Rhenalux", "Rhevorung", "Rhodolagon", "Sarcalchax", "Sarcuboros", "Sarcumalax", "Sarcunalux", "Sarzzemal", "Scarvabazius", "Sidereonadral", "Tchalcedomalax", "Tchazarmanthys", "Vrabazius", "Zerulphylax", "Zerulphylax" 


"drow female"
**************

.. code-block:: lua

   "Balsollya", "Baltelisra", "Balvorpiria", "Balvra", "Bersunvra", "Charrubra", "Chorsushel", "Chorvirsil", "Colonvril", "Colpaniln", "Colsusiln", "Cysulth", "Denillivith", "Divervra", "Dolsusbra", "Dornyllavvril", "Doryassil", "Dripeltra", "Drirhaiza", "Duril", "Duriza", "Durumiza", "Durvolrinvril", "Duryasniss", "Ekolgira", "Ekrelan", "Eksindeil", "Ekth", "Entullya", "Erorgna", "Gontra", "Inssil", "Istrhaellya", "Istsekene", "Jegsunervia", "Jendrelistra", "Johyasth", "Kilumlin", "Lilveriza", "Losolgiln", "Lostelistra", "Mazporia", "Mazsunhel", "Merpeldril", "Mezverdeil", "Nornyllya", "Norvilhrin", "Nothnelsil", "Tysunia", "Tytormna" 


"drow male"
************

.. code-block:: lua

   "Arpornaz", "Arvrilird", "Berovin", "Beryellim", "Burrhasinuld", "Charnyleld", "Chortelald", "Chorvim", "Chorztnim", "Coltullim", "Denorim", "Dethalnim", "Drimyruld", "Drinoxeld", "Drinylviz", "Drisulin", "Drivrillivurn", "Dromcariv", "Dromnil", "Dromsaburn", "Dromtulild", "Dromvirlavvir", "Dulnelrinird", "Dulviculd", "Eilonnim", "Eilryviz", "Ektulurn", "Ennonid", "Enonald", "Eruld", "Gonnylriv", "Gulvolrim", "Immyrird", "Jegtener", "Jerin", "Jyssolird", "Kaald", "Marnaz", "Mervrilvim", "Mezztrim", "Miorgid", "Mirorgrid", "Mirrelnim", "Mirtelrim", "Nothidul", "Nothyellevred", "Pharred", "Pharred", "Pharzteld", "Synerim" 


"dwarf female"
***************

.. code-block:: lua

   "Bagret", "Bigra", "Bokala", "Bomvara", "Botuna", "Brarinda", "Bretrielle", "Cody", "Dalinda", "Darov", "Dasi", "Detala", "Duermala", "Duvara", "Dwanuda", "Fariba", "Friya", "Gimal", "Gimryn", "Gomtha", "Gotha", "Heshan", "Hevada", "Javada", "Jorbra", "Jorda", "Jorhild", "Jorya", "Karyn", "Keli", "Kidi", "Linda", "Marfra", "Marvada", "Nalvada", "Nalvia", "Neraryn", "Otha", "Rashild", "Rasmala", "Rilaani", "Tabida", "Tafra", "Tarev", "Thivara", "Vesi", "Vondy", "Vonsi", "Wefra", "Yeniess" 


"dwarf female 2"
*****************

.. code-block:: lua

   "Brokklif", "Bromdis", "Bromlind", "Burlris", "Darith", "Dolglind", "Dolgvis", "Dromnis", "Durmlif", "Frordis", "Frordis", "Frorlif", "Fuldna", "Fundlif", "Gloga", "Gorddis", "Gormda", "Gradhild", "Gradna", "Grimdis", "Grimdis", "Groddis", "Gromnis", "Gulddis", "Guldis", "Guldrun", "Gurlif", "Horddis", "Hordlif", "Hordna", "Hordvis", "Hornrith", "Hornrith", "Hradis", "Hralis", "Norddis", "Nordrith", "Ormbis", "Stornis", "Sturldis", "Sturldis", "Thordis", "Thorndis", "Thornrun", "Thorrun", "Thralif", "Throlris", "Thrordis", "Throrith", "Thrubis" 


"dwarf male"
*************

.. code-block:: lua

   "Abur", "Anin", "Bivin", "Bonden", "Bori", "Bornaeth", "Botri", "Dalirvan", "Dalon", "Danlin", "Derimm", "Doni", "Doni", "Dothur", "Duerfri", "Dwoddig", "Ellatin", "Favil", "Fibil", "Frevri", "Frundfiekreord", "Garfur", "Gimran", "Graunnirm", "Gwarbur", "Gwarnur", "Hurmur", "Ibthur", "Ibvi", "Jorthur", "Kavil", "Kilni", "Kuker", "Loin", "Lori", "Nalden", "Orvamard", "Pyrgor", "Reiteam", "Rovim", "Sirgud", "Tathur", "Tellin", "Telmur", "Thobur", "Thodir", "Thonril", "Thonvi", "Wertri", "Wervin" 


"dwarf male 2"
***************

.. code-block:: lua

   "Bornri", "Bornvor", "Brimvor", "Brodrok", "Brodvir", "Brokknir", "Brokkvir", "Brudin", "Burir", "Burlin", "Burrin", "Dalin", "Dalrin", "Dalvir", "Dorir", "Dormir", "Drimri", "Dromin", "Durir", "Durrok", "Fromin", "Fromir", "Fromrin", "Frorrok", "Fuldrur", "Gimor", "Gormrok", "Grodvir", "Gromrin", "Gromvi", "Guldvor", "Gundri", "Hordin", "Hornin", "Hornror", "Hranir", "Nair", "Ormin", "Skandin", "Skondin", "Skondrok", "Stornli", "Sturlrok", "Sturrin", "Sturvir", "Thorvor", "Thranir", "Throri", "Throrin", "Thrurvir" 


"dwarf surname"
****************

.. code-block:: lua

   "Beardoom", "Bloodhead", "Bouldercarver", "Bronzebreaker", "Coalbender", "Coldchest", "Coldchest", "Coldhood", "Copperclub", "Elf-Executioner", "Ettinchoker", "Ettinmasher", "Foecutter", "Giantbutcher", "Giantchoker", "Giantcutter", "Gnome-Strangler", "Goblineater", "Greyfist", "Hammercarver", "Ironcarver", "Irondigger", "Koboldcutter", "Marbleheart", "Metalsmith", "Mithrilforger", "Mithrilheart", "Mithrilminer", "Noblefist", "Noblesword", "Oakpick", "Oakspear", "Onyxpike", "Orc-Beheader", "Orccrusher", "Redhead", "Redspear", "Rockminer", "Silverhand", "Steelbreaker", "Steelfoot", "Steelheart", "Strongaxe", "Thunderfist", "Troll-Beheader", "Trollkicker", "Trollmasher", "Trollslayer", "Whitehair", "Wolfbutcher" 


"elf female"
*************

.. code-block:: lua

   "Aenwyn", "Aenwyn", "Ahrendue", "Alaglossa", "Alais", "Alais", "Arielimnda", "Bellaluna", "Bellaluna", "Bellaluna", "Bellaluna", "Braerindra", "Cyithrel", "Cyithrel", "Deularla", "Deularla", "Elanalue", "Elanil", "Elasha", "Elmyra", "Falenas", "Faraine", "Filauria", "Haera", "Ilmadia", "Isilynor", "Jeardra", "Kethryllia", "Liluth", "Liluth", "Lura", "Lyndis", "Nushala", "Nyna", "Phyrra", "Pyria", "Pyria", "Rathiain", "Rubrae", "Rubrae", "Sariandi", "Sariandi", "Shandalar", "Sheedra", "Soliania", "Tsarra", "Urmicca", "Viansola", "Viansola", "Viessa" 


"elf female 2"
***************

.. code-block:: lua

   "Aegnimamiel", "Aegthalarrian", "Aelsereswë", "Aesthelalwen", "Aesthirthalel", "Aethinalien", "Aethloradroël", "Aethninerel", "Aethrinanwë", "Arninarwen", "Berseldamroël", "Berthelalmir", "Caelthirolwë", "Caerinoliel", "Calmarebedel", "Calmelevwen", "Carirolwen", "Celistaledel", "Celistebian", "Celmithelrian", "Celralthonian", "Clarlorebriel", "Clarmeredwen", "Clarmirenmir", "Earmindinel", "Elbralelwen", "Elmelalmir", "Elsaerevwë", "Erlinebiel", "Erlorebsil", "Errinamrial", "Ersarerriel", "Faerinerwen", "Faersarthonwë", "Faerthaeramsil", "Farlarenriel", "Farnirolian", "Feanmithessil", "Findraelanrien", "Galmelevien", "Galnimolloth", "Ganmirinroël", "Garlaranroël", "Garlorebrien", "Garranamril", "Gelniminrial", "Gilthalthonel", "Laegseldilrien", "Lendthaerammir", "Lindistalian" 


"elf male"
***********

.. code-block:: lua

   "Alduin", "Almon", "Anfalen", "Anfalen", "Anlyth", "Arbane", "Bellas", "Cluhurach", "Connak", "Connak", "Ellisar", "Ettrian", "Evindal", "Evindal", "Felaern", "Goll", "Goras", "Hastos", "Ilimitar", "Iliphar", "Ilrune", "Jannalor", "Jannalor", "Jannalor", "Jorildyn", "Kiirion", "Lathlaeril", "Maeral", "Maiele", "Molostroi", "Morthil", "Myrddin", "Myriil", "Myriil", "Nremyn", "Nremyn", "Nym", "Nym", "Nyvorlas", "Oenel", "Pelleas", "Pleufan", "Rilitar", "Rilitar", "Ruvyn", "Tehlmar", "Theodred", "Triandal", "Vesstan", "Vulluin" 


"elf male 2"
*************

.. code-block:: lua

   "Aegsaraddel", "Aegsilmendan", "Aelsindthonorn", "Aessindinlad", "Animadros", "Anisteddir", "Anmerildil", "Arimebros", "Aristedor", "Arlaremdil", "Armelthonlad", "Belthaelirnar", "Berthaerindan", "Caelmaegarrod", "Caelmindilion", "Caeltherenrior", "Cellarthonras", "Cirmindasdan", "Cirseralad", "Claristarfal", "Earmindirnar", "Ellarevdel", "Elmerindir", "Elthmaegarlas", "Elthnithevion", "Eolthelarthir", "Erlralthallad", "Ermiramras", "Estistthonrior", "Estlaranthir", "Faerlithemfal", "Feanseldesros", "Finimeddir", "Finmiraldir", "Finranarrond", "Galrindevfal", "Ganlarinion", "Ganrinderras", "Geliremor", "Gelmelesdel", "Gelrinadrond", "Gilmerarros", "Ilmrelarion", "Ilmrelednar", "Ilmrindthalfal", "Ilmserarros", "Lindinadros", "Lindraelasras", "Lindsarasros", "Lindseldenlad" 


"fetchling female"
*******************

.. code-block:: lua

   "Brezona", "Drasir", "Dregit", "Dridunoh", "Eceroh", "Ecohi", "Ehani", "Grakunuh", "Grutoti", "Ikitam", "Ilogal", "Jaza", "Jidola", "Mejo", "Metem", "Motuni", "Nakar", "Nenomi", "Nosuhim", "Oregune", "Oresumen", "Qiroma", "Qresucam", "Qrotoni", "Qrukir", "Siro", "Soture", "Tumol", "Ucaja", "Ucuhi", "Ugeculan", "Ugiden", "Ugiduri", "Ugisam", "Usedo", "Usejonar", "Utedel", "Utelurul", "Utisa", "Uvaluha", "Uvavune", "Uvonuro", "Xade", "Xehotim", "Xekuca", "Xenocot", "Yodunil", "Zagul", "Zamu", "Zegorot" 


"fetchling male"
*****************

.. code-block:: lua

   "Braje", "Brezi", "Brisu", "Brolu", "Dredom", "Dreloh", "Droral", "Druloh", "Ecedom", "Ecegut", "Ecezo", "Ecoke", "Ehasi", "Eheseh", "Eheso", "Ikasa", "Ikazol", "Ilerur", "Iletur", "Ilicor", "Iloveh", "Mide", "Mikon", "Moli", "Mude", "Muhah", "Naju", "Nisoc", "Nuvu", "Oralo", "Orinu", "Qehun", "Qeja", "Qujom", "Renu", "Sikum", "Sivu", "Soga", "Trahuh", "Trozu", "Truvuc", "Ucamo", "Ucegoc", "Ucumon", "Usejor", "Usiju", "Usizu", "Utagor", "Utenot", "Zazuc" 


"giant female"
***************

.. code-block:: lua

   "Bulirei", "Daoh-Saom", "DaohSaori", "DaohVuh", "Digrirei", "Doh-Ghad", "DohChah", "DohGheeghad", "DohHani", "DohHoo", "FahBaodbul", "Faoghtih", "Gham-Rei", "Ghish-Mih", "Kham-Mih", "Khanlah", "Khaztoudhtih", "Khem-Lah", "Lah-Baod", "Lah-Ghan", "LahVuh", "Lughdoh", "Maohlah", "Mih-Gonkh", "Mih-Maoh", "MihIg", "Mouhlughrei", "Mughlah", "Oughdaoh", "Ouh-Tih", "Pughmih", "Rei-Naoh", "ReiBuli", "Rifoodoh", "Roukrei", "Saomtih", "Shehisoh", "Snaohrei", "Soh-Hree", "Soh-Shul", "Teblah", "Tih-Giree", "Tih-Orf", "Tih-Ouh", "TihGonkh", "TihMogh", "TihTebnaoh", "Yauthdaoh", "Yauthig-Lah", "Zhamyauthdoh" 


"giant male"
*************

.. code-block:: lua

   "Ahgobbaod", "Baod", "Bul", "Buli", "Buli", "Dhakgunrighan", "Dum-Buri", "Eghi", "Eghi", "Ghan", "Ghee-Bohrkham", "Ghish-Shlo", "Ghug", "Giree", "Giree-Ghad", "Gonkh-Ehm", "Hah", "Hah", "Hanihaogh", "Hatoo", "Hoo", "Houm", "Hree", "Ig", "Kham", "Khaz", "Khem-Ahg", "Lughmogh", "Maohghish", "Nhamwah", "Ob-Rhoo", "Oli-Khan", "Orfsuth", "Pugh", "Puh", "Rahoo", "Ronkhghadhani", "Shehi", "Shehi-Shehi", "Shehi-Ub", "Shlo", "Shourehm", "Snaoh", "Snaoh", "Suth", "Ub", "Urush", "Yaum", "Yih", "Yih" 


"gnome female"
***************

.. code-block:: lua

   "Billeklinkle", "Binklitinkle", "Binklitinkle", "Bipsizz", "Bipvizz", "Bixdink", "Bixgus", "Bixgus", "Bonyulo", "Byloflink", "Carvizz", "Dindamink", "Ditinkle", "Elsizzle", "Fenflynk", "Filble", "Filble", "Fildilinkey", "Filliflink", "Glinkfinkle", "Glinkfinkle", "Glinkfinkle", "Gynnulo", "Juladink", "Katdomink", "Katlofizzy", "Katlofizzy", "Katlofizzy", "Kithdiwack", "Kithdiwack", "Klofizzy", "Klofizzy", "Lisble", "Lissgus", "Lokeefizzy", "Lokeefizzy", "Lymtink", "Lyssfizzy", "Lysthink", "Mitash", "Mitbus", "Mittledigo", "Mittlesizzle", "Nitly", "Syrbyfinkle", "Thenlinkey", "Thinbythin", "Tilkink", "Tilkitinkle", "Tynbrik" 


"gnome male"
*************

.. code-block:: lua

   "Babimac", "Balibik", "Balibik", "Baolink", "Bilkeefinkle", "Bimleeble", "Bimleeble", "Binaris", "Binaris", "Bolink", "Bonboris", "Buofinkle", "Buofinkle", "Buris", "Buwick", "Carlobrick", "Carlobrick", "Carlobrick", "Dimlank", "Dimlank", "Dinkbitank", "Dodibrick", "Donflonk", "Donflonk", "Donflonk", "Filbik", "Filbik", "Filgo", "Filkeewick", "Fillikink", "Finkvash", "Finsizz", "Gelklink", "Glinnus", "Hinklosizz", "Klobnk", "Laflink", "Lawizz", "Lolarn", "Mitash", "Nitdink", "Nitkeeklonk", "Pithosizz", "Teenkvash", "Tenkathink", "Tenlink", "Tocdeeflink", "Tolosizz", "Tomink", "Tovash" 


"gnome surname"
****************

.. code-block:: lua

   "Acerfizzle", "Acerkettle", "Berryspan", "Blacksprocket", "Blacktorque", "Castspanner", "Castspring", "Fastfuse", "Finecrank", "Finegauge", "Finestrip", "Finestrip", "Grinddwadle", "Grindspan", "Mechapipe", "Mechaspark", "Mechaspark", "Mechaspring", "Overwizzle", "Porterspring", "Puddlefuzz", "Puddlepipe", "Puddlespinner", "Sadbonk", "Sadspring", "Shinespinner", "Shinespring", "Shinestrip", "Shortspark", "Shortspark", "Shortspark", "Spannermaster", "Spannerstrip", "Sparkfuzz", "Sparkneedle", "Sparksprocket", "Springgear", "Sprysteel", "Steamgauge", "Steamwrench", "Stormgrinder", "Stormpipe", "Stormsteel", "Swiftsprocket", "Thistleblast", "Thistlenozzle", "Tinkfuzz", "Tosslespanner", "Tosslewizzle", "Wobblegauge" 


"goblin female"
****************

.. code-block:: lua

   "Adzay", "Azghy", "Bilgdokhgah", "Blokah", "Blotya", "Bolgy", "Chusnagghy", "Chuya", "Dokhgah", "Gady", "Gakya", "Gakya", "Ghorgah", "Ghorglakee", "Gity", "Glaky", "Grakghy", "Grakya", "Hige", "Khady", "Krigay", "Laggady", "Lakyarpay", "Mogghy", "Nagah", "Nazah", "Nazghy", "Nigah", "Nokzatay", "Pogee", "Ronkdufah", "Ronky", "Shrigflugghy", "Shrigslogya", "Slaigah", "Slaighy", "Snage", "Snagy", "Snamubee", "Snarkay", "Snigah", "Unkya", "Urfe", "Yaggy", "Yake", "Yige", "Zatah", "Zizglakee", "Zizurfgah", "Zordy" 


"goblin male"
**************

.. code-block:: lua

   "Achlig", "Akgar", "Arkhig", "Arksnat", "Balgsnig", "Blidlak", "Bloknikk", "Boornag", "Burk", "Driknikk", "Drizthus", "Fluggitblid", "Flugmurch", "Gak", "Garbalg", "Garspik", "Gatgliz", "Ghakshrigghag", "Ghakyip", "Glakskug", "Glatgad", "Gligog", "Grakshuk", "Gratun", "Gukglat", "Gukrat", "Lagark", "Laksnit", "Ligrkus", "Loznig", "Lunyark", "Mizblok", "Mogyak", "Mub", "Murroknogg", "Naggrak", "Nazrak", "Nukk", "Nurgah", "Pogmiz", "Ragmiz", "Shrigzat", "Skragstogg", "Sna", "Snarkus", "Sognad", "Unksna", "Yigrak", "Yipsna", "Zizguk" 


"half-demon female"
********************

.. code-block:: lua

   "Alurjiul", "Aziklihyl", "Azikrhyl", "Azikziu", "Azlihyl", "Braldiu", "Bralskiu", "Bruhdiu", "Draanlihyl", "Draanrhyl", "Drulggiu", "Haugziu", "Jhaaldiu", "Jhaalgiu", "Jurbau", "Jurdiu", "Jurgrula", "Jurizil", "Jurlyrr", "Jurrula", "Jurzanil", "Jurzskiu", "Karglihyl", "Kharkdiu", "Kharkgiu", "Krivdiu", "Krivzihyl", "Kuazjiul", "Luridusla", "Mulkziu", "Nidxhiu", "Ninjdusla", "Nymziu", "Rukziu", "Saagjiul", "Ulthuskiu", "Uznidgiu", "Uznidziu", "Virnnalu", "Vluzakija", "Vluzakxhiu", "Vulksula", "Xaurula", "Xauzihyl", "Xidlihyl", "Xuldiu", "Xurajgiu", "Zuvizil", "Zuvulla", "Zuvzihyl" 


"half-demon male"
******************

.. code-block:: lua

   "Aagdrul", "Aagzuk", "Alursalk", "Aziknal", "Bruhsul", "Idruzu", "Jiulurug", "Jurrul", "Jurzsul", "Kaazlank", "Kargdrul", "Kargull", "Krivull", "Kuaznal", "Kuaznal", "Kudunal", "Lurilun", "Lurirul", "Luriundak", "Mulksalk", "Nidrul", "Nymbru", "Ruklurr", "Rukrul", "Rulkruzuk", "Rulksul", "Ruzbru", "Ruzinu", "Skaurlurug", "Skaursalk", "Skaurull", "Ulthubru", "Ulthunal", "Urzdrul", "Uznidbru", "Uznidsuruk", "Uznidxulg", "Vlaajzu", "Vlagbru", "Vlagundak", "Vrazlurug", "Vulksul", "Vulksul", "Xaulurr", "Xauzuk", "Xidlurug", "Xidlurug", "Xidzu", "Xullun", "Zulduxulg" 


"halfling female"
******************

.. code-block:: lua

   "Amanda", "Amber", "Amber", "Bertha", "Bertha", "Brunhilda", "Camelia", "Camelia", "Chrodechildis", "Chrodechildis", "Diamond", "Elanor", "Erica", "Ermengard", "Esmee", "Fatima", "Goiswinth", "Gomatrudis", "Grace", "Gudule", "Gudule", "Jenna", "Jenna", "Kaitlyn", "Lanthechilde", "Laura", "Leesha", "Leesha", "Madison", "Marcatrude", "Marigold", "Melissa", "Mimosa", "Morgan", "Morgan", "Moschia", "Myrtle", "Myrtle", "Natalie", "Natalie", "Ragnachilde", "Ragnachilde", "Regnetrudis", "Regnetrudis", "Rotrud", "Shelby", "Teutberga", "Theoderada", "Theoderada", "Tiffany" 


"halfling female 2"
********************

.. code-block:: lua

   "Adily", "Adrice", "Aila", "Ailina", "Albia", "Albwisa", "Almia", "Amba", "Ambia", "Ambia", "Ambwisa", "Banda", "Blancina", "Blancwisa", "Boffa", "Boffwisa", "Boffwisa", "Bramice", "Bunga", "Erdia", "Erna", "Ernina", "Everwina", "Falca", "Ferda", "Ferdia", "Ferdwisa", "Frobice", "Gama", "Gamia", "Gamia", "Gamia", "Gamwisa", "Haldia", "Hama", "Hama", "Hama", "Hodina", "Iva", "Milia", "Munga", "Othwisa", "Samina", "Serla", "Tobia", "Wana", "Wanily", "Wigia", "Wyda", "Wydice" 


"halfling male"
****************

.. code-block:: lua

   "Adalhaid", "Angilbart", "Balbo", "Bero", "Bertin", "Bilbo", "Carambo", "Carambo", "Cassyon", "Corbus", "Dalfin", "Emme", "Erard", "Erard", "Erard", "Faro", "Fastred", "Giseler", "Goisfrid", "Guido", "Guido", "Guido", "Gundovald", "Guntramn", "Harding", "Hildebald", "Huebald", "Imbert", "Imbert", "Letard", "Letard", "Madoc", "Marachar", "Meriadoc", "Merimac", "Riquier", "Sadoc", "Samson", "Suidger", "Sunnegisil", "Sunnegisil", "Theudebald", "Togo", "Togo", "Unroch", "Unroch", "Waldolanus", "Waltgaud", "Willibrord", "Zwentibold" 


"halfling male 2"
******************

.. code-block:: lua

   "Adro", "Adrwin", "Ailo", "Ailold", "Albard", "Almo", "Almo", "Ambo", "Ambo", "Benald", "Bildwin", "Blancard", "Boffo", "Bombo", "Bombo", "Bombold", "Bombwise", "Drocfast", "Drocfast", "Droco", "Drogert", "Drogo", "Durlald", "Emmert", "Falco", "Falcwise", "Ferdert", "Ferdo", "Ferdo", "Frobo", "Fulbfast", "Gamald", "Gamold", "Hamo", "Hugfast", "Markald", "Marko", "Milo", "Milo", "Milwin", "Mungo", "Otho", "Samald", "Samo", "Samo", "Samo", "Serlo", "Tobert", "Tobert", "Wigard" 


"halfling surname"
*******************

.. code-block:: lua

   "Barrowes", "Barrowes", "Bilberry", "Boffin", "Boffin", "Bolger-Baggins", "Bramblethorn", "Brown", "Brown", "Brownlock", "Bunce", "Chubb", "Cotton", "Diggle", "Fairbairn", "Fairbairn", "Farfoot", "Fleetfoot", "Fleetfoot", "Fleetfoot", "Gammidge", "Goodchild", "Goold", "Greenhill", "Greenhill", "Greenhill", "Hayward", "Headstrong", "Hornwood", "Hornwood", "Hornwood", "Leafwalker", "Leafwalker", "Lightfoot", "Longfoot", "Noakesburrow", "Oldbuck", "Oldbuck", "Oldbuck", "Proudbody", "Proudbody", "Proudmead", "Proudmead", "Puddifoot", "Sandheaver", "Took", "Took-Took", "Twofoot", "Underfoot", "Underlake" 


"hobgoblin female"
*******************

.. code-block:: lua

   "Afre", "Afunga", "Afunge", "Beyha", "Beyre", "Ceylatot", "Darhara", "Darhore", "Dirdori", "Dirike", "Dirlite", "Esima", "Eslitu", "Esrati", "Esron", "Fetdori", "Fetlatak", "Hahu", "Hauko", "Kethdar", "Kethikuk", "Kolgde", "Kolgdorut", "Kurdora", "Mevluka", "Okema", "Okika", "Okika", "Oklitat", "Poldatar", "Poldunga", "Roldata", "Roldho", "Salteme", "Saltha", "Saltret", "Saltrimi", "Saltutom", "Tetma", "Turgike", "Utrar", "Zilddora", "Zildhore", "Zildme", "Zoldeme", "Zoldha", "Zoldhoro", "Zoldima", "Zoldra", "Zoldrimi" 


"hobgoblin male"
*****************

.. code-block:: lua

   "Akla", "Akla", "Akluk", "Akot", "Akrat", "Bekrim", "Dorram", "Dorram", "Dorrat", "Durri", "Fetla", "Fetla", "Fetom", "Hahor", "Harim", "Kethlut", "Kethrot", "Kolgrim", "Kurhar", "Kurom", "Kurrim", "Malghar", "Malgrim", "Mevla", "Mevok", "Okhor", "Okhor", "Okom", "Okom", "Okut", "Poldri", "Poldrim", "Poldrot", "Poldung", "Roldram", "Roldung", "Salttar", "Saltut", "Tetok", "Tetom", "Tetram", "Tottar", "Turgat", "Turghi", "Turgrat", "Turgrim", "Zildhi", "Zildri", "Zoldhi", "Zoldhor" 


"human female"
***************

.. code-block:: lua

   "Adoravena", "Adynne", "Aelfbrand", "Aelfthryth", "Aethelhere", "Aewbeald", "Arygata", "Baybeald", "Bayhild", "Bethida", "Betyvea", "Cwenhere", "Cyrasetta", "Cyrysena", "Deorbeorht", "Deorburg", "Duderaed", "Dudewig", "Ecgfrith", "Eilinubeth", "Elubrelaith", "Emelorin", "Eseld", "Godlac", "Godleofu", "Hildbrand", "Ida", "Isamira", "Islimira", "Ivaba", "Iverin", "Jenifer", "Ladoca", "Leodric", "Lowenna", "Melina", "Metheven", "Mildweorth", "Osgifu", "Poloth", "Salemina", "Salinne", "Strangheah", "Vorewen", "Waerbeorht", "Wigburg", "Wulfgifu", "Wuscfrith", "Xanurada", "Zubalaith" 


"human male"
*************

.. code-block:: lua

   "Aelfhere", "Aelfric", "Aelfsige", "Aelfstrang", "Aethelric", "Ansta", "Barldil", "Beorhthere", "Beorhtlac", "Bokfgund", "Cuthfrith", "Cuthstan", "Cynemaer", "Delthad", "Deorsnel", "Deorstan", "Eadbeorht", "Eadnyd", "Ealdraed", "Garwise", "Gerens", "Godsige", "Gringorn", "Herebeorht", "Herehard", "Hereleod", "Holenbeald", "Jaden", "Korphmnir", "Mahtwulf", "Meschael", "Mrin", "Osgold", "Osleod", "Ragtir", "Saegeat", "Saetndi", "Scrocric", "Sigeleod", "Sigewine", "Swetmaer", "Thiani", "Thurbeorht", "Torrand", "Uthno", "Wella", "Wictstan", "Wigfugol", "Zanbar", "Zanntir" 


"human surname"
****************

.. code-block:: lua

   "'Angel' Lamb", "'Baron' Natic", "'Hard' Abram", "'Lean' Kendall", "'Moody' Middleton", "'Smart' Jesomax", "'Stonearm' Reed", "Blackie", "Blanchflower", "Bones", "Cartuleius", "Catsillius", "Clemow", "Collier", "Doom-Foot", "Drake", "Fraellia", "Fraugrius", "Gifted", "Golden-Swords", "Hanouceius", "Hastcel", "Ildenius", "Ingmaldedottir", "Knottley", "Longfellow", "Lovvia", "Mildenhall", "Mothwode", "Natic", "Noall", "Pascoe", "Plenceia", "Quick", "Rose", "Royston", "Shurman", "Shurman", "Silver", "Slayer", "Small", "Stout", "Tangye", "Unseen", "Vellenoweth", "Viraey", "Wavrtinius", "White", "the Cook", "the Despicable" 


"ifrit female"
***************

.. code-block:: lua

   "Aly", "Athe", "Atheem", "Atwahura", "Ciya", "Emdu", "Emluty", "Emtwi", "Etyu", "Fatin", "Feemri", "Fuwu", "Guhuye", "Guqri", "Gurandre", "Guwu", "Hari", "Hidu", "Iren", "Irhi", "Irra", "Irrya", "Irtindri", "Ladre", "Lathe", "Leah", "Ledri", "Leenrhe", "Lemi", "Lerhe", "Lethis", "Letya", "Maqhi", "Nirlu", "Nithe", "Uqla", "Uqma", "Wilme", "Wiltara", "Wilthi", "Wumi", "Zedri", "Zedruwirh", "Zeen", "Zela", "Zeran", "Zery", "Zethis", "Zetwa", "Zurhan" 


"ifrit male"
*************

.. code-block:: lua

   "Ajig", "Ana", "Bajad", "Bavit", "Bugut", "Buja", "Darig", "Dera", "Eqej", "Evu", "Gajig", "Ganu", "Gilet", "Gimag", "Givan", "Jeke", "Jenu", "Jicut", "Jila", "Jime", "Kerat", "Kivaq", "Mafe", "Mane", "Mavug", "Mine", "Mucij", "Mucut", "Muluh", "Nejul", "Rakel", "Rikun", "Rilum", "Ruke", "Ruvaq", "Ruvin", "Take", "Teqej", "Terat", "Tevig", "Ucil", "Uvaj", "Varej", "Venim", "Vifim", "Viru", "Vurut", "Zakel", "Zaku", "Zaru" 


"infernal 1"
*************

.. code-block:: lua

   "Alu-ejfraz", "Avuruszul", "Baelarszul", "Baelyidromu", "Baz-uyrez", "Bazujalz", "Buz-jaalz", "Buzzuhruz", "Chazooxu", "Drevaghu", "Dromuolitha", "Druziutu", "Garuavkul", "Ghuoytzau", "Gla-ivbaz", "Guzyamau", "Gyaolgla", "Hraijhuz", "Hrauravu", "Hriz-avgle", "Hziarraal", "Hzilehriz", "Hziurhez", "Idrauyovuul", "Iuz-arghaa", "Ixu-zusau", "Juu-laziel", "Liluresau", "Lol-ojgaru", "Mauivyaa", "Raz-aviuz", "Razurrez", "Rezualbu", "Rhuuoloxu", "Ruloghau", "Saa-luyee", "Sauuzthalu", "Shai-zilurhz", "Soazajhuz", "Thouvru", "Thuruzuu", "Thuvuguz", "Tze-ziixu", "Tzeajgle", "Vuulruyee", "Zu-lujuu", "Zujemoz", "Zulozavu", "Zulozdromu", "Zuu-ujolth" 


"infernal 2"
*************

.. code-block:: lua

   "Aiglokleg", "Algluiub", "Algujhrud", "Bargrathaug", "Baugoykag", "Blogavnug", "Blogzuaab", "Boajaziug", "Drujjiulb", "Frubledraug", "Fulgozogg", "Fulgroxub", "Ghadlutrulg", "Heg-jomoab", "Hrag-ladruj", "Iggarthaug", "Iggleblog", "Iubruzugt", "Jub-rihaag", "Jubvilaug", "Julbuzfrub", "Kleguriub", "Kolgjorogg", "Kwargvafrub", "Laugejvogt", "Lolgerdregh", "Magojtrulg", "Maugijkolg", "Maugyuurb", "Mogojboaj", "Mogvaszug", "Nulbijtrob", "Nyogeytzolg", "Obbijblog", "Obbjunug", "Olb-arfrub", "Raagizshub", "Strogjonalb", "Strogvodregh", "Strogvugrolb", "Strogzemoab", "Stuguvdroog", "Tharguljulb", "Thaug-jixub", "Trobvogub", "Vogtliulb", "Vulbijurb", "Zug-riurb", "Zugtaykleg", "Zugullolg" 


"infernal 3"
*************

.. code-block:: lua

   "Acholsaur", "Akkijgaan", "Ashoznirr", "Azt-rugek", "Bahorlublik", "Baruylisk", "Boakovbahor", "Dakersot", "Dunuyyalm", "Dunuzsutt", "Gaanujirsch", "Gauryumat", "Haerxvanam", "Hrekuzgaan", "Igm-ivbor", "Inax-yovrok", "Irscharnirr", "Khor-rogaur", "Laztazvrok", "Lith-vuroth", "Lokliigm", "Lothlethak", "Lothojroth", "Lothuvvach", "Luthlumat", "Metzobar", "Mothajglaur", "Mothovruun", "Muth-yilazt", "Muthjebor", "Nazt-uroth", "Naztjablik", "Nilvozuzt", "Nilvuvloth", "Nilvzasot", "Rothuyazt", "Rothzagoch", "Slythevrutt", "Sothyokrych", "Sutt-arszut", "Suttajgaur", "Suttovlok", "Szutvaroth", "Tashviach", "Thakyakrych", "Tlizit-eyoch", "Tlizit-laner", "Tlizitojglaur", "Urtrusot", "Uztyeyalm" 


"kobold female"
****************

.. code-block:: lua

   "Aakrundu", "Aaku", "Aali", "Aasus", "Adak", "Adgu", "Ador", "Akas", "Esgru", "Esiskuk", "Esralku", "Ezra", "Fileros", "Fisoo", "Garazso", "Garin", "Harri", "Ila", "Likasral", "Lulkatro", "Maralsus", "Masis", "Mazra", "Misgarsi", "Mosro", "Nodu", "Nogrugaros", "Parsra", "Parsro", "Radu", "Rollis", "Sadil", "Sadlisas", "Sasoo", "Sizor", "Sizsru", "Sokguku", "Sokin", "Taraz", "Tolsra", "Ueh", "Uli", "Varidu", "Vaseor", "Vasko", "Vishoo", "Vishoo", "Viszok", "Vokrunsra", "Vokuk" 


"kobold male"
**************

.. code-block:: lua

   "Akholkxas", "Akog", "Croxah", "Croxik", "Croxrooah", "Crudhik", "Dhelmaap", "Droxzi", "Drunal", "Eaapda", "Eanalpze", "Gakmakog", "Geme", "Ilma", "Ilod", "Jair", "Jeodrad", "Jozen", "Kibld", "Kibzax", "Molmazax", "Orlazor", "Orrad", "Orzikolk", "Orzo", "Qetrad", "Qraalkolk", "Qraarma", "Qranri", "Qrarib", "Qrarzadik", "Qrazep", "Qrilanzor", "Qrilhark", "Qrilnalp", "Rildhik", "Rusrad", "Vaddoo", "Vadld", "Verud", "Veze", "Vhopkolk", "Vipan", "Viperkra", "Vipod", "Vipzen", "Vipzinda", "Votiban", "Votog", "Zoarras" 


"ogre female"
**************

.. code-block:: lua

   "Arghshudghy", "Boggomah", "Burzglubya", "Burzmolgya", "Dofgruldrubya", "Duzmaugghy", "Faugsludgah", "Faugyury", "Ghulmolgya", "Glubsnaday", "Glugdofah", "Groggshugy", "Grolsnogah", "Grufdofya", "Grumfrolbay", "Grumfrukhy", "Grumfshudy", "Haisnogay", "Klobsnogghy", "Krodglugya", "Kugsluggah", "Kulklushluggah", "Lorgdubya", "Lurzmauglukhya", "Lushgulvay", "Molgshugruzay", "Mudsnadghy", "Mugtrugya", "Nakhghashay", "Nargfaugah", "Obbdulya", "Rolburya", "Rukhgrumy", "Shruflorggah", "Shrufmakhya", "Shudlorggroggay", "Shudmuzdah", "Shudulgya", "Shurshrufah", "Snogglugshuzy", "Snoggomgrobya", "Thurknakhya", "Thurkurday", "Ulggrukay", "Urdmugy", "Urghrukhy", "Urkhghukkay", "Urkhlorgghy", "Urkhmulghy", "Zugghorah" 


"ogre male"
************

.. code-block:: lua

   "Burzghar", "Dofgrul", "Dofnakhkai", "Dugmaug", "Dulghul", "Durshhrung", "Duzmug", "Faugmuzd", "Fugshurgulv", "Ghakhsnad", "Gholglud", "Ghorkulk", "Ghulglug", "Gludkulk", "Gluzdush", "Gluzgrul", "Grokyugdug", "Guhlglud", "Guhlhai", "Guhlmaug", "Gulvghash", "Gulvkai", "Haidrok", "Hrungdushghukk", "Krodmaug", "Kulkghar", "Lorglurz", "Lugduz", "Lushdrok", "Lushghol", "Makhdub", "Maugduz", "Mudghar", "Murkdub", "Murkluz", "Nakhslub", "Rukhkur", "Shargrukh", "Shrufnakh", "Slubdrug", "Sluggrum", "Snogkrod", "Snogmug", "Trugghor", "Trugkug", "Ulgmaug", "Ulgurd", "Urghrukh", "Yurslub", "Zudlum" 


"orc female"
*************

.. code-block:: lua

   "Bagrzush", "Bashramph", "Basht", "Bashuk", "Bogdakh", "Bogdk", "Bogdub", "Boladurz", "Bolar", "Bora", "Bugdurash", "Dulug", "Ghorza", "Glob", "Gonk", "Grat", "Grat", "Gratzush", "Grazob", "Gul", "Kharash", "Lagakh", "Lagakh", "Lash", "Lazrak", "Mazoish", "Mogak", "Mogak", "Murbraz", "Murzush", "Oghash", "Orbugol", "Rogmesh", "Rulnakh", "Rulurz", "Shal", "Shazgob", "Shel", "Shel", "Sloesh", "Ugakkh", "Ugozush", "Ulorz", "Umog", "Umog", "Urog", "Ushat", "Ushat", "Yazgash", "Yotul" 


"orc female 2"
***************

.. code-block:: lua

   "Augglazy", "Auggruday", "Augzahkghy", "Bazbashay", "Bazgnubay", "Bruzsnorldargya", "Daglakhay", "Dagsnurray", "Dugstulgay", "Ghazumshgah", "Gloldagya", "Glufgrudghy", "Glufhrugah", "Glurskulggah", "Gokhbagay", "Golkgory", "Golroggdargghy", "Gorgnubgah", "Grakhhratah", "Grathglolay", "Grothagshadghy", "Grubmuzghy", "Gutglakhay", "Gutrotya", "Hagduray", "Hagthakah", "Hrogguthrugay", "Lashlobay", "Lubumshah", "Lukbakhghy", "Lukdogglakhay", "Molkbroggnubgah", "Rashgrubgah", "Rashrutya", "Shazuthay", "Skarhrogya", "Skarlubraggah", "Snubroty", "Sodhrugay", "Stulgsnorlghy", "Thakglury", "Trogguty", "Trogshogah", "Ugrudy", "Umshgolkah", "Umshhagah", "Uthkhaggah", "Yashgrashay", "Yobgobdrabya", "Zahkgokhlukah" 


"orc male"
***********

.. code-block:: lua

   "Abghat", "Bogakh", "Bragulakh", "Broamph", "Broburz", "Buruub", "Durbrag", "Frug", "Ginug", "Gnadug", "Grogmar", "Hugmug", "Hugmug", "Igmut", "Khadhulakh", "Krog", "Lurdumph", "Lurodum", "Mahk", "Malkg", "Mashkul", "Mashkul", "Mug", "Mulfutto", "Murmash", "Nag", "Nagrmborz", "Nagrutto", "Olfibob", "Olmthu", "Olpel", "Olurgash", "Peghed", "Peghed", "Podagog", "Shamrkub", "Shelhakh", "Slapdud", "Ulmat", "Ulmuong", "Ulmuong", "Urgan", "Urulkil", "Ushbumol", "Welub", "Yadba", "Yalakgh", "Yargron", "Yatg", "Zlughig" 


"orc male 2"
*************

.. code-block:: lua

   "Agbaz", "Baghrog", "Bakhshaz", "Bakhslur", "Bashzahk", "Blagthak", "Darggor", "Dobsnurr", "Doguth", "Drabbag", "Drabgluf", "Ghazruft", "Glazrogg", "Glufgnarl", "Glurshad", "Gnashluf", "Gnashsnorl", "Gnashtrog", "Gnubgrud", "Gobkrud", "Gokhbad", "Gokhbakh", "Grakhrug", "Grashhrog", "Grashumshsnub", "Grudnar", "Gudskulg", "Hratghaz", "Hratgolk", "Hrogskulg", "Hrogzog", "Hrugskulg", "Khaglash", "Khargrath", "Molkbad", "Molkgokh", "Olggol", "Ragshaz", "Roggstulg", "Rugmolk", "Shadgud", "Shakaug", "Shogrogg", "Slurogg", "Snorlgnash", "Snubdrab", "Snurruth", "Yakhbaz", "Yakhghazgash", "Yakhmuk" 


"orc surname"
**************

.. code-block:: lua

   "Atulor", "Atumlg", "Azolor", "Azolor", "Bagrol", "Bargzuf", "Barlob", "Basilslag", "Boghush", "Boghush", "Bogrug", "Broog", "Bumpshnar", "Bumrolg", "Burbba", "Burbrag", "Burbrzog", "Dugk", "Duguh", "Dulamgog", "Dushnar", "Gashur", "Gasrak", "Gholarn", "Hubor", "Lagdra", "Loghgarn", "Logkh", "Logozor", "Lumdborgob", "Lumoim", "Magrlob", "Mashma", "Mogan", "Moghku", "Muzgob", "Ogdmakh", "Ogduborgob", "Orbuduk", "Orkgramph", "Orkumba", "Shadra", "Shadra", "Shubbog", "Shubnag", "Traamph", "Trairbag", "Ulab", "Yagbu", "Yarzak" 


"oread female"
***************

.. code-block:: lua

   "Bhedema", "Bheef", "Bhisy", "Bistye", "Dehfhu", "Dehthe", "Ghalshudhi", "Ghimilha", "Ghimu", "Ghofnhi", "Ghoftyeny", "Haan", "Hinno", "Hussha", "Lecu", "Leef", "Lena", "Nanrinny", "Nury", "Nushecha", "Nussha", "Nydhefa", "Oryotho", "Pasifhesnus", "Pasle", "Pimthovo", "Pohcholha", "Pohma", "Povofhes", "Refafhi", "Rheru", "Rhesha", "Rhesthefhu", "Rhestisi", "Rhetheshunen", "Rohma", "Sanyu", "Sase", "Shalchaty", "Shalcih", "Shalthinnhi", "Sirno", "Sumsy", "Tomcho", "Tucihfhes", "Tuma", "Vacu", "Voscha", "Vosryofhi", "Vuse" 


"oread male"
*************

.. code-block:: lua

   "Ahanvum", "Annandum", "Bonlen", "Bothonnan", "Gandonta", "Gunretdom", "Irrinlah", "Jahom", "Jaluhom", "Jalunmum", "Javy", "Jeylenhet", "Jonnanthu", "Junlodhet", "Junvror", "Lalhomlu", "Lolhomdum", "Lollu", "Lordum", "Lundan", "Malvu", "Menvymim", "Monnat", "Monvumdur", "Nandum", "Nathonlu", "Nudlod", "Nudthurer", "Nulhomrud", "Olvirvum", "Olvros", "Olvu", "Ondarnan", "Ontarvhar", "Pordol", "Porhet", "Rundum", "Runtys", "Semal", "Sivum", "Solthuntor", "Suhva", "Sulvhatvros", "Tofo", "Tyhundum", "Voman", "Vomvum", "Vyvror", "Yllahta", "Ylmondar" 


"sprite female 1"
******************

.. code-block:: lua

   "Dexirel", "Flaxafer", "Flaxarel", "Flimamer", "Flimenti", "Flissamer", "Fossasti", "Friskefer", "Friskenti", "Friskerel", "Friskinel", "Frisserel", "Gessafer", "Glanamer", "Glanarel", "Glanimer", "Glissamer", "Lissirel", "Minanel", "Minirel", "Miskamer", "Raffasti", "Raffenti", "Riffamer", "Riffenti", "Rillafer", "Rillasti", "Saffamer", "Saffamer", "Safferel", "Shimefer", "Shimirel", "Tinkarel", "Tissarel", "Tristirel", "Twispamer", "Twissanel", "Twissarel", "Twissasti", "Twissasti", "Twixasti", "Twixifer", "Twixirel", "Twixirel", "Weskerel", "Winnanel", "Winnefer", "Winnenti", "Winnimer", "Winnirel" 


"sprite female 2"
******************

.. code-block:: lua

   "Cryltiss", "Elsiliss", "Embermee", "Emberriss", "Esktiss", "Eskynx", "Feristiss", "Frimiriss", "Glinkla", "Halkiss", "Halliss", "Iphildee", "Iphilkiss", "Iphilniss", "Iphilynx", "Ispelliss", "Ispelnyx", "Ispelriss", "Ispelsa", "Istleriss", "Istleriss", "Jatla", "Jostniss", "Jostniss", "Jusla", "Justiss", "Jusynx", "Lirraliss", "Malisa", "Minkliss", "Minkliss", "Minkliss", "Minksa", "Mirramee", "Ninkaynx", "Orifla", "Perimee", "Perimee", "Sprinsa", "Stithliss", "Stithmee", "Stithniss", "Tansila", "Tirrala", "Tirrariss", "Tirrariss", "Trumpnyx", "Whistiss", "Zandola", "Zandotiss" 


"sprite male 1"
****************

.. code-block:: lua

   "Dexando", "Dexaroll", "Dexeroll", "Flaxamo", "Flaxaron", "Flimaldo", "Flimaron", "Flissaron", "Flixesto", "Fossaldo", "Fossasto", "Fossondo", "Friskeron", "Gessamo", "Gessaron", "Gesseron", "Glanallo", "Glaxamo", "Glaxamo", "Glaxasto", "Glaxesto", "Glimeroll", "Glissaroll", "Glissondo", "Gossaron", "Gossasto", "Hexesto", "Raffando", "Rafferon", "Ressendo", "Riffando", "Riffasto", "Saffamo", "Shimeroll", "Shimeroll", "Tinkallo", "Tissamo", "Tissaron", "Trillaroll", "Trillaron", "Tristondo", "Twillondo", "Twispamo", "Twisseroll", "Twissesto", "Weftasto", "Weskaldo", "Winnando", "Winneroll", "Winneroll" 


"sprite male 2"
****************

.. code-block:: lua

   "Brisfrell", "Crylbrix", "Elsibrix", "Elsitwik", "Elsiwin", "Embermit", "Ferisfret", "Ferisrix", "Frimitwik", "Ganmist", "Glinkbik", "Halzisk", "Helrix", "Histkin", "Histwin", "Iphilrix", "Iphiltross", "Iphilwin", "Iphilzisk", "Ispelrix", "Ispeltross", "Istlemist", "Jatbik", "Jatfrell", "Jattwik", "Jostbik", "Justross", "Lirratwik", "Lirrawin", "Malitross", "Minkmit", "Ninkabik", "Ninkatross", "Oriftross", "Oriftross", "Orisbik", "Orisrix", "Orisrix", "Perikin", "Perimist", "Perimit", "Peritross", "Sprinmist", "Stithmist", "Tansibrix", "Tansikin", "Tirrakin", "Trumpkin", "Trumpkin", "Whisbrix" 


