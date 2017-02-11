|MIT|

.. |MIT| image:: https://img.shields.io/badge/License-MIT-yellow.svg

LuaNameGen - Lua Name Generator v1.0.0
=======================================

What if, instead of Bilbo and Frodo, Tolkien's characters were named Bill and Fred?

Or if, during the climax of a role-playing session, you face an Ancient Red Dragon called Bob...

That should be enough to justify this script.

Embark in this (meta)adventure, the quest for name generation!

Free the syllables. Create fantastic names. Have fun. Provide fun.

Fork. Fix. Pull request. Register issues. Contribute.

Let's make it the **One Generator to rule them all**.

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


* "celestial female"

.. code-block:: lua

   "Adrasteleth", "Ar-talas", "Ar-valkar", "Aranet", "Asaneseth", "Astarer", "Atlaneth", "Avareseth", "Avlantenth", "Avraleth", "Jal-sarat", "Jal-varat", "Jasalenth", "Jasaner", "Jasarmeth", "Jasarmeth", "Kalades", "Kalares", "Kalasenth", "Kalases", "Kalaster", "Kavalel", "Klarones", "Paladereth", "Paloreleth", "Palorer", "Ral-amar", "Ranalen", "Ranaren", "Saraner", "Sarateth", "Sardareleth", "Sardareth", "Sarnateleth", "Talasenth", "Taranenth", "Taranet", "Taraneth", "Tavaleth", "Valanten", "Valdoreleth", "Valdoreth", "Valkareth", "Valnarer", "Valnareth", "Vanarel", "Var-varan", "Varaleth", "Varaleth", "Varaneth"

* "celestial male"

.. code-block:: lua

   "Amadas", "Amaral", "Amartas", "Amartathal", "Ansamal", "Aradath", "Aradath", "Aramathar", "Asarnas", "Atarat", "Jaranath", "Jasalath", "Jasanath", "Javralanth", "Kaladathal", "Kalarath", "Kalarathar", "Kalasal", "Katarnath", "Kavalath", "Klaronan", "Klaronanth", "Pal-sarat", "Paloral", "Paloral", "Palorath", "Ral-varan", "Ranarathar", "Rasanas", "Ravanar", "Ravanathal", "Samaras", "Saranathas", "Sardanath", "Sardaranth", "Talasathar", "Talonas", "Taranar", "Taranathar", "Tavalath", "Valdorath", "Valmaranth", "Valmarath", "Valmarathal", "Valnoras", "Vanarat", "Varamathar", "Varanath", "Varatan", "Varatan"

* "dark elf female"

.. code-block:: lua

   "Burpansyliza", "Burpellivrin", "Burrellivira", "Bursolisra", "Charsabiddril", "Charyasralene", "Chorvrilralbra", "Denilenhel", "Deorelhel", "Dolorgrinbra", "Dolothdylhel", "Dorpansylvra", "Dorvorsinsil", "Dromtorlavdril", "Dultulralil", "Dulvolsylra", "Durseklenistra", "Dursulralia", "Enolgdylira", "Ensunleviza", "Gulorlivlin", "Gultulsylith", "Gulyolsinhel", "Insnyllenistra", "Istvillivith", "Jegsuldylna", "Jendolgraldra", "Jersusilith", "Kilthalrilira", "Kilyelralbra", "Lilrharaene", "Lilyaspellin", "Lulvolraistra", "Marvireltra", "Mazsolralvril", "Mazsolsyllin", "Mernilrailn", "Mezrellinbra", "Mezrusyldra", "Mezsabpelia", "Mezsullinia", "Mezvrilralna", "Molnylenra", "Molvrillivith", "Morvirlivdril", "Norolgsylene", "Nothorradril", "Olnesindra", "Oltelleviza", "Oltulendril"

* "dark elf male"

.. code-block:: lua

   "Balsablinrid", "Bursoliluld", "Burtorpirnaz", "Chartullenul", "Chormyrpirvim", "Choryolervir", "Colyasravim", "Divvorilird", "Dolorgiseld", "Dromporisnim", "Dulnellivnim", "Dulrhasinnid", "Dulverpirriv", "Eilnelavnim", "Eilonpelnid", "Eilsinlinvid", "Enorgerrim", "Gonvorerul", "Gulsunsyluld", "Gultelpirrim", "Imrelsylriv", "Imyellavrim", "Insvrilrinrim", "Istvorrilird", "Jegrhaennaz", "Jendsulpirvim", "Jendyasisviz", "Jerrelilrid", "Jysnylilald", "Jyssusrinnid", "Kilolgelul", "Kilporrinul", "Kiltenralvir", "Lilpanlivviz", "Lilrhapirriv", "Lilrurilnil", "Lilsolraid", "Lulpellevul", "Lulsolisrid", "Lulyolrinird", "Mabtorsylnim", "Martorrinid", "Marvirpirid", "Merothisrim", "Meryaspiruld", "Mezsussinnaz", "Molorpirild", "Mornilrallim", "Nothpanilird", "Nothvekidnid"

* "dragon female"

.. code-block:: lua

   "Adastraxenoris", "Adramanthysa", "Adravorunga", "Ancavoraxis", "Andravorunga", "Archoborossa", "Archocalchaxis", "Atravoraxis", "Barazzemalis", "Barzzebraxis", "Berumalaxis", "Berunaluxis", "Bhakrivorunga", "Bhakrizzebraxis", "Biamalaxis", "Biamanthysa", "Brimamordaxis", "Brimamordaxis", "Cadranadralix", "Chromordaxis", "Chroneriaxis", "Chroxenoris", "Harborossa", "Harcalchaxis", "Harlagonis", "Harzzemalis", "Iulzzebraxis", "Jarzemmalaxis", "Jazrazuthraxis", "Jurgamandrossa", "Keruxazzemalis", "Lazulomandrossa", "Majuribazia", "Majurinadralix", "Melkarcalchaxis", "Melkarxenoris", "Peridomordaxis", "Peridoxenoris", "Phrixuzuthraxis", "Porphyrovoraxis", "Rhadavorunga", "Rhodomanthysa", "Sarbazia", "Scarvabazia", "Skhiamandrossa", "Tchalcedocalchaxis", "Tchalcedomalaxis", "Tchalcedozuthraxis", "Trochocordaxis", "Zalarvoraxis"

* "dragon male"

.. code-block:: lua

   "Abramandros", "Abrazuthrax", "Adravorung", "Ancazuthrax", "Aragphylax", "Baralagon", "Baranalux", "Beruzzebrax", "Bhakribazius", "Bhakrivorax", "Bracalchax", "Bradocordax", "Cadrabazius", "Cadramalax", "Chrobradax", "Chrovorax", "Glaumandros", "Heliobradax", "Iulcordax", "Jurgacordax", "Lazulomandros", "Lazuloxenor", "Marmoracordax", "Marnadral", "Melkarnadral", "Peridoxenor", "Pyravorung", "Pyraxenor", "Pyrazuthrax", "Rauboros", "Raumandros", "Rhexenor", "Rhezzemal", "Rhodocordax", "Rhodonalux", "Sarbradax", "Sarcumalax", "Sardanadral", "Sarzzemal", "Scarvamanthys", "Scarvavorax", "Sidereobradax", "Sidereomanthys", "Skhianadral", "Sulchrulagon", "Tchalcedobradax", "Vramalax", "Vraxenor", "Zalarmandros", "Zalarmanthys"

* "dwarf female"

.. code-block:: lua

   "Aiess", "Alfra", "Anhild", "Arra", "Bafra", "Bamala", "Boali", "Bomnuda", "Bomvara", "Brilleras", "Dalinda", "Danbida", "Dandy", "Darnda", "Degra", "Duerla", "Dwaov", "Dwaryn", "Dwatuna", "Ferila", "Feya", "Fredrotha", "Funla", "Garbida", "Glotha", "Grodmila", "Grody", "Gwargra", "Henden", "Jama", "Kilaani", "Kilnuda", "Lasryn", "Lesthel", "Lota", "Minuda", "Nagnon", "Raskala", "Rasma", "Rasya", "Renmae", "Ridy", "Senev", "Svaritza", "Tardy", "Tarnda", "Thiba", "Thrata", "Vongra", "Vonnda"

* "dwarf female 2"

.. code-block:: lua

   "Bordga", "Brokkris", "Bromrun", "Bruis", "Burldis", "Burlrun", "Daldis", "Daldis", "Dolgis", "Dorlis", "Dormrun", "Dormvis", "Dorrun", "Durbis", "Durnhild", "Fromdis", "Fuldga", "Fundlif", "Gimrith", "Gimrun", "Glodis", "Gondlis", "Gondnis", "Gormlind", "Gormvis", "Guldhild", "Gundris", "Gundris", "Horddis", "Hornhild", "Hornna", "Hornrun", "Nalif", "Nordnis", "Norris", "Stornlif", "Strombis", "Stromis", "Sturbis", "Sturlvis", "Sturris", "Sundrun", "Thorga", "Thorndis", "Thornna", "Thornrun", "Throrris", "Throrrith", "Thruvis", "Thunddis"

* "dwarf male"

.. code-block:: lua

   "Anthur", "Aran", "Belmun", "Bobil", "Bomthur", "Bomur", "Darfri", "Dethur", "Devi", "Duerrin", "Duevim", "Dunur", "Duvi", "Duvin", "Dwoggamri", "Figin", "Firan", "Frebur", "Funchar", "Gamdir", "Gamfri", "Glothur", "Gramthrun", "Gremryl", "Gwarbil", "Hokig", "Jorvim", "Kaden", "Kanur", "Kaun", "Kildir", "Kraide", "Lodur", "Lovi", "Marbin", "Nalvri", "Ori", "Rasran", "Renbin", "Renulf", "Svun", "Tavin", "Thaggat", "Thardunli", "Tormur", "Triarol", "Vagrin", "Vonun", "Welin", "Zeliban"

* "dwarf male 2"

.. code-block:: lua

   "Balli", "Balnir", "Bordin", "Brimbor", "Brodri", "Brodror", "Brokkvor", "Bromri", "Bromrin", "Brurin", "Burlri", "Dolgbor", "Dormin", "Dorrok", "Dorrur", "Drimvi", "Dromvi", "Durmin", "Durvir", "Fuldin", "Fuldnir", "Gimir", "Gondin", "Gordli", "Gordri", "Gordvir", "Grimri", "Grodli", "Gromin", "Gromvi", "Gundror", "Hordli", "Horndin", "Hornin", "Hornli", "Hornri", "Hornrin", "Hornrur", "Hrarur", "Ormin", "Skondli", "Stornlin", "Stromlin", "Sturlbor", "Sturlbor", "Sundrin", "Thorri", "Thorrur", "Throbor", "Thrordin"

* "dwarf surname"

.. code-block:: lua

   "Bearslayer", "Blackspike", "Bloodpike", "Boarbutcher", "Boarmauler", "Coalcutter", "Coalfist", "Coppercrusher", "Copperfist", "Dragonburner", "Elfstriker", "Fairspike", "Fierybrand", "Fieryhammer", "Foebutcher", "Gemminer", "Gianteater", "Giantslayer", "Gnomekicker", "Goblinslicer", "Goldenheart", "Goldenspike", "Granitefoot", "Hammercarver", "Hammerfist", "Hardaxe", "Ironbender", "Ironhand", "Marbledigger", "Mithrilcutter", "Mithrilfist", "Mithrilforger", "Noblechest", "Noblefoot", "Ogre-Fighter", "Ogre-Strangler", "Ogreburner", "Onyxfoot", "Orc-Beheader", "Orcchoker", "Rockcarver", "Silvermace", "Spidermauler", "Spiderpuncher", "Steelsword", "Stoneblade", "Stonepick", "Whitefinger", "Wolfslayer", "Wyvernstriker"

* "elf female"

.. code-block:: lua

   "Alea", "Alea", "Alea", "Alyndra", "Alyndra", "Alyndra", "Amlaruil", "Anarzee", "Axilya", "Braerindra", "Caerthynna", "Chandrelle", "Chomylla", "Daratrine", "Daratrine", "Darunia", "Darunia", "Deularla", "Eirika", "Elanil", "Elanil", "Elmyra", "Eloimaya", "Eloimaya", "Faraine", "Faraine", "Faraine", "Ilmadia", "Ilmadia", "Isilynor", "Iythronel", "Liluth", "Lixiss", "Lixiss", "Lura", "Lymsleia", "Lyndis", "Nushala", "Nushala", "Nushala", "Nyna", "Pyria", "Sariandi", "Sariandi", "Sariandi", "Shalana", "Sheedra", "Syndra", "Wynnter", "Wynnter"

* "elf female 2"

.. code-block:: lua

   "Aeglitharloth", "Aegserileth", "Aelnimaredel", "Aelninevloth", "Aelrindadriel", "Aelseramiel", "Aelthaerevwë", "Aesseldirriel", "Aesserevwen", "Arrimaledel", "Belsaereneth", "Bermindarriel", "Caelseredmir", "Caelserthaleth", "Caelthaerevian", "Caermaegolrial", "Caermithadien", "Caermithirmir", "Caerthalebril", "Calmarinmir", "Caristasrial", "Carranarwen", "Cirlirelwen", "Cirloralwë", "Cirnirthalsil", "Cirtherenwen", "Clarirareth", "Cristheresiel", "Elrinansil", "Elrinilroël", "Eolloralien", "Eolraeladroël", "Eolsaeramwen", "Eolsilmolroël", "Erlrilevwen", "Estlirevedel", "Estmirilsil", "Faerinadriel", "Findirthaliel", "Finrilinrien", "Galmireveth", "Ganrinolrial", "Ganseldarril", "Gilraninriel", "Gilranthalroël", "Ilmmelaliel", "Ilmrindamroël", "Lendsaeransil", "Lendtheremriel", "Lindmaegarmir"

* "elf male"

.. code-block:: lua

   "Ailluin", "Anfalen", "Anlyth", "Bellas", "Bellas", "Connak", "Connak", "Connak", "Connak", "Dakath", "Fhaornik", "Fhaornik", "Folmar", "Folmar", "Hagwin", "Ilimitar", "Ilimitar", "Iliphar", "Iliphar", "Inialos", "Inialos", "Jannalor", "Josidiah", "Juppar", "Kendel", "Melandrach", "Morthil", "Mythanthar", "Nym", "Nym", "Oenel", "Olaurae", "Orist", "Pelleas", "Phaendar", "Pleufan", "Pleufan", "Respen", "Rhys", "Riluaneth", "Riluaneth", "Ruvyn", "Shaundyl", "Taegen", "Thalanil", "Theodred", "Theodred", "Triandal", "Vulmon", "Xhalth"

* "elf male 2"

.. code-block:: lua

   "Aegthaelamion", "Aelthaelebdir", "Aermelendan", "Aersilevras", "Aesthaleddel", "Aethmelthallad", "Aethnitholfal", "Aethsarerrond", "Anmithadlin", "Arninerdir", "Arrilarlin", "Arrinarlin", "Belmindellin", "Belnithirdir", "Carlarilros", "Celimedfal", "Cellirthalros", "Cirnirardan", "Cirseldesros", "Clarrinebnar", "Crislithildir", "Crismithelion", "Cristhaeremrior", "Earrelesros", "Earthalelrond", "Elbthaerirlin", "Elliralthir", "Elthmitholrod", "Erinelad", "Erlarendil", "Estloranion", "Estrinallad", "Faermerilion", "Farlorthonion", "Feansarasfal", "Findthaerebdil", "Garrelevion", "Gelirasdan", "Gelmirenrond", "Gelnimalrior", "Ilmirevdil", "Ilmnimthalros", "Ilmralamrior", "Ilmriminnar", "Ithlarerthir", "Ithmitheldir", "Lendnithinion", "Lendraelevion", "Lendsilmadrior", "Lindisterthir"

* "giant female"

.. code-block:: lua

   "Beeghsoh", "Bulfah", "Daoh-Mughkhem", "Daoh-Yeeh", "Doh-Digrinaroo", "Fah-Hatoomogh", "Fah-Pogh", "Fah-Ronkh", "Fah-Suhi", "Fah-Suth", "FahBeeghbaod", "FahNham", "Faoghbeegh-Fah", "Gunri-Rei", "Hani-Rei", "Heghidoh", "Khem-Daoh", "Khuri-Soh", "Lah-Hah", "Lah-Ronkhdigri", "Lah-Snaohfeehm", "LahPogh", "LahYeehig", "Meh-Lah", "Mih-Heghi", "MihGhahghaw", "MihSuhi", "MihTregh", "Nuhdoh", "Obdaoh", "Orf-Soh", "Orflah", "Rei-Buri", "Rei-Gunri", "Rei-Khee", "ReiGhad", "ReiGonkh", "ReiWuh", "Rhoosuhi-Tih", "Roukdoh", "Soh-Rhoomogh", "SohYuhob", "Tih-Ehm", "TihOrfghammugh", "TihOuh", "TihSuth", "Toudh-Fah", "Tuhli-Doh", "Vuhpuh-Fah", "Yeehsoh"

* "giant male"

.. code-block:: lua

   "Baod", "Baod-Wuh", "Chah-Khangham", "Dhak", "Dum", "Dum", "Eghigoush", "Ehm-Suth", "Faogh", "Feehm-Yih", "Ghug-Mugh", "Giree", "Giree", "Goushghad", "Gunri-Shom", "Hah", "Hah-Khaz", "Hatoo", "Heh", "Heh", "Heh-Thom", "Houm", "Igroukig", "Khan", "Khanlugh", "Lugh-Rifoopugh", "Mogh", "Naoh", "Orf", "Peh", "Poghsuhi", "Puh", "Rhoo-Giree", "Rhoo-Ouh", "Rouk-Zham", "Shehi", "Shlo-Digri", "Shlo-Digri", "Shom", "Shul-Ough", "Suhiorf", "Tuhli", "Ub-Yuh", "Ubghah", "Vuh-Ouhrahoo", "Wah", "Wuh", "Wuhtuhli", "Yaum", "Yuh-Giree"

* "gnome female"

.. code-block:: lua

   "Banus", "Billeklinkle", "Bimkiulo", "Binkwin", "Binkwin", "Bipvizz", "Bipvizz", "Bixgus", "Byloflink", "Cargus", "Carvizz", "Dibink", "Dimbick", "Dimbick", "Dindamink", "Ditinkle", "Elsizzle", "Fildilinkey", "Filliflink", "Filliflink", "Fynkkink", "Fynkkink", "Gellergo", "Glinbynus", "Gynndeedus", "Gynnoago", "Hinkabrick", "Ketklinkle", "Ketris", "Kitlelinkey", "Kitlelinkey", "Klofizzy", "Klofizzy", "Lisble", "Lymkeergo", "Lymtink", "Lysskyago", "Lysthink", "Mittledigo", "Mittlesizzle", "Nitly", "Talkink", "Tallinkey", "Thinbick", "Thinbick", "Thinbythin", "Thinklinkey", "Tilkitinkle", "Tyllofizzy", "Tyllofizzy"

* "gnome male"

.. code-block:: lua

   "Balibik", "Bilkeefinkle", "Bilkeefinkle", "Bimliarn", "Binkbrick", "Bolink", "Bomdable", "Bomdable", "Buofinkle", "Buris", "Burtink", "Dinlebrick", "Donflonk", "Fenbink", "Fenbink", "Fenklink", "Fenlflonk", "Filbik", "Filgus", "Finkvash", "Finsizz", "Gelklink", "Gimfizz", "Gimlulo", "Glinkdeegus", "Gnofinkle", "Hinbmink", "Hinbmink", "Hinklosizz", "Hinlidink", "Klobnk", "Laflink", "Laflink", "Lawizz", "Lolarn", "Lolarn", "Mitash", "Mittlegus", "Pithkeebick", "Pithosizz", "Talbeefizz", "Talbeefizz", "Talwick", "Thenflink", "Tinfizz", "Tobgus", "Todatonk", "Tolosizz", "Tomink", "Tovash"

* "gnome surname"

.. code-block:: lua

   "Acerspindle", "Berrysteel", "Bizzspan", "Blackstrip", "Blacktorque", "Castdwadle", "Castfizzle", "Castmaster", "Castspring", "Castspring", "Cogbonk", "Fastfuse", "Finesteel", "Fizzlepipe", "Fizzlepipe", "Fizzlepipe", "Gearblast", "Geartorque", "Geartorque", "Grinddwadle", "Mechaspan", "Mechaspark", "Mechaspring", "Mekkapipe", "Overkettle", "Sadbonk", "Sadbonk", "Shinepipe", "Shinepipe", "Shortgauge", "Sparkkettle", "Sparksprocket", "Springcrank", "Steamfuzz", "Steamgauge", "Steamgauge", "Steamnozzle", "Steamnozzle", "Swiftdwadle", "Swiftspinner", "Thistlebus", "Thistlebus", "Thistlegrinder", "Thistlenozzle", "Tinkfuzz", "Tinkspark", "Tosslespanner", "Twisttorque", "Wobblespanner", "Wobblespanner"

* "goblin female"

.. code-block:: lua

   "Achgaay", "Achvarkah", "Adzgnaty", "Arkachya", "Arkstoggah", "Balggagya", "Blidgukzatgah", "Blotgady", "Blotsnagay", "Bolgvarkghy", "Burkyakghy", "Drizzatah", "Gagyadah", "Garshukgah", "Garzibghy", "Gatirkgah", "Gazizy", "Gazragglizah", "Ghakmazgah", "Ghaksligy", "Gitflugay", "Glatglakmizah", "Gukdrikay", "Irkgaay", "Khadsnaggah", "Krigblokya", "Lagmaky", "Lakbilgragya", "Laknoky", "Lakskugya", "Ligmakghy", "Likkglokgah", "Lozbilgay", "Nigmazay", "Ratmaky", "Shukurfgah", "Slaishukya", "Sniggatya", "Snikslogah", "Sogshukah", "Yaggmazay", "Yakzatgah", "Yarkdrizah", "Yarknazay", "Yipsligah", "Zatsnatghy", "Zibbalgah", "Zibghaggary", "Zibmazy", "Zizglakgah"

* "goblin male"

.. code-block:: lua

   "Balggar", "Balgsog", "Bligbalg", "Bloktog", "Burkkrig", "Burklikklig", "Drikmiz", "Flugyip", "Gakrag", "Garmiz", "Glakgak", "Gloknad", "Goggaz", "Gogglatdrik", "Gratglok", "Guksnik", "Irkglok", "Irksnarkzib", "Irktog", "Khadbilg", "Laggnat", "Lagspik", "Likkhig", "Luklozdrik", "Makbolg", "Mizbot", "Nadblig", "Noggadz", "Nogglak", "Nukkhig", "Ragskug", "Ratbug", "Ratrakgliz", "Shrigziz", "Skragblot", "Sloggog", "Snarkga", "Snigflug", "Snitburk", "Snitnok", "Spikglok", "Spikglok", "Stoggsog", "Togurf", "Urfsna", "Varkkak", "Yaggach", "Yaggsnag", "Yignikk", "Zibtog"

* "half-demon female"

.. code-block:: lua

   "Aagdusla", "Azanil", "Brazija", "Brazskiu", "Bruhbau", "Drulgnalu", "Jhaaldiu", "Jhaalulla", "Jhaalxhiu", "Jidsula", "Jurbau", "Kaazanil", "Krauizil", "Krivija", "Krivija", "Kuazdiu", "Luribau", "Luriija", "Niddiu", "Nidzihyl", "Ninjbau", "Ninjdiu", "Nulnalu", "Nymzihyl", "Ranaganil", "Rilthusula", "Rukanil", "Ruknalu", "Ruzbau", "Saagrhyl", "Ulthuskiu", "Ulthuskiu", "Ulthuzihyl", "Urzija", "Uznidbau", "Uznidbau", "Vlaajizil", "Vlaajrula", "Vlaglin", "Vlashzihyl", "Vlukbau", "Vluzakskiu", "Vrazanil", "Vulkjiul", "Xaugiu", "Xidizil", "Xulziu", "Zugnalu", "Zuvlin", "Zuvsula"

* "half-demon male"

.. code-block:: lua

   "Alurruzuk", "Aziklank", "Brallurr", "Bralruzuk", "Bruhzuk", "Draanull", "Drulgundak", "Drulgzu", "Guzbru", "Guzdrul", "Guzsuruk", "Haugarag", "Hauglun", "Jhaaldrul", "Jidnal", "Jiusalk", "Jurgrul", "Jurinu", "Kargsalk", "Kargundak", "Krivrul", "Krivsul", "Krivzu", "Kuduuvik", "Mulkrul", "Nidzuk", "Ninjsalk", "Nullun", "Rilthulank", "Rilthurul", "Rilthusuruk", "Rukbru", "Rulklun", "Ruzrul", "Ulthuruzuk", "Uznidnal", "Virnuvik", "Vlashnal", "Vlukinu", "Vlukzuk", "Vrazlurr", "Vrazundak", "Xauxulg", "Xidarag", "Xidsuruk", "Xurajuvik", "Zauvarag", "Zauvinu", "Zauvnal", "Zauvzuk"

* "halfling female"

.. code-block:: lua

   "Adelheid", "Allison", "Alyssa", "Amber", "Aregund", "Begga", "Begga", "Berenga", "Bertha", "Bertha", "Bertha", "Brunhilda", "Brunhilda", "Camelia", "Camelia", "Chlodosind", "Cora", "Engelberga", "Erica", "Ermengard", "Esmee", "Fatima", "Goiswinth", "Goiswinth", "Gomatrudis", "Jenna", "Kaitlyn", "Laura", "Lily", "Marcatrude", "Mary", "Menegilda", "Morgan", "Myrna", "Myrna", "Myrtle", "Myrtle", "Prima", "Ragnachilde", "Regnetrudis", "Rotrud", "Saffron", "Saffron", "Scarlet", "Theodelinda", "Theoderada", "Theutberga", "Theutberga", "Tiffany", "Vulfegundis"

* "halfling female 2"

.. code-block:: lua

   "Adice", "Adwisa", "Aila", "Albice", "Alma", "Almwina", "Almwina", "Bardwina", "Biffwina", "Boffa", "Boffwina", "Bombia", "Bombia", "Brama", "Bungily", "Droca", "Drogina", "Durla", "Emmily", "Erna", "Everia", "Falca", "Fulba", "Fulbily", "Gama", "Hama", "Hasca", "Hascina", "Hodia", "Huga", "Hugia", "Ivwisa", "Marka", "Milia", "Mungia", "Othia", "Othice", "Saba", "Sama", "Samia", "Sega", "Sega", "Segina", "Serla", "Serla", "Toba", "Tobwina", "Wanina", "Wanwina", "Wyda"

* "halfling male"

.. code-block:: lua

   "Adalhaid", "Angilbart", "Basso", "Berchar", "Bertin", "Bilbo", "Bildad", "Blanco", "Charles", "Dalfin", "Emme", "Enurchus", "Erard", "Fastred", "Fastred", "Fortinbras", "Grossman", "Guntramn", "Hildebald", "Hildebald", "Hildebald", "Huebald", "Imbert", "Imnachar", "Isengrim", "Isengrim", "Letard", "Lo", "Lo", "Lo", "Majorian", "Matfrid", "Matfrid", "Mauger", "Melampus", "Melampus", "Merimac", "Moro", "Moro", "Pancras", "Ragnfred", "Sadoc", "Sunno", "Sunno", "Taurin", "Ted", "Tobold", "Unroch", "Waltgaud", "Zwentibold"

* "halfling male 2"

.. code-block:: lua

   "Adelo", "Adelwin", "Adrfast", "Adro", "Ailert", "Ailo", "Ailwin", "Albard", "Almo", "Ambo", "Biffard", "Biffold", "Biffwin", "Bombald", "Bungfast", "Bungo", "Drogfast", "Drogwise", "Durlfast", "Durlo", "Durlo", "Ernert", "Ernfast", "Erno", "Falco", "Falcwise", "Frobard", "Gamo", "Gamo", "Hamo", "Hamo", "Hugo", "Ivald", "Marko", "Mungard", "Mungwise", "Mungwise", "Odo", "Odo", "Odo", "Odwise", "Samald", "Samard", "Samo", "Samwise", "Serlwise", "Tobard", "Wigald", "Wigold", "Wydwise"

* "halfling surname"

.. code-block:: lua

   "Bilberry", "Bolger-Baggins", "Bophin", "Bophin", "Bracegirdle", "Brandagamba", "Brandagamba", "Brandagamba", "Brandybuck", "Brockhouse", "Brown", "Brown", "Fairbairn", "Fairbairn", "Fairbairn", "Farfoot", "Featherbottom", "Featherbottom", "Finnagund", "Gawkroger", "Goodchild", "Goodchild", "Greenhill", "Hayward", "Heathertoes", "Hedgehopper", "Hedgehopper", "Hlothran", "Hlothran", "Hogpen", "Langham", "Leafwalker", "Leafwalker", "Leafwalker", "Lightfoot", "Littlefoot", "Longfoot", "Lothran", "Oldbuck", "Proudbody", "Smallburrow", "Stoor", "Took", "Townsend", "Twofoot", "Twofoot", "Underlake", "Undertree", "Undertree", "Zaragamba"

* "human female"

.. code-block:: lua

   "Aelfthryth", "Aeranor", "Aethelgifu", "Aethelleofu", "Aewleofu", "Bayraed", "Bealdleofu", "Beothryth", "Bethetira", "Bethynor", "Cinstance", "Cwenwaru", "Cynecromb", "Demelza", "Deorwaru", "Deorwig", "Eadleofu", "Eaduald", "Ealdflaed", "Emelossra", "Emima", "Freaflaed", "Giwe", "Goddeal", "Hildbeald", "Lavirida", "Leofbeald", "Leofbeald", "Mildcromb", "Mildleofu", "Mildmaer", "Nerana", "Neruda", "Oswict", "Saeburg", "Saesige", "Salata", "Sigewulf", "Silothra", "Vorassra", "Wacerlac", "Wictsige", "Wigbeorht", "Wineflaed", "Winewig", "Wulfgifu", "Wulfwict", "Xanynn", "Xerora", "Zubina"

* "human male"

.. code-block:: lua

   "Aelfhere", "Aelfrun", "Aelfstan", "Aethelmaht", "Aethelsige", "Alldil", "Alndur", "Armdeal", "Bealdwil", "Belakaltholen", "Beorhtfugol", "Beranwig", "Caswyn", "Cuthwig", "Cynefrith", "Cynehere", "Cyneweald", "Dagsta", "Daimkhad", "Dairdig", "Deorrim", "Drgorn", "Drntir", "Duvfvor", "Eadgeat", "Eadheard", "Eadlac", "Ealdmund", "Ealhfrea", "Graegstan", "Heregod", "Hidur", "Hurlar", "Isenmon", "Joriorn", "Mardsin", "Margh", "Mauhies", "Nii", "Oegeat", "Osaeldra", "Rhxdur", "Scrocgeat", "Scrocweald", "Sneldeal", "Stanin", "Strangnoth", "Thurgeat", "Thurwine", "Winewold"

* "human surname"

.. code-block:: lua

   "'Bright' Fitchett", "'Faithful' Acquieri", "'Lean' Arcand", "'Lean' Harrison", "'Rotted' Dark", "'Wild' Hoflienus", "'Wise' Mjahriksdottir", "Anvil-Nose", "Armieim", "Artre", "Bishop", "Bjoaldersdottir", "Blakemore", "Bloodmouth", "Bonython", "Brownie", "Bullock", "Care", "Coad", "Crowder", "Dalton", "Dunnett", "Graeme", "Hare", "Harornedottir", "Kjanssen", "Law", "Limquardt", "Magiont", "Midal", "Newbury", "Northerner", "Oath-Mouth", "Oath-Tamer", "Ogden", "Palmer", "Partridge", "Petinette", "Petty", "Poor-Smasher", "Rouncefield", "Secret-Drums", "Seven-Fire", "Slayer", "Stanton", "Terrill", "Thorpe", "Townend", "Vial", "the Unseen"

* "infernal 1"

.. code-block:: lua

   "Aiazulfraz", "Aiazuyjuu", "Baalzurhuu", "Baelazziel", "Baphluru", "Buzrucha", "Dreelnee", "Frazlugro", "Gelavgel", "Geluvnahu", "Ghaaivalu", "Ghauuvshai", "Ghauyuzul", "Gre-evssu", "Grejuszul", "Guraivphaal", "Guzrizul", "Gya-zotho", "Gyaluhriz", "Gyavaavu", "Gzi-zuphaal", "Hriziriuz", "Huzazlurhz", "Iuz-rumoz", "Ixujinahu", "Juujaalz", "Juuyushu", "Kraa-vuyil", "Kraaruthalu", "Liluuzhruz", "Lol-uythu", "Malruyaa", "Nallirhuu", "Oazoijlurhz", "Oxu-uyoxu", "Razyubre", "Reozolhuz", "Rezjuthu", "Riz-loraz", "Rizlonee", "Rizzossu", "Ruezmoz", "Ruzialu", "Shuolhuz", "Thuyugre", "Tzejugarl", "Tzevizu", "Yeejuolth", "Zielribaz", "Zulzushu"

* "infernal 2"

.. code-block:: lua

   "Aagilthog", "Aagujrung", "Aghuraab", "Aigzaogg", "Bargzedroog", "Chag-rutzolg", "Chaguvxub", "Derghyuuag", "Draugvuiog", "Dreghulkolg", "Droglokag", "Druj-zulaug", "Drujzeyibb", "Felgijnaag", "Frubeyhrud", "Frublumog", "Glaagyomaug", "Glaboztzolg", "Gub-alkag", "Hegerbrelg", "Hegziaab", "Iubaythaug", "Iubulgaub", "Iubvutrulg", "Klegazstug", "Leeghurhrag", "Mogranalb", "Morg-uvdroog", "Nogyubrelg", "Nud-arlaug", "Nugruzub", "Nugulnog", "Nyogjuthog", "Nyogruagh", "Obb-urgrolb", "Raug-ilnaag", "Ruugvoghad", "Saugazigg", "Shuborthaug", "Shubuzdaurg", "Strogzanaag", "Stugujiug", "Stugzudraug", "Szugyuuag", "Thogorjulb", "Trulg-ujthog", "Urbuzjulb", "Vulbziaag", "Yeburobb", "Zugujnaug"

* "infernal 3"

.. code-block:: lua

   "Ach-zudak", "Achlunuur", "Akk-zidun", "Azt-romet", "Aztroash", "Bar-ozcharn", "Blikardun", "Blikjiruun", "Borirsoth", "Borivtash", "Chon-uylok", "Feshlukos", "Gaurzaech", "Githezgur", "Glaur-arrhast", "Gochaylok", "Gochyuoch", "Iex-ijlach", "Inaxziter", "Kosivter", "Liskvuinax", "Lithzaluth", "Lokijruaak", "Lokloslyth", "Lokulgor", "Loth-ojnoc", "Moth-linuur", "Muthzonilv", "Nythivinax", "Ralkzolach", "Roth-avnur", "Roth-uyter", "Rothurkir", "Rothuvnur", "Ruaakviluth", "Ruaakyimuth", "Ruttargith", "Ruun-rivach", "Saurribahor", "Slythilsoth", "Sothvubahor", "Tash-alsot", "Tash-uloth", "Terlaiex", "Thalurvooth", "Turvodak", "Uztjudraum", "Vap-ajcharn", "Vrokyuroth", "Xaas-ruslyth"

* "ogre female"

.. code-block:: lua

   "Arghsluby", "Burznakhay", "Drubkulkgah", "Dubzudmaugah", "Durshkugy", "Dushmulghy", "Ghakhgrulya", "Ghakhnakhah", "Gharluzghy", "Gharnarggah", "Gludhrungdubay", "Gluznargdrubay", "Groggdubay", "Grogglugah", "Grokmugmaugya", "Grulukhay", "Grulurghy", "Grumflugghy", "Grumfluzy", "Grumfrolbgah", "Grumgulvgah", "Grumshargay", "Gulvkroddofya", "Gulvlumya", "Haiglugah", "Haislugghy", "Hurgthulkghy", "Klobghorghy", "Krodmakhay", "Kulkgrulgrobah", "Luggrobya", "Lushgharghy", "Lushgrumy", "Lushmulay", "Luzghulgah", "Makhghorya", "Mulguhlghy", "Mulslubgomgah", "Obbmuzdgah", "Shugdugghy", "Shurgradghorghy", "Shuzdulya", "Slubghashy", "Sludgrashghy", "Sludgruzah", "Sluggruzgah", "Thragmugghy", "Truglurzgah", "Urkhulgah", "Yuggrutgah"

* "ogre male"

.. code-block:: lua

   "Arghfugslub", "Drubrolb", "Fuglugsnog", "Ghashbog", "Gholmug", "Gludslud", "Grashdush", "Grobklob", "Grokmurk", "Grolthulk", "Grufgom", "Grufobb", "Grulgroggdrug", "Grumfburz", "Grumflummaug", "Grushruf", "Gruzlum", "Gruzluz", "Gulvgom", "Hrungurkh", "Lorgdrug", "Lorggrok", "Lumgruf", "Lurzurgh", "Makhgludsnog", "Makhmakh", "Mudgrol", "Mulslud", "Muzddub", "Nakhruz", "Nargglud", "Obbgru", "Obburd", "Rolbgrum", "Ruzmakh", "Shrufgulv", "Shurgulv", "Snadyur", "Snogbarsh", "Thraggrash", "Thulkdrub", "Trugghukk", "Truguz", "Urddursh", "Urfaug", "Urkhkulk", "Urmolg", "Urshur", "Uzhur", "Zugdrok"

* "orc female"

.. code-block:: lua

   "Batonk", "Batonk", "Batonk", "Boladurz", "Bolob", "Bor", "Bor", "Borba", "Bula", "Bumph", "Burub", "Burzraz", "Gasbut", "Gashbul", "Ghaktha", "Ghaktha", "Gham", "Glob", "Gonrn", "Gonzush", "Grat", "Grat", "Gratzush", "Grazth", "Gul", "Gul", "Gul", "Gulfug", "Lambug", "Lamut", "Lashdurz", "Lashdurz", "Mazoga", "Mazoish", "Mogak", "Morn", "Morza", "Murzum", "Oghash", "Orbuh", "Shadzug", "Shagdub", "Shal", "Sharamph", "Sharn", "Shazgob", "Uglaim", "Ulorz", "Uroga", "Uroggdub"

* "orc female 2"

.. code-block:: lua

   "Bazrorgay", "Bazyobya", "Brogskulggah", "Bruzyashghy", "Daglakhya", "Dargshogskulgghy", "Dogdobgah", "Drabgolah", "Drabrashghy", "Dugruftay", "Duraggah", "Gnarlgnubay", "Gnubrashah", "Gnubsnuby", "Golkdakkay", "Grubgrubya", "Grubrorgy", "Hagbruzshadgah", "Hrogghazy", "Kharglazgah", "Kragblagay", "Kragshakgah", "Kragskarghy", "Lakhghazghy", "Lashdugah", "Lashgokhay", "Lashgokhgah", "Lobgolyakhay", "Lubrugah", "Muksnubay", "Mukstulgghy", "Mukumshgah", "Rotbruzkrudghy", "Ruddakkghy", "Rudgnashbragah", "Rudolgghy", "Ruftghazghy", "Rufthrugy", "Shadgloly", "Shagbadgah", "Shagshakgah", "Shazbazay", "Skulgkrudghy", "Skulgsnaray", "Trogbaglobgah", "Ungdargah", "Ungrotgah", "Ungshakgah", "Zahksnargah", "Zoghrugghy"

* "orc male"

.. code-block:: lua

   "Alog", "Apaugh", "Apaugh", "Bazur", "Bogakh", "Bogrum", "Buruub", "Durbrag", "Ghamulakh", "Grat", "Gratgnak", "Grogmar", "Gruish", "Hibub", "Hugmug", "Khaong", "Kurdburz", "Larek", "Larek", "Largug", "Lumdk", "Lumdk", "Lurodum", "Mabub", "Maguumbu", "Mahk", "Malz", "Malz", "Mashgob", "Mulunok", "Muzgrbash", "Nagrutto", "Oggugat", "Olmthu", "Onog", "Orokbul", "Peghed", "Podagog", "Podagog", "Shegog", "Ulagak", "Ulmat", "Urul", "Ushnurz", "Vorgarag", "Yadba", "Yalakgh", "Yamorz", "Yasog", "Zlughig"

* "orc male 2"

.. code-block:: lua

   "Aggrashslur", "Agrug", "Badsnurr", "Bagmukung", "Bakhgrath", "Bazkrag", "Blagug", "Bragyob", "Dagbruz", "Drabbruz", "Drabgrash", "Ghazkrag", "Ghazrug", "Glakhdag", "Glazbakh", "Glazgol", "Glurrogg", "Gnarlgnubglaz", "Gnashglol", "Gnashtrog", "Gobrotbrag", "Gorbash", "Grathshag", "Grazgud", "Grotglakh", "Grotrorg", "Gudglaz", "Gutbakh", "Hrogungug", "Khaggudlob", "Kharbruzbakh", "Kharhrog", "Lobaug", "Lobyob", "Oggkhag", "Olggol", "Ragkrag", "Roggyash", "Rorgshazmuz", "Rotslur", "Ruggol", "Shogbragkhag", "Slurglufshak", "Snorllash", "Snorlluf", "Snurrgraz", "Snurrthak", "Umshumsh", "Unggrot", "Zahkgrot"

* "orc surname"

.. code-block:: lua

   "Agadrzuf", "Atulor", "Baguub", "Baguub", "Bargash", "Bargzuf", "Basilslag", "Bolmrolg", "Broan", "Bugmakh", "Burbrag", "Burgk", "Burorz", "Dumulg", "Durgzol", "Dushnar", "Gamoam", "Gharfish", "Gholarn", "Gluul", "Gulfgakh", "Gurudu", "Gurwog", "Gurwog", "Hubrim", "Khalob", "Khara", "Khatmakh", "Khazob", "Laglob", "Lumbgdum", "Luzgub", "Malgdum", "Maroar", "Moghku", "Mulur", "Sharzol", "Sharzol", "Shulharzol", "Shuluk", "Trazuf", "Trazuf", "Ugdmgog", "Ulab", "Urgaharz", "Urgaharz", "Ushuamakh", "Uzganar", "Uzgku", "Uzgrat"

* "sprite female 1"

.. code-block:: lua

   "Dexarel", "Flaxafer", "Flaxarel", "Flaximer", "Flaxirel", "Flixanel", "Fosserel", "Friskafer", "Friskimer", "Friskirel", "Frissanel", "Frissarel", "Gessarel", "Gessifer", "Glanafer", "Glanafer", "Glanasti", "Glimafer", "Glimasti", "Glissenti", "Gossenti", "Gossinel", "Gossirel", "Hexinel", "Miskenti", "Ressamer", "Ressanel", "Ressefer", "Riffamer", "Riffenti", "Rillasti", "Rillasti", "Rillirel", "Saffirel", "Shimerel", "Tissanel", "Tissenti", "Trillafer", "Trillirel", "Twispefer", "Twisperel", "Twixanel", "Weskamer", "Weskifer", "Winnamer", "Winnamer", "Winnamer", "Wispenti", "Wispirel", "Wispirel"

* "sprite female 2"

.. code-block:: lua

   "Brisree", "Cryltiss", "Elsisa", "Elsiynx", "Emberla", "Feriskiss", "Ferismee", "Ferisniss", "Ganliss", "Ganmee", "Glinkriss", "Glinksa", "Halkiss", "Halliss", "Halnyx", "Istleniss", "Istleree", "Istleynx", "Jatniss", "Jatriss", "Jatriss", "Jostdee", "Jostliss", "Justiss", "Lirradee", "Lirrariss", "Minkmee", "Minkree", "Minksa", "Mirrakiss", "Mirraliss", "Mistleree", "Mistletiss", "Ninkala", "Ninkaree", "Opalynx", "Orifliss", "Orisynx", "Peridee", "Sarmliss", "Sarmmee", "Stithsa", "Tirrala", "Tirranyx", "Trumpriss", "Trumptiss", "Whisdee", "Whisniss", "Whistiss", "Zandola"

* "sprite male 1"

.. code-block:: lua

   "Dexaldo", "Dexesto", "Flaxando", "Flissesto", "Fossando", "Friskamo", "Friskaroll", "Friskendo", "Frissando", "Frissesto", "Frissesto", "Gessasto", "Gesseron", "Glanallo", "Glaxaron", "Glaxasto", "Glimesto", "Glisseron", "Glissesto", "Hexando", "Lissaroll", "Minaldo", "Minaron", "Miskallo", "Raffando", "Raffasto", "Raffasto", "Ressasto", "Riffondo", "Rillaroll", "Saffendo", "Tinkaldo", "Tinkendo", "Tinkondo", "Trillaldo", "Trillando", "Trilleroll", "Tristaroll", "Twisperoll", "Twissando", "Twisseron", "Twixeroll", "Weftesto", "Weskasto", "Weskondo", "Winnallo", "Winnallo", "Wispallo", "Wispendo", "Wispesto"

* "sprite male 2"

.. code-block:: lua

   "Brisfrell", "Crylfret", "Cryltross", "Crylzisk", "Elsifret", "Elsizisk", "Emberrix", "Eskmist", "Ferisfrell", "Ferismist", "Frimibrix", "Ganbrix", "Ganzisk", "Glinkfret", "Halwin", "Histbik", "Histbrix", "Iphilfrell", "Istlebrix", "Istlefrell", "Istlekin", "Istlezisk", "Istlezisk", "Jatbik", "Jatfrell", "Jusmist", "Juszisk", "Lirramist", "Lirrazisk", "Malibrix", "Malikin", "Malitross", "Mirratwik", "Mistlezisk", "Ninkamit", "Ninkarix", "Ninkatross", "Opalbrix", "Sarmkin", "Stithrix", "Stithtross", "Tirrabik", "Tirrabrix", "Tirramit", "Trumpbik", "Trumpzisk", "Whisbik", "Zandorix", "Zandotwik", "Zandozisk"
