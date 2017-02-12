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




* "aasimar female"

.. code-block:: lua

   "Adrasteleth", "Areseth", "Arken", "Atareleth", "Avareseth", "Avlantenth", "Daalla", "Dadrea", "Dasinoe", "Drinramou", "Imesinoe", "Jal-atar", "Jal-varam", "Jaljena", "Jasaner", "Jasarmeth", "Kalares", "Kaljena", "Kalsah", "Kavalel", "Maenth", "Masozi", "Nienth", "Niereth", "Nies", "Nieth", "Nijena", "Nivina", "Onma", "Pal-aman", "Ral-talar", "Ranalen", "Sardareleth", "Sardareth", "Sarma", "Sarnateleth", "Sartyra", "Talasen", "Taldrea", "Talsinoe", "Taltyra", "Taranenth", "Tarma", "Valdoreleth", "Valnoreth", "Vanarel", "Varaleth", "Varaleth", "Vardaret", "Voltareth"

* "aasimar male"

.. code-block:: lua

   "Amaranth", "Ar-avar", "Ar-valon", "Aradal", "Aral", "Aranas", "Arat", "Aritian", "Belan", "Belgan", "Cerath", "Cernan", "Cerran", "Cronwier", "Eran", "Ilamin", "Jaldril", "Jalrant", "Jasanathar", "Javralath", "Kaladathar", "Kalwier", "Mauar", "Mauathar", "Maunan", "Maunan", "Oar", "Paath", "Paldril", "Palitian", "Paral", "Parant", "Ravanathal", "Sar-palad", "Sar-saran", "Sardanat", "Sarnatath", "Solarath", "Talanath", "Talonath", "Tuath", "Tutin", "Tutin", "Valnarathal", "Valnarathas", "Valnorathal", "Valoral", "Vanarathal", "Vardaral", "Zairan"

* "catfolk female"

.. code-block:: lua

   "Alirra", "Amiau", "Dumihr", "Dusash", "Duslif", "Holina", "Homiah", "Hosheer", "Hoslif", "Hosyau", "Jilirri", "Jilissi", "Jisharr", "Jishim", "Jiyi", "Lithlahi", "Lithyera", "Maulyana", "Meerline", "Miaumew", "Miaumihr", "Mihrmeeri", "Mihrsharr", "Milaha", "Milaha", "Milissa", "Milyara", "Mimeere", "Mipurrh", "Mirrmeera", "Mirrserr", "Misfee", "Saflahe", "Safsharr", "Safyeri", "Sashlyara", "Sfeelyani", "Sheerlirre", "Sheerlithi", "Sheeyi", "Shimserr", "Shurrlyani", "Shurrsaf", "Siphelahi", "Siphemau", "Sipheyeri", "Siythlirri", "Tilini", "Timirr", "Tiyera"

* "catfolk male"

.. code-block:: lua

   "Carmew", "Carshah", "Carsharr", "Carshau", "Carsiyth", "Dremiau", "Dreran", "Fermeer", "Fershim", "Germau", "Gerslif", "Lirrsaf", "Lisslirr", "Lithshurr", "Lithsiyth", "Lithsiyth", "Meerpurrh", "Meershau", "Mewsheer", "Miaupurrh", "Miausaf", "Mirrgar", "Mirrshah", "Nykserr", "Nykserr", "Nyksharr", "Nykshee", "Nyksiyth", "Purrhlyau", "Purrhsyau", "Purrhus", "Rousharr", "Routan", "Safus", "Sashshau", "Sashwan", "Shahlyau", "Shahmeer", "Sharrsiyth", "Shaumihr", "Sheemirr", "Shimshah", "Siythlyau", "Siythwan", "Sliflirr", "Syauruth", "Zithsaf", "Zithsaf", "Zithshee", "Zithsiyth"

* "dark elf female"

.. code-block:: lua

   "Balsabistra", "Balsabliniza", "Balverpirdril", "Bursolilrin", "Charnopelhel", "Charsulleviln", "Charvirlavira", "Chormyrpirtra", "Chororisdra", "Colyasratra", "Divpelpelrin", "Divvorilhel", "Dromothpelhel", "Drompandylra", "Dromporidrin", "Dulmyrdylbra", "Dulverpirna", "Eilonpeliln", "Eilsinlinsil", "Eilvrillaviza", "Eknerilene", "Enoristra", "Eryolisith", "Gonpellivna", "Gontormendra", "Gonvorerra", "Gulporisra", "Gulsunsylrin", "Gulvorpirvril", "Imrelsylna", "Imsulsinhel", "Insvrilrinlin", "Jegnilpirira", "Jendpordylene", "Jendsulpirtra", "Jendveksinia", "Kilvorlavrin", "Lilpanlivvril", "Lulolgrilistra", "Lulpellevra", "Lulsindylira", "Lultorpelvra", "Mabtorsylistra", "Mazporpirna", "Mersekelvril", "Meryaspirrin", "Mornilralia", "Mornilsinira", "Norsolrilene", "Nothporpelistra"

* "dark elf male"

.. code-block:: lua

   "Balrharanim", "Baltuldylid", "Bersinrilnaz", "Bervilpelvim", "Charnilelred", "Charsusdylvid", "Charverlinird", "Choryelsinul", "Derelelvim", "Desulrarid", "Divsunlinnil", "Divtendyluld", "Divverisriv", "Dolpanlivvir", "Drirupirvir", "Drompelsinvim", "Dromporsinvid", "Enolgpirnid", "Enrhasylul", "Ensabralnaz", "Ensolpelred", "Erolgrinlim", "Erpelilvid", "Gonorgidild", "Gulonrilnid", "Imnilidlim", "Insvirrilid", "Insvirsyluld", "Istnellivnil", "Istrelisul", "Istvillenvim", "Jendvorralald", "Kilyolsinviz", "Lilyelralred", "Lulsinraleld", "Lultorlevred", "Lultormlevlim", "Lulvorleveld", "Mabothrallim", "Mazvorisald", "Mernopeluld", "Mezsusranil", "Molmyrrilvim", "Morvillevnid", "Morvirrinviz", "Noronpirrid", "Nothtenlavlim", "Nothvorisred", "Olothlavid", "Olporlivnil"

* "dragon female"

.. code-block:: lua

   "Adastralagonis", "Adastraphylaxis", "Ancamordaxis", "Andramalaxis", "Archomordaxis", "Archoneriaxis", "Archovorunga", "Archozzebraxis", "Baramanthysa", "Barzuthraxis", "Barzuthraxis", "Beruxenoris", "Bialagonis", "Bradobradaxis", "Brimamandrossa", "Cadravorunga", "Cadrazzebraxis", "Chrobazia", "Chronaluxis", "Chroneriaxis", "Chrozuthraxis", "Harvorunga", "Iulzzebraxis", "Iulzzemalis", "Jazrazzebraxis", "Keruxaphylaxis", "Majurixenoris", "Malachomalaxis", "Malachozuthraxis", "Phoroneriaxis", "Phrixunadralix", "Phrixuzzebraxis", "Porphyronaluxis", "Rhodobazia", "Sarcuzuthraxis", "Sarcuzuthraxis", "Sardazzemalis", "Scarvalagonis", "Skhiacalchaxis", "Skhiaxenoris", "Skhiazuthraxis", "Skhiazzebraxis", "Skhiazzemalis", "Tchalcedomanthysa", "Tchazarbazia", "Trocholagonis", "Trochozzemalis", "Zalarbazia", "Zalarzzemalis", "Zerulbradaxis"

* "dragon male"

.. code-block:: lua

   "Adastraxenor", "Aragcordax", "Aragphylax", "Aragzzebrax", "Archobradax", "Archophylax", "Atrabradax", "Barbazius", "Barcordax", "Beruxenor", "Beruzzemal", "Biavorax", "Bradomalax", "Brimabradax", "Brimamandros", "Chrysobradax", "Glaumalax", "Glaunadral", "Harmandros", "Kralkamandros", "Majurimalax", "Malachoneriax", "Marnadral", "Marzzebrax", "Orgrazzemal", "Ouronadral", "Ourovorung", "Peridobradax", "Peridoxenor", "Phorocordax", "Phorophylax", "Phoroxenor", "Phrixumandros", "Phrixumandros", "Pyracalchax", "Pyranalux", "Rhadalagon", "Rhadanadral", "Rheneriax", "Rhevorax", "Sardavorung", "Sidereoxenor", "Tchazarmandros", "Tchazarmandros", "Tchazarxenor", "Trochoboros", "Trochophylax", "Trochovorung", "Vranalux", "Zalarbradax"

* "dwarf female"

.. code-block:: lua

   "Ama", "Annuda", "Ardi", "Bial", "Bila", "Bonuda", "Brynglian", "Bylthiel", "Danmala", "Detu", "Duervada", "Dulona", "Dwagret", "Farinda", "Fraflera", "Frebida", "Fubra", "Fuli", "Gemnyl", "Glodeth", "Glody", "Jaal", "Janirigg", "Jegna", "Kadomia", "Kaitria", "Killona", "Kilsi", "Kiltha", "Kivara", "Lischa", "Maden", "Marba", "Metha", "Naerbera", "Nagnon", "Oya", "Rasma", "Relona", "Renba", "Renryn", "Rovara", "Telli", "Thoal", "Thogret", "Torkala", "Veta", "Voniess", "Zatuna", "Zegrun"

* "dwarf female 2"

.. code-block:: lua

   "Brodris", "Brokkdis", "Bromdis", "Bromlis", "Bromna", "Burllis", "Dallif", "Dalrun", "Dolgbis", "Dorrith", "Drimis", "Drimrun", "Dromris", "Dromrun", "Durmdis", "Durrun", "Frorrun", "Fulddis", "Fuldrun", "Fundis", "Gimlind", "Gondrun", "Gordlis", "Gradrun", "Grimlis", "Grodrun", "Gromrun", "Guldna", "Guldrun", "Gurvis", "Hornda", "Hornda", "Horndis", "Hornlind", "Hrarith", "Nordlif", "Ormdis", "Skandis", "Skonddis", "Stromis", "Stromvis", "Sturga", "Sturrun", "Sundna", "Thorlind", "Throga", "Throis", "Throlis", "Thrubis", "Thundga"

* "dwarf male"

.. code-block:: lua

   "Bannar", "Bavin", "Bofri", "Bonchar", "Bonmur", "Borhec", "Bunek", "But", "Dali", "Danvi", "Dubur", "Duli", "Dwani", "Dwarimm", "Fiin", "Funfur", "Funni", "Garmur", "Gomil", "Gomur", "Goun", "Gwarbil", "Gwarfri", "Hjolnom", "Hurnik", "Jorlin", "Kari", "Karil", "Kramdahr", "Lodur", "Lorin", "Lorin", "Marulf", "Obur", "Renden", "Rolin", "Runri", "Tarvil", "Taur", "Telun", "Thifur", "Thomil", "Thonden", "Thothur", "Toresosi", "Viros", "Vonchar", "Vondur", "Vonlin", "Vonthur"

* "dwarf male 2"

.. code-block:: lua

   "Bornbor", "Bornli", "Brimrur", "Brodor", "Brodror", "Brokkir", "Brokkor", "Brudin", "Bruli", "Burlin", "Burnir", "Dalror", "Dormvir", "Dralin", "Dralin", "Drimri", "Durnrok", "Frorlin", "Fuldrok", "Gimbor", "Glodin", "Glolin", "Gondror", "Gondror", "Gordor", "Gormdin", "Gradin", "Gradin", "Grodli", "Grodli", "Grodrur", "Gromin", "Gundin", "Hornin", "Hornvir", "Hranir", "Norri", "Norror", "Ormli", "Skondin", "Stornor", "Stromlin", "Sturlbor", "Sturlri", "Sturror", "Sundrur", "Thrain", "Throlrur", "Throvor", "Thrurvi"

* "dwarf surname"

.. code-block:: lua

   "Bearmauler", "Boar-Executioner", "Boarsmasher", "Boulderdigger", "Bronzecrusher", "Bronzecutter", "Bronzehand", "Bronzesmasher", "Coalclub", "Coalheart", "Copperforger", "Elf-Strangler", "Ettin-Executioner", "Fieryheart", "Gemcutter", "Gemdigger", "Giant-Beheader", "Gnome-Grappler", "Gnomebane", "Gnomegutter", "Gnomemasher", "Goldsmasher", "Goldsmith", "Granitecarver", "Icefist", "Ironspear", "Koboldslicer", "Mithrilcutter", "Mithrilfist", "Mithrilfoot", "Mithrilsword", "Noblefist", "Oakbeard", "Ogre-Strangler", "Ogre-Strangler", "Ogrecrusher", "Orcslasher", "Redcheek", "Rockfoot", "Silverspear", "Steelbeard", "Steelsmith", "Stonecrusher", "Stonemace", "Thunderdigger", "Thunderfist", "Whitecheek", "Whitehood", "Wolfcrusher", "Wolfmasher"

* "elf female"

.. code-block:: lua

   "Alais", "Alea", "Alea", "Almithara", "Arielimnda", "Bellaluna", "Braerindra", "Braerindra", "Caerthynna", "Claire", "Daratrine", "Daratrine", "Darunia", "Deularla", "Elmyra", "Eloimaya", "Eloimaya", "Faraine", "Filauria", "Filauria", "Gaylia", "Hacathra", "Haera", "Jeardra", "Kasula", "Keishara", "Kethryllia", "Liluth", "Lixiss", "Lyndis", "Lyndis", "Lyre", "Nyna", "Phelorna", "Phyrra", "Rathiain", "Rubrae", "Sariandi", "Shadowmoon", "Shandalar", "Shanyrria", "Sheedra", "Sheedra", "Soliania", "Tsarra", "Urmicca", "Urmicca", "Viessa", "Viessa", "Wynnter"

* "elf female 2"

.. code-block:: lua

   "Aegmeralril", "Aelseredwë", "Aersilaniel", "Aerthalesian", "Aethlitholriel", "Arnimthalriel", "Arthaelaseth", "Artherammir", "Bermindesien", "Bersaeralriel", "Caernimarmir", "Caerraelirsil", "Carlorerrial", "Carsararien", "Celiroliel", "Cirsaeramsil", "Claristolmir", "Crismelansil", "Crissaranedel", "Cristhaerelwen", "Earrindadril", "Earsilmelroël", "Earsindirian", "Elbimebwen", "Elbmaraniel", "Elthrindalwë", "Elththalolril", "Elththeremiel", "Eolsilmensil", "Erimalwen", "Erlarthoneth", "Erlimolroël", "Erlmindediel", "Erlrinenwen", "Ersilmemroël", "Feansilmthalrien", "Feanthelarien", "Findirasedel", "Ganmindirriel", "Gellaralwë", "Gelnirerian", "Ilmimemiel", "Ilmistasrien", "Ilmraelolrial", "Ilmriladian", "Ithseradian", "Ithserevwen", "Laegliththonril", "Lendralesiel", "Lendsindthonrian"

* "elf male"

.. code-block:: lua

   "Alduin", "Almon", "Anlyth", "Arbane", "Arbane", "Ascal", "Bellas", "Bellas", "Bellas", "Bellas", "Bellas", "Cluhurach", "Connak", "Eroan", "Ettrian", "Folmon", "Goras", "Hagwin", "Ilimitar", "Iliphar", "Iliphar", "Inialos", "Jorildyn", "Kendel", "Khatar", "Khatar", "Khidell", "Khuumal", "Lathlaeril", "Maiele", "Malon", "Melandrach", "Melandrach", "Myriil", "Nopos", "Nym", "Orist", "Phaendar", "Respen", "Rhys", "Riluaneth", "Taegen", "Thalanil", "Theodred", "Theodred", "Theodred", "Theodred", "Theodred", "Theodred", "Traeliorn"

* "elf male 2"

.. code-block:: lua

   "Aegmaegevad", "Aegmelemdir", "Aersindthalfal", "Aerthalalor", "Aesraelesfal", "Aesserolrod", "Anmaroldil", "Arrilirrond", "Belseldarrior", "Caelralirdil", "Caelrimenlas", "Caersilalrond", "Caersindilion", "Calistadrond", "Callithandil", "Calranandir", "Carlaradrod", "Carninedras", "Carrelilad", "Cirinamnar", "Cirmaroldan", "Cirmelasdel", "Clarrinthonlas", "Crisraelemrod", "Earimilras", "Earirilrod", "Earnithebrod", "Elrimevrior", "Eolrindedor", "Eolthaereborn", "Erlloramion", "Erlnimandir", "Erlseradfal", "Erralenad", "Estmirerdil", "Farthirednar", "Feanmindardil", "Findistthondan", "Findmithasor", "Findseldthonros", "Finninanion", "Finninasras", "Galloresras", "Galrimaddil", "Garmarolrond", "Gilloreldir", "Ilmranenthir", "Ilmrimeblad", "Laegmithellin", "Lindthalesfal"

* "giant female"

.. code-block:: lua

   "Bulrei", "Burhrei", "Daoh-Ghug", "Daoh-Rhoo", "Doh-Naohronkh", "Doh-Shehi", "DohAhg", "DohHaogh", "DohKhan", "Fah-Rahooub", "FahIghoum", "Ghat-Lah", "Ghaw-Lah", "Ghishgunri-Rei", "Ghugrei", "Goun-Rei", "Hatoolugh-Lah", "Heh-Doh", "Khurigoushghad-Mih", "Lah-Digri", "Lah-Pughronkhgiree", "Lah-Wah", "LahSnaoh", "Mih-Digri", "MihDumfaogh", "MihKhem", "MihNaroosuth", "Obghishlah", "Orf-Fah", "Oughghish-Mih", "Rei-Meh", "Rei-Shom", "ReiGham", "ReiGhaw", "Shlotih", "Shulfah", "Soh-Hah", "Suhidoh", "Teb-Doh", "Tih-Khanig", "TihEghi", "TihGhish", "TihKham", "TihShul", "TihVuhchah", "Tuhlidaoh", "Urush-Mih", "Vuh-Lah", "Yaumdoh", "Yaumghish-Fah"

* "giant male"

.. code-block:: lua

   "Ahg-Yeeh", "Baod-Rhoo", "Bohrgoun", "Bul-Ghaw", "Bulghug", "Burh", "Chaheghi", "Digri", "Ghad", "Gham", "Gham-Tregh", "Ghan-Teb", "Ghat-Khuri", "Ghatgham", "Ghatghughah", "Ghee", "Gonkh", "Goun-Snaoh", "Goun-Yaumhaogh", "Haogh", "Heghiburh", "Kham", "Khan", "Khem", "Lughfaogh", "Maoh-Khee", "Naoh", "Naoh-Ghah", "Naroo", "Nhamchah", "Oli", "Oli-Chah", "Orf-Snaoh", "Ouh", "Peh", "Puh", "Rahoo", "Rifoo-Khaz", "Ronkh", "Roukyeeh", "Shul", "Shul", "Suth-Haoghahg", "Ub", "Ub", "Urush", "Urush-Shour", "Ush", "Zham", "Zham"

* "gnome female"

.. code-block:: lua

   "Banus", "Banus", "Bimkiulo", "Binklitinkle", "Binklitinkle", "Binkwin", "Bixdink", "Bixgus", "Bodibik", "Bonyulo", "Bonyulo", "Bonyulo", "Dibink", "Dimbick", "Dimbick", "Dimbick", "Dindamink", "Dosizz", "Filgus", "Glinbynus", "Glinkfinkle", "Gynndeedus", "Gynndomink", "Gynnoago", "Hinkabrick", "Juldeeulo", "Katdomink", "Ketklinkle", "Klokiwack", "Lisble", "Liskink", "Lissgus", "Liswin", "Lololinkey", "Lymkeergo", "Lyssfizzy", "Mitash", "Mitthinkle", "Syrbik", "Syrbik", "Syrbyfinkle", "Syrbyfinkle", "Talkink", "Thenlinkey", "Thinkkeesizzle", "Thinkkeesizzle", "Tilkink", "Tindinkey", "Tindinkey", "Tindinkey"

* "gnome male"

.. code-block:: lua

   "Babimac", "Balibik", "Bawick", "Bawick", "Bilkeefinkle", "Binaris", "Binklbus", "Binwick", "Binwick", "Binwick", "Diledus", "Dimlank", "Dindink", "Dinkbitank", "Dinlebrick", "Dinlebrick", "Dobeeble", "Donkleedink", "Filgus", "Fillikink", "Fillikink", "Fillikink", "Finflonk", "Finkvash", "Finsizz", "Gimfizz", "Gimlulo", "Gnoonk", "Gnoonk", "Lago", "Lawizz", "Lawizz", "Lawizz", "Lawizz", "Lodeevizz", "Mittlegus", "Mittleklonk", "Nitdus", "Nitkeeklonk", "Nitkeeklonk", "Pithosizz", "Talwick", "Teenkvash", "Thinkflonk", "Tinfizz", "Tobgus", "Tocdeeflink", "Tockawick", "Todatonk", "Tovash"

* "gnome surname"

.. code-block:: lua

   "Acerpipe", "Acerspindle", "Berryspinner", "Bizzblast", "Blackstrip", "Castfizzle", "Clicksteel", "Cogbonk", "Fastbonk", "Fastfuse", "Fastfuse", "Fizzleblast", "Fizzletorque", "Geartorque", "Mechaspark", "Mechasteel", "Mekkakettle", "Overspring", "Porterblast", "Porterspring", "Puddlehouse", "Puddlesteel", "Sadspinner", "Sadspinner", "Shinespring", "Shinespring", "Spannermaster", "Sparkfizzle", "Sparkspanner", "Steamfuse", "Steamfuzz", "Steamgauge", "Steamnozzle", "Steamwrench", "Steamwrench", "Stormgrinder", "Stormgrinder", "Stormpipe", "Stormpipe", "Stormsteel", "Stormsteel", "Swiftsprocket", "Swiftsprocket", "Swiftwizzle", "Twistcrank", "Twisttorque", "Twistwhistle", "Wobblefizzle", "Wobblefizzle", "Wobblespanner"

* "goblin female"

.. code-block:: lua

   "Adzgligghy", "Balggadya", "Blidnagya", "Bligbalgah", "Bligdokhah", "Bligkrigghy", "Botbotghy", "Burkragya", "Dokhhigay", "Driklukah", "Flugbligay", "Flugvarkay", "Gagburkah", "Gahzitghy", "Garvarky", "Gatglakghy", "Gazzizya", "Ghagnaday", "Ghakarkgah", "Ghakrokah", "Gitbliggah", "Glakgakghy", "Glaksnatah", "Glizgloky", "Glizslogya", "Glokmuby", "Goggazghy", "Gratglokah", "Gukmazgah", "Krigdufya", "Krigghakghy", "Lagspikghy", "Laknokragy", "Ligyaggay", "Likknigah", "Nadbalgya", "Naggogya", "Nagyakghakay", "Nikkglakah", "Ragsnay", "Rokhiggah", "Slaibligay", "Sloggady", "Snigyadya", "Snitsnitghy", "Togbalgah", "Yaggsnagah", "Yarpzatah", "Zibgady", "Zizbolggah"

* "goblin male"

.. code-block:: lua

   "Achrak", "Balgbolg", "Balgloz", "Bilgsnik", "Blokghak", "Bloknag", "Bolglikk", "Bugdokh", "Dokhyip", "Dufyig", "Flugslogkak", "Gadluk", "Gadshrig", "Gaksog", "Ghagdokh", "Ghagduf", "Gitblot", "Gitghag", "Gligdokh", "Glizyarp", "Glokarkziz", "Gogblot", "Irkspik", "Khadnad", "Ligsnark", "Lukkhad", "Makgrak", "Mubblok", "Mubstogg", "Nadnaz", "Nadshuk", "Nagblid", "Nigrag", "Nokgit", "Nukkburk", "Rakkrig", "Rokadz", "Rokmizsnig", "Shriggat", "Skragslig", "Skragsnit", "Skugnikk", "Slogrok", "Snaark", "Snarkskug", "Snatsnig", "Snigdokh", "Yadslai", "Yarpsnitglok", "Zatgrak"

* "half-demon female"

.. code-block:: lua

   "Aaggiu", "Azziu", "Brazskiu", "Bruhizil", "Draananil", "Draannalu", "Draanrula", "Drulgizil", "Guznalu", "Jurggiu", "Jurlyrr", "Kaazanil", "Kharklihyl", "Kraubau", "Krauija", "Kraujiul", "Kuazlyrr", "Kudulin", "Luriija", "Nidija", "Nidziu", "Ninjskiu", "Ninjsula", "Ranagizil", "Ranagziu", "Rilthudiu", "Ruzzihyl", "Saagbau", "Skaurskiu", "Ulthuulla", "Urzbau", "Urzizil", "Urzlihyl", "Urzlyrr", "Urznalu", "Vlagnalu", "Vlashdiu", "Vlukskiu", "Vluzakzihyl", "Vrazdiu", "Vulkrula", "Vulkziu", "Xauzihyl", "Xidlin", "Xulrula", "Xurajija", "Zugdiu", "Zuldudusla", "Zuldurula", "Zuvlyrr"

* "half-demon male"

.. code-block:: lua

   "Aagzuk", "Alurinu", "Aziklank", "Azikundak", "Azlurug", "Azsul", "Bruhlank", "Draanlank", "Draansul", "Guzarag", "Guzull", "Idrunal", "Jhaalbru", "Jidarag", "Jidull", "Jurzinu", "Kargruzuk", "Krivull", "Kudulurr", "Kuduruzuk", "Luriinu", "Lurizu", "Mulkdrul", "Mulkrul", "Nidundak", "Ninjlank", "Ninjlurr", "Nullurug", "Ranagrul", "Ranagundak", "Rulkdrul", "Rulkzu", "Ruzsalk", "Saaglurr", "Vlaajxulg", "Vlagdrul", "Vlagsalk", "Vlashnal", "Vlashrul", "Vlashzu", "Vulknal", "Xaudrul", "Xauzu", "Xullank", "Xulxulg", "Xurajruzuk", "Xurajruzuk", "Zuldulun", "Zulduxulg", "Zulduzuk"

* "halfling female"

.. code-block:: lua

   "Adelheid", "Alexis", "Allison", "Alyssa", "Amanda", "Audofleda", "Begga", "Berenga", "Berenga", "Bertha", "Bertha", "Bertha", "Bertha", "Caitlin", "Camelia", "Camelia", "Chrodechildis", "Chrodechildis", "Darby", "Ellinrat", "Erica", "Erica", "Esmee", "Genofeva", "Genofeva", "Gomatrudis", "Haley", "Kaitlyn", "Laura", "Leesha", "Lily", "Mary", "Mary", "Melissa", "Menegilda", "Mimosa", "Mimosa", "Myrna", "Myrtle", "Natalie", "Pervinca", "Ragnachilde", "Rotrud", "Rotrudis", "Shelby", "Terri", "Theodelinda", "Theodrada", "Theutberga", "Vulfegundis"

* "halfling female 2"

.. code-block:: lua

   "Adela", "Adela", "Adra", "Aila", "Ailia", "Ailwisa", "Alma", "Almwina", "Ambia", "Bandia", "Barda", "Benia", "Benice", "Biffice", "Biffina", "Biffwina", "Bildily", "Blanca", "Blanca", "Blanca", "Bomba", "Bungia", "Drogwina", "Durlwina", "Emma", "Everily", "Everwisa", "Ferda", "Froba", "Fulbice", "Fulbina", "Gama", "Gamily", "Gamwisa", "Hascina", "Hodice", "Hodily", "Ivina", "Milice", "Odia", "Saba", "Sabice", "Sabina", "Sabwina", "Toba", "Tobia", "Wania", "Wanice", "Wigice", "Wydia"

* "halfling male"

.. code-block:: lua

   "Agilbert", "Andica", "Angilbart", "Balbo", "Balbo", "Balbo", "Berchar", "Bero", "Bertin", "Blanco", "Bucca", "Clodio", "Clodio", "Erard", "Goisfrid", "Gundovald", "Guntramn", "Harding", "Heribert", "Heribert", "Hildebald", "Hildebald", "Hildibrand", "Huebald", "Humbert", "Imbert", "Imnachar", "Imnachar", "Isengrim", "Isengrim", "Marcus", "Nick", "Pancras", "Riquier", "Sadoc", "Siegfried", "Sunno", "Taurin", "Taurin", "Thankmar", "Theudebald", "Theudebald", "Tobold", "Tobold", "Togo", "Waldolanus", "Waltgaud", "Willibrord", "Zwentibold", "Zwentibold"

* "halfling male 2"

.. code-block:: lua

   "Adald", "Adelo", "Adro", "Adro", "Adrwin", "Adwise", "Ailold", "Albwin", "Albwise", "Almald", "Bardold", "Benald", "Beno", "Benold", "Blanco", "Blancwin", "Boffo", "Bombard", "Bombfast", "Bramo", "Bungard", "Drogo", "Durlo", "Durlo", "Durlwin", "Emmald", "Emmwin", "Erdo", "Ernard", "Falco", "Ferdert", "Ferdo", "Fulbo", "Haldard", "Haldo", "Haldo", "Hamfast", "Hamo", "Hascard", "Hugfast", "Hugo", "Markert", "Milert", "Milo", "Samfast", "Sego", "Serlo", "Serlo", "Tobo", "Tobold"

* "halfling surname"

.. code-block:: lua

   "Banks", "Bilberry", "Bilberry", "Boffin", "Boulderhill", "Brandagamba", "Brown", "Brown", "Brownlock", "Bunce", "Burrowes", "Diggle", "Diggle", "Farfoot", "Fleetfoot", "Galbassi", "Goodbody", "Goodbody", "Goodbody", "Goodchild", "Goodchild", "Greenhill", "Greenhill", "Hairyfoot", "Hayward", "Headstrong", "Hogpen", "Hornblower", "Hornwood", "Knotwise", "Langham", "Leafwalker", "Lightfoot", "Littlefoot", "Littlefoot", "Lothran", "Oldbuck", "Proudbody", "Proudfoot", "Proudmead", "Puddifoot", "Puddifoot", "Rumblebelly", "Sackville", "Sackville-Baggins", "Sandheaver", "Silentfoot", "Smallburrow", "Took", "Wanderfoot"

* "human female"

.. code-block:: lua

   "Aelfsige", "Aenescyne", "Aranor", "Armnoth", "Bayhere", "Bealdhun", "Bealdric", "Belin", "Beorhtglaed", "Beryan", "Betyna", "Chesten", "Cuthgyth", "Cyrevea", "Cyrussra", "Deorflaed", "Eadhere", "Ealdfrith", "Ealdgifu", "Ealdwacer", "Ealdwythe", "Ealhweald", "Eilinorerin", "Emewyn", "Emora", "Eseld", "Godmon", "Hildhere", "Holrta", "Iville", "Iville", "Leodheard", "Leofburg", "Leofwig", "Mayibeth", "Mildburg", "Mildleofu", "Mildric", "Osor", "Saecromb", "Saegyth", "Saeor", "Saestrang", "Salunn", "Sigesnel", "Sunugyth", "Swetor", "Tekver", "Tilastrang", "Xanalle"

* "human male"

.. code-block:: lua

   "Aelfweard", "Aethelrand", "Aethelweald", "Baerhdeor", "Balrek", "Belgeat", "Burgbeald", "Caddaraed", "Daegwulf", "Dagrkath", "Daimvon", "Dairntir", "Dealgeat", "Drbar", "Dunbert", "Eadgard", "Ealhgeat", "Earwict", "Erelqzor", "Garhere", "Garwald", "Gawen", "Gerens", "Godbote", "Godmael", "Goldgar", "Hereric", "Hrofhere", "Isszor", "Malfkor", "Ormewine", "Osbeald", "Perran", "Saeweald", "Saeweald", "Selgar", "Sigeheah", "Sigmund", "Thurgar", "Thurmaer", "Triston", "Turhir", "Ulasus", "Ulsus", "Wella", "Wigmaer", "Winehard", "Withell", "Wulfgrim", "Wulfrun"

* "human surname"

.. code-block:: lua

   "'Beard' Blount", "'Bloodmouth' Crookbain", "'Bright' Smalley", "'Cook' Saransson", "'Good' Duke", "'Ironic' Bontick", "'Old' Allerton", "'Pegram' Motiuelle", "'Stonearm' Artre", "'Stout' Crisp", "Aciltrius", "Alranerdottir", "Berriman", "Blunt", "Buck", "Caeredius", "Carrellius", "Cerrianus", "Clive", "Cnililia", "Curtlilius", "Decintanus", "Double-Legs", "Ellis", "Fry", "Goodwin", "Grant", "Hackney", "Haggard", "Halfhand", "Harorkesdottir", "Northerner", "Northerner", "Norton", "Peagrim", "Perrin", "Pratt", "Pudding", "Pure-Smith", "Ratodicus", "Raven", "Rock-Hewer", "Rowe", "Snow-Crusher", "Snow-Crusher", "Strong", "Trollope", "Unseen", "Vinkwell", "the Cook"

* "infernal 1"

.. code-block:: lua

   "Aiazjuyil", "Aiazrualu", "Avuzeyee", "Azaz-rugro", "Azazuvutu", "Baelzaitha", "Bazozgro", "Breazlurhz", "Bul-algarl", "Drauvuziel", "Druirbuz", "Ghaaujhuz", "Ghauuvshai", "Grelogarl", "Gura-arglau", "Guzruvul", "Gzirahra", "Hriz-uvyee", "Hziyunal", "Idrau-urhez", "Iuzazdre", "Juujaalz", "Kraaruthalu", "Kraayomau", "Kulorjuu", "Kuluzduoi", "Liluuzhruz", "Lurhzujvuul", "Lurhzzudrau", "Malruyaa", "Nasuyusoaz", "Oxu-zuglau", "Oxuzenee", "Pazulrez", "Rhuuayjuu", "Rizzaraal", "Rizzossu", "Ruezmoz", "Ruyusoaz", "Ssuezaiaz", "Szuluzghu", "Thaluernal", "Thaluzibaal", "Thoeybuz", "Tholugzi", "Ulchruzighaa", "Yilorghu", "Zielribaz", "Zuujsau", "Zuuvobaph"

* "infernal 2"

.. code-block:: lua

   "Aghlizug", "Algjukrolg", "Baugozmag", "Blogiraig", "Boajlokwarg", "Brelgvorung", "Bubivtzolg", "Chag-ilbaug", "Drog-ozthaug", "Drogevszug", "Frubazfulg", "Glabuliub", "Haagoygrolb", "Haagurkrolg", "Hurgilbarg", "Iugujthaug", "Julbyotrob", "Krolgavdruj", "Kwargruigg", "Leeghliogg", "Lolgvafulg", "Morgazdrog", "Nalbzumoab", "Nudulraug", "Nulbzaraug", "Obbaltzolg", "Oggriuag", "Riggyathog", "Roggroiog", "Sagjabulg", "Sagjoraag", "Shub-vehrud", "Shubilvulb", "Shubyumag", "Sug-zuraag", "Szugzotzolg", "Thargvujub", "Thaugijsug", "Thaugzofulg", "Thogvojub", "Uagijtharg", "Uagolszug", "Uagulnog", "Uagyitrob", "Ulbizdaurg", "Vogtozrung", "Vulb-juhurg", "Vulbrumaug", "Yibbyoyeeg", "Zub-orolb"

* "infernal 3"

.. code-block:: lua

   "Bahor-urkrych", "Boakzaloch", "Charnyiutuk", "Chonarluth", "Dakarinax", "Dek-jiurt", "Draumujhoth", "Duumvirhast", "Fesh-roruaak", "Gaanvotash", "Glaurargoch", "Glaurorlach", "Glaurrudun", "Gochulrhast", "Gothormoth", "Hothzutlizit", "Hraxveyalm", "Hunujlech", "Igmuvuzt", "Irschijvrok", "Lechlunoc", "Lis-ulazt", "Liskozmat", "Lokuygek", "Metrasark", "Nervusoth", "Nilvlegor", "Nocjaralk", "Nuurlidraum", "Och-zulach", "Ochuyrauk", "Rutturvrok", "Ruun-ollach", "Ruun-riazt", "Saurzidun", "Soth-linilv", "Soth-ovtash", "Sothovoch", "Sothvabrax", "Suttzeslarv", "Sutulmat", "Tashzahoth", "Thalkyukos", "Turojmat", "Utukovlok", "Utukyahrax", "Vapovsot", "Vrok-zutash", "Xaasyacharn", "Yalmrabas"

* "ogre female"

.. code-block:: lua

   "Arghkrodghy", "Barshkurghy", "Barshnargah", "Burzhrungah", "Burzluzya", "Dofarghah", "Droksludya", "Dubzugy", "Dugobbya", "Dulgruzay", "Dulsnadya", "Durshgomah", "Ghakhgrukay", "Ghakhnargah", "Ghukkshuzgholghy", "Gludghashay", "Gluggrutghy", "Groggyugghy", "Grolslugah", "Grufobbgah", "Grulgroggdrugay", "Grulslugya", "Gruthulkgah", "Grutkulky", "Grutslugy", "Grutury", "Gruzshurah", "Guhlkugghakhgah", "Hrungurkhghy", "Kulkgrumya", "Lugsnoggah", "Lushslubay", "Makhmakhy", "Makhmudgah", "Molgrolbay", "Muddushsnadah", "Muzddubah", "Narglurzya", "Rolbzudghy", "Ruzrukhah", "Shrufshuggah", "Shuggrufya", "Urdurshghy", "Urghgrokgah", "Urghklobay", "Urkhkulkya", "Yugobbghy", "Zudgrukah", "Zudthulkay", "Zuggrufy"

* "ogre male"

.. code-block:: lua

   "Dofmud", "Drokguhlhurg", "Drugslub", "Durshyug", "Duzulg", "Ghakhlurz", "Ghashargh", "Ghormaug", "Ghorur", "Ghukkshug", "Ghukkyug", "Glugkulk", "Grufdush", "Grufslud", "Grukghakh", "Grulkur", "Grummakh", "Gulvdof", "Hrungargh", "Hurggluz", "Hurggrash", "Kaigruf", "Kulkgruf", "Kurhur", "Lorgdrok", "Luggrokuz", "Lugurd", "Mugbarsh", "Mugnakh", "Obbglug", "Obbgraddub", "Obbmaugbog", "Rolbgruk", "Rolbgrut", "Shargglud", "Shurslub", "Sludgrut", "Slugdrok", "Snadmolg", "Snadslub", "Thragdub", "Thragkrod", "Thurkghakh", "Urghmug", "Urghur", "Urgrok", "Yuggludgru", "Yurdrok", "Zudglub", "Zudshargkur"

* "orc female"

.. code-block:: lua

   "Basht", "Bogdakh", "Bogdk", "Bolar", "Bugdurash", "Bugdurash", "Bugdurash", "Bulba", "Bumph", "Burub", "Durgrz", "Durz", "Durz", "Gashbul", "Gluronk", "Gluronk", "Gonk", "Gonk", "Grat", "Grat", "Homlur", "Lagagakh", "Lambug", "Lash", "Lash", "Mogabog", "Mogak", "Mogak", "Mogak", "Mogak", "Morntharz", "Murmalah", "Oragha", "Orbuh", "Orbuh", "Ragarol", "Shagdub", "Sharak", "Shardurz", "Sharog", "Shazgob", "Shelmalah", "Shelur", "Ulumpha", "Umog", "Umog", "Uroga", "Ushat", "Volrog", "Voltur"

* "orc female 2"

.. code-block:: lua

   "Augrashay", "Badsnurray", "Bakhgrathgah", "Bashgnarlgah", "Bashmuzghy", "Bazbazy", "Bazkragay", "Bazyobya", "Bragkhaggah", "Bragyobya", "Broggudghy", "Bruzguty", "Dargdrabah", "Dogrugah", "Drabgolah", "Dugruftay", "Durrutghazghy", "Ghazdagay", "Globbadghy", "Gnarlbruzlakhay", "Gnashbruzgah", "Gnubrashah", "Gobrotbragy", "Golkgutah", "Grashlashghy", "Grotgrathah", "Khaggudlobah", "Kragmukah", "Kragungay", "Krudtrogghy", "Lakholgay", "Lufglurghy", "Mukstulgghy", "Mukungah", "Rotdaggah", "Rudsnurry", "Ruftbakhay", "Rugbashay", "Rutglufya", "Rutgorah", "Shagsnorlghy", "Skulgzahkhruggah", "Snargrazya", "Snorllashya", "Snublobghy", "Thakungsnorlah", "Trogglazay", "Yobbashah", "Zahkghazghy", "Zahkgrazghy"

* "orc male"

.. code-block:: lua

   "Abghat", "Azukb", "Barokub", "Baroulakh", "Bogakh", "Bogakh", "Buomaugh", "Clog", "Crothu", "Ghazat", "Ghazat", "Gluh", "Graus", "Graus", "Grogumph", "Guabagorn", "Hugmug", "Khaguk", "Khaong", "Largug", "Mahk", "Maszum", "Muluin", "Mulunok", "Nagrmborz", "Nakgu", "Oglha", "Olpel", "Olurgash", "Oogugbu", "Orokmba", "Shamrkub", "Sorgulg", "Spathu", "Spathu", "Spathu", "Ughagnak", "Ughagog", "Urburum", "Urgan", "Uzgba", "Vorgarag", "Wanug", "Xoruk", "Xuag", "Yargron", "Yatan", "Yatan", "Yerug", "Yolmar"

* "orc male 2"

.. code-block:: lua

   "Agglur", "Aglud", "Badung", "Bagslur", "Bagzahk", "Braglash", "Bruzmuz", "Daghag", "Dakklub", "Darglob", "Dargstulg", "Dogzahk", "Dugskulgthak", "Glakhmuz", "Glazag", "Glolzog", "Grakhug", "Grathdag", "Gudkrag", "Haglash", "Hratghaz", "Khagdakk", "Krudbruz", "Lobhrug", "Lubbash", "Lufshak", "Molkluk", "Mukkrud", "Muzshad", "Olgdob", "Raggut", "Raghrug", "Ragshaz", "Roggrud", "Roggyashrud", "Rudyobgokh", "Rugyakh", "Shazlufgut", "Shoggrub", "Snorlbrag", "Snurrogg", "Snurryash", "Sodbash", "Sodgokh", "Stulgroggkhar", "Thakshad", "Troggokh", "Yashgrakh", "Yobthak", "Yobyash"

* "orc surname"

.. code-block:: lua

   "Bagrsh", "Baraek", "Baraek", "Bargzuf", "Bargzuf", "Bargzuf", "Barogham", "Barorba", "Batrak", "Bogath", "Bolbak", "Bolbak", "Bolmrolg", "Borgham", "Buglul", "Bumptur", "Bural", "Buzrat", "Dughol", "Durgzol", "Dushgub", "Gharfish", "Ghodu", "Glogob", "Gorum", "Gorum", "Gulfgakh", "Gurudu", "Gurwog", "Kasmgog", "Khagat", "Khatmakh", "Lumdborgob", "Luzgbek", "Luzgub", "Luzph", "Magagramph", "Maroilslag", "Mogan", "Orbuduk", "Orkgramph", "Rusmbak", "Sharzol", "Shaza", "Shulharzol", "Ufthdum", "Ugduku", "Ugrump", "Uzgrat", "Yaglob"

* "sprite female 1"

.. code-block:: lua

   "Flissanel", "Flissasti", "Fossinel", "Frissafer", "Frissasti", "Frissenti", "Frissinel", "Gesserel", "Glanamer", "Glaninel", "Glissenti", "Glissifer", "Hexarel", "Hexefer", "Heximer", "Minifer", "Mininel", "Mininel", "Raffifer", "Raffimer", "Ressefer", "Ressifer", "Riffarel", "Riffasti", "Riffasti", "Rillamer", "Rillimer", "Saffafer", "Saffarel", "Saffefer", "Shimanel", "Shimefer", "Shimimer", "Tinkenti", "Tinkenti", "Tinkirel", "Tisserel", "Trillifer", "Trillimer", "Tristasti", "Twillanel", "Twillarel", "Twispanel", "Twissifer", "Twixifer", "Twixirel", "Weskafer", "Wispafer", "Wispafer", "Wispinel"

* "sprite female 2"

.. code-block:: lua

   "Crylkiss", "Cryltiss", "Crylynx", "Elsiniss", "Emberliss", "Embernyx", "Eskriss", "Ferisla", "Ferissa", "Frimiliss", "Ganree", "Glinkliss", "Glinkmee", "Glinksa", "Glinkynx", "Helkiss", "Helsa", "Helynx", "Histnyx", "Ispella", "Ispelmee", "Ispelynx", "Istlenyx", "Istleree", "Jatree", "Jostniss", "Jusnyx", "Lirradee", "Malila", "Malisa", "Minkdee", "Minkniss", "Ninkadee", "Ninkaynx", "Ninkaynx", "Opalla", "Opalnyx", "Orifynx", "Orisnyx", "Sprinla", "Sprinree", "Sprinriss", "Sprinynx", "Stithmee", "Stithnyx", "Tirraniss", "Trumpree", "Zandoniss", "Zandoriss", "Zandotiss"

* "sprite male 1"

.. code-block:: lua

   "Dexamo", "Dexasto", "Flaxaldo", "Flaxaron", "Flisseron", "Flixendo", "Flixondo", "Fossasto", "Fosseroll", "Friskeroll", "Frissendo", "Frisseroll", "Gessamo", "Gessaron", "Gessesto", "Glanando", "Glaxaldo", "Glaxamo", "Glaxaroll", "Glaxasto", "Glimamo", "Glimaroll", "Raffamo", "Raffondo", "Ressando", "Ressando", "Riffaldo", "Shimasto", "Shimondo", "Tissaldo", "Tissaldo", "Tissaroll", "Tissasto", "Tissesto", "Trillaroll", "Trilleron", "Twillondo", "Twispallo", "Twispendo", "Twixeron", "Weftesto", "Weftesto", "Weskaldo", "Weskando", "Weskeroll", "Weskeron", "Winnaroll", "Winnaron", "Winnondo", "Wispamo"

* "sprite male 2"

.. code-block:: lua

   "Briswin", "Cryltwik", "Embermit", "Emberwin", "Eskmist", "Ferisrix", "Frimimist", "Ganbrix", "Haltwik", "Halwin", "Halzisk", "Histfret", "Histmist", "Histrix", "Histwin", "Iphilbik", "Iphiltross", "Iphilzisk", "Ispelkin", "Ispeltross", "Ispelwin", "Istlefrell", "Istlekin", "Istletwik", "Jostrix", "Jusfrell", "Jusmist", "Jusmit", "Jusmit", "Malitross", "Malitross", "Minkkin", "Minkmist", "Minktross", "Minktwik", "Mirrafret", "Mirrakin", "Mistlekin", "Ninkazisk", "Orifkin", "Sarmbrix", "Sarmmit", "Sprinbrix", "Sprinwin", "Stithbik", "Stithtwik", "Tansitross", "Tirrafret", "Whiskin", "Zandofrell"
