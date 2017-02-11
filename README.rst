LuaNameGen - Lua Name Generator v1.0.0
=======================================


Inspiration
------------


Code
*****

This script is heavily inspired by `libtcod's namegen`_, written by Dominik "Mingos" Marczuk.

.. _`libtcod's namegen`: https://bitbucket.org/libtcod/libtcod/src/afba13253a79f16d10f596e2c9c99cf183f94b3c/src/namegen_c.c


Names
******

    **Some of the appeal of imaginative literature comes from the exotic worlds and characters it conjures up. One way it distances itself from the everyday world is by using unfamiliar and evocative names. If the characters are Sally, Bill, and Fred, you are rooted in the mundane. If they are Hyssome, Drythe, and Rimsall, you are obviously beyond the fields we know, and the stage is set for wonders. The same applies to role-playing games using imaginative settings.

        Gary Gygax (Gary Gygax's Extraordinary Book of Names)**

The patterns that ship with this script here are based on:

* `libtcod's namegen existing sets`, written by Mingos and Jice;
* Gary Gygax's Extraordinary Book of Names suggestions for fantastic names;
* `fantasynamegenerators.com`_;
* `fantasynamegen.com`_;
* `creative-role-playing.com`_ fantasy-sounding-names;

.. _`fantasynamegenerators.com`: https://fantasynamegenerators.com/
.. _`fantasynamegen.com`: https://www.fantasynamegen.com/
.. _`creative-role-playing.com`: http://web.archive.org/web/20141009095317/https://www.creative-role-playing.com/fantasy-sounding-names/


Basic usage
------------

To get a dwarf name and surname, using default sets, just do

.. code-block:: lua

   local namegen = require("namegen")

   local name = namegen.generate("dwarf male")  --  Dolin
   local surname = namegen.generate("dwarf surname")  --  Steelcutter


How does it works?
-------------------

When loaded/required, the module "namegen" parses the set files pointed by 'namegen.index' (a plain text file).
Each set file (also plain text files) follows a simple syntax (libtcod's syntax, so any .cfg file from it can be used), and may contains multiple sets. This is an example of a basic set:

.. code-block:: none

   name "dwarf male" {
       syllablesStart  = "Do, Due"
       syllablesEnd = "lin, rin"
       rules = "$s$e"
   }

Sample generated names
-----------------------

This is a list of a few names genereated by the default sets:



* "doughty dwarf female"

   "Baldis", "Baldis", "Bornlind", "Bornnis", "Brimdis", "Brimlind", "Brodvis", "Brokkdis", "Brombis", "Bruhild", "Burlna", "Burrun", "Burrun", "Burvis", "Dahild", "Danis", "Dorlis", "Drimrith", "Dromlind", "Dromrun", "Durmlind", "Fromdis", "Frorda", "Fundga", "Fundris", "Gimdis", "Gonddis", "Gormda", "Gormda", "Grodda", "Hordna", "Nadis", "Navis", "Nordrun", "Ormda", "Skonddis", "Skondlind", "Stromvis", "Sturis", "Sturlda", "Sturlhild", "Sturlif", "Sturlis", "Sundrith", "Thornlis", "Thrada", "Throdis", "Throllif", "Throrlis", "Thunddis"


* "doughty dwarf male"

   "Baldin", "Balir", "Ballin", "Bornin", "Bornli", "Brimdin", "Brimli", "Brodrur", "Bruvi", "Burlin", "Burrin", "Dali", "Dalin", "Dorvor", "Dralin", "Dralror", "Durdin", "Durmir", "Durnli", "Fundrin", "Gloir", "Gormri", "Gradri", "Grimvi", "Grodrur", "Grodrur", "Gromdin", "Gromri", "Gromvir", "Guldin", "Guldri", "Gurin", "Hordnir", "Hordrok", "Nali", "Nordri", "Ormri", "Skandbor", "Skandnir", "Skondin", "Sturllin", "Sturlri", "Thornin", "Thornnir", "Thornvor", "Throllin", "Throlrur", "Thrubor", "Thrurror", "Thundrok"


* "dragon female"

   "Adastraborossa", "Adracalchaxis", "Adraneriaxis", "Aragcalchaxis", "Archocalchaxis", "Atrabazia", "Atramandrossa", "Baravoraxis", "Bhakribradaxis", "Biamanthysa", "Biazzebraxis", "Bradophylaxis", "Branaluxis", "Chrysocordaxis", "Glaunaluxis", "Harbazia", "Hurocordaxis", "Jazramalaxis", "Jazrazzemalis", "Jurgabazia", "Jurgamalaxis", "Keruxaneriaxis", "Keruxavorunga", "Kralkavorunga", "Marmalaxis", "Marmorazzemalis", "Marvoraxis", "Melkarneriaxis", "Orgracalchaxis", "Orgracordaxis", "Phorolagonis", "Phorovoraxis", "Pyrabazia", "Pyramalaxis", "Rauzzebraxis", "Rauzzemalis", "Rhadacalchaxis", "Rhemanthysa", "Rhodophylaxis", "Sarbradaxis", "Sarcunaluxis", "Sardacordaxis", "Scarvalagonis", "Scarvamordaxis", "Sulchrunadralix", "Trochoneriaxis", "Zalarborossa", "Zalarmandrossa", "Zerulcalchaxis", "Zerulcalchaxis"


* "dragon male"

   "Abramanthys", "Abravorung", "Adastrazzebrax", "Adastrazzemal", "Adracalchax", "Ancaboros", "Ancaboros", "Ancacordax", "Andralagon", "Aragphylax", "Archomanthys", "Archonalux", "Archovorax", "Archozuthrax", "Barcordax", "Beruzzemal", "Bhakriboros", "Bhakribradax", "Bhakriphylax", "Biamordax", "Biazzemal", "Brimabazius", "Glaunadral", "Glauzuthrax", "Jalanzzebrax", "Jarzemxenor", "Jazranalux", "Jazravorax", "Majurinadral", "Majurizzebrax", "Malachonadral", "Malachoxenor", "Malachozzebrax", "Marboros", "Orgrazuthrax", "Peridonalux", "Phorocalchax", "Phrixumalax", "Pyramandros", "Rhodomandros", "Rhodomanthys", "Scarvabradax", "Skhiaphylax", "Sulchruzuthrax", "Tchalcedonalux", "Tchazarbazius", "Tchazarmordax", "Trochonalux", "Trochozzebrax", "Zalarcalchax"


* "dwarf female"

   "Abra", "Alba", "Alden", "Atha", "Banryn", "Bina", "Boghild", "Boghild", "Bomtha", "Darhild", "Dedi", "Difra", "Diiess", "Diya", "Dogra", "Dora", "Duema", "Duerali", "Dunda", "Edsyl", "Farihild", "Farika", "Flosen", "Frelaani", "Fukala", "Gabida", "Grodmila", "Gwarev", "Inmae", "Jegna", "Kalona", "Kanka", "Kitu", "Manda", "Meya", "Nadeth", "Nalla", "Odrun", "Oev", "Rasmala", "Rasnuda", "Rasov", "Rinka", "Roiess", "Telev", "Telryn", "Thonta", "Toriess", "Zanuda", "Zeshan"


* "dwarf male"

   "Balbek", "Banderel", "Bomni", "Bondir", "Brutram", "Catomir", "Dandrum", "Darrin", "Dhozolir", "Dolin", "Dueni", "Dwatri", "Falri", "Falvil", "Fimil", "Firil", "Fithur", "Fremil", "Gaden", "Garbur", "Gimvri", "Glotri", "Gomran", "Groril", "Hotdram", "Ibrin", "Ibvi", "Jorran", "Jorun", "Kani", "Karin", "Kavim", "Kivil", "Krob", "Loni", "Lurin", "Ragthran", "Rasri", "Renden", "Svun", "Tathur", "Telvi", "Thimur", "Thovil", "Velkias", "Viros", "Vonchar", "Vonthur", "Werfri", "Werin"


* "dwarf surname"

   "Bear-Executioner", "Bearbane", "Blackhead", "Bronzeaxe", "Bronzecarver", "Bronzehead", "Bronzesmith", "Coalbender", "Coalheart", "Coalheart", "Dragonbutcher", "Dragonchoker", "Ettinchoker", "Fieryfist", "Foe-Battler", "Giant-Garrotter", "Gnome-Beheader", "Goldbreaker", "Goldenhammer", "Granitecarver", "Granitedigger", "Graniteforger", "Graniteminer", "Greymace", "Hammercrusher", "Hardfist", "Ironhammer", "Ironsmasher", "Marblecrusher", "Metalclub", "Metalfist", "Mithrildigger", "Moonpike", "Noblefoot", "Oakshield", "Orc-Executioner", "Orc-Strangler", "Orcslicer", "Redfinger", "Steelfoot", "Stonedigger", "Stonefinger", "Stonesmasher", "Stronghand", "Strongspike", "Strongsword", "Thunderminer", "Wolfbutcher", "Wolfkicker", "Wyvernsmasher"


* "elf female"

   "Alaglossa", "Alaglossa", "Alaglossa", "Alea", "Alea", "Alyndra", "Alyndra", "Alyndra", "Axilya", "Caerthynna", "Caerthynna", "Caerthynna", "Cyithrel", "Cyithrel", "Cyithrel", "Cyithrel", "Cyithrel", "Darunia", "Deularla", "Elasha", "Elasha", "Eloimaya", "Eloimaya", "Esyae", "Falenas", "Faraine", "Gaylia", "Haera", "Isilynor", "Iythronel", "Kethryllia", "Lura", "Lymsleia", "Lymsleia", "Lyra", "Nyna", "Phyrra", "Pyria", "Pyria", "Shadowmoon", "Shandalar", "Sheedra", "Teryani", "Tsarra", "Tsarra", "Urmicca", "Urmicca", "Vestele", "Viansola", "Yaereene"


* "elf male"

   "Ailluin", "Aiwin", "Alabyran", "Almon", "Alosrin", "Anfalen", "Anlyth", "Anlyth", "Aywin", "Cluhurach", "Felaern", "Folmar", "Folmon", "Goras", "Inialos", "Josidiah", "Josidiah", "Khatar", "Kiirion", "Kolvar", "Maeral", "Maiele", "Maiele", "Melandrach", "Melandrach", "Molostroi", "Morthil", "Myrddin", "Mythanthar", "Nremyn", "Nremyn", "Oenel", "Oenel", "Olaurae", "Orist", "Phraan", "Rhys", "Rhys", "Rilitar", "Rilitar", "Riluaneth", "Shaundyl", "Theodred", "Theodred", "Triandal", "Vander", "Vesstan", "Vulmon", "Vulmon", "Xhalth"


* "empyreal female"

   "Alanteleth", "Alantes", "Amaneleth", "Amarset", "Ansamet", "Araneleth", "Asaneth", "Asarnel", "Asarnenth", "Atarenth", "Avareth", "Avraler", "Avraleseth", "Avraleth", "Jal-ravan", "Jaranenth", "Jasarmenth", "Kalasten", "Katarnes", "Kavalen", "Paladeseth", "Palanteth", "Ranaleseth", "Ranaleseth", "Ranarer", "Rasanet", "Ravaneleth", "Ravanen", "Samarenth", "Sar-alant", "Saranereth", "Saranes", "Saraneseth", "Saraten", "Sarnatenth", "Solarenth", "Solarer", "Talaneth", "Talareth", "Talasel", "Tar-aran", "Taranenth", "Taranes", "Valareth", "Valareth", "Valmaret", "Valnoreth", "Valorenth", "Vanaren", "Var-kalad"


* "empyreal male"

   "Adrastathal", "Alantan", "Alantas", "Amadathal", "Amanath", "Amarsal", "Amartat", "Ar-ravan", "Aradan", "Aradanth", "Aradath", "Aramath", "Aranat", "Aranath", "Asanar", "Asanat", "Astarath", "Atarathar", "Avralath", "Jasalath", "Kal-jasal", "Kaladath", "Kalasathal", "Katarnathar", "Kavalathal", "Klaronath", "Palantar", "Palantas", "Paloranth", "Ral-vardar", "Ranalan", "Ranarath", "Rasanas", "Rasanath", "Ravanas", "Samaranth", "Saranathas", "Sardanathas", "Solaranth", "Tal-kalar", "Talaras", "Talonathas", "Tavalan", "Valkaran", "Valkaranth", "Valmaras", "Valnarath", "Vanarathas", "Varamath", "Voltarathar"


* "fair noble elf female"

   "Aegmindadril", "Aegraelthalel", "Aegserenien", "Aelthaloliel", "Aermarolsil", "Aethsilenedel", "Anmelevwë", "Arnimesedel", "Arseldaledel", "Bersaramril", "Caelmindthalriel", "Caelmitholeth", "Caelthirthalien", "Caersilmthalrien", "Caertheloliel", "Callithedrial", "Calmarerroël", "Calnimemrian", "Calninthaliel", "Celsarilrian", "Cirlarevian", "Cirraelirriel", "Earlithanien", "Elrinevril", "Elthaeladsil", "Elthmeledeth", "Eolsaerasroël", "Ermelthaledel", "Faerimadiel", "Faersaradsil", "Feannitholwë", "Findrindthalloth", "Findsaeredwen", "Findthaerirriel", "Galmelebriel", "Galmiradrian", "Galnimthalwen", "Ganralarel", "Garsaerelriel", "Gellorelrial", "Gelrilemrian", "Gilranesrien", "Ilmnithebel", "Ithnithanian", "Laegmelthonroël", "Laegrindarriel", "Lendmaegarwen", "Lendsarirrial", "Lendtheliniel", "Lendthiranrial"


* "fair noble elf male"

   "Aelmithenrod", "Aelthaerelion", "Aesmarthallas", "Aethseldedion", "Anistildan", "Arnimevros", "Arranebdir", "Arrimalad", "Belsaerendel", "Belseldthalros", "Belthaledrior", "Bermaegesion", "Bermindaror", "Caelseredlad", "Caelthaerevdil", "Caerlithilion", "Caermithadion", "Caertherirlad", "Calrimaslad", "Calthaeladnar", "Caristaslas", "Celranirion", "Celsilendil", "Cirlirelros", "Cirnirthalrod", "Clarinthonthir", "Crissilebion", "Earnithasdir", "Elbninarfal", "Elbninarlas", "Estlirevad", "Faerinadnar", "Faerliremad", "Findsilmasdil", "Finmindarrod", "Finraneddan", "Galiremdil", "Galmindinrond", "Garranasad", "Gilinthaldel", "Gilmirandan", "Gilnithanrior", "Gilralenrior", "Gilranthalrior", "Ilmmelalfal", "Ilmrimindel", "Ithsilmebras", "Laegrindeldil", "Laegtheradrior", "Lindnithenorn"


* "giant female"

   "Daoh-Giree", "Daoh-Lugh", "Daoh-Peh", "DaohGhad", "DaohMoghahgquagi", "DaohShom", "DaohShul", "DaohYeeh", "Dhaktih", "Doh-Ghad", "Doh-Mehbohr", "Doh-Shlo", "DohShlo", "Fah-Shlo", "FahGhah", "FahKhem", "Ghamrei", "Gireefah", "Gunri-Lah", "Hatoo-Rei", "Hatoo-Tih", "Lah-Naoh", "LahHoo", "Mih-Pogh", "MihGunrifeehm", "MihPuhguh", "MihWuh", "Nuh-Fah", "Pogh-Doh", "Pugh-Doh", "Rahoosoh", "Rei-Hah", "Rei-Snaoh", "ReiIgwah", "Rifoolah", "Snaohdaoh", "Soh-Khan", "SohAhg", "SohNaoh", "SohRahoo", "SohShourronkh", "Tih-Zhamchah", "TihMaoh", "TihSnaoh", "TihYaum", "Tuhlithomtih", "Ub-Daoh", "Ushsoh", "Yaumchahdaoh", "Yaumsoh"


* "giant male"

   "Bul-Gunri", "Chah", "Ehm-Gonkh", "Ghat", "Ghaw-Peh", "Ghee", "Ghee-Thom", "Giree", "Goun", "Goush-Faogh", "Gunri", "Hani-Hoo", "Haogh-Gunri", "Hatoobaod", "Hoo", "Khan", "Khan", "Khankham", "Khaznaroo", "Khee", "Khee-Shehi", "Lugh", "Maoh-Shul", "Meh-Baod", "Mogh-Hah", "Moghquagi", "Mouh", "Mugh", "Naoh", "Nuh", "Orf-Zham", "Oughbul", "Ouh", "Ouh-Wuh", "Ouhlugh", "Peh", "Pogh-Khaz", "Puh", "Rahoo-Maoh", "Rhoo-Shom", "Rhoofeehm", "Ronkh-Peh", "Saomehm", "Shom-Faogh", "Suth", "Thom", "Tregh", "Ub", "Ubghat", "Wahhah"


* "gnome female"

   "Banus", "Billeklinkle", "Bimkiulo", "Bimrgo", "Bipflonk", "Byloflink", "Byloflink", "Cargus", "Carvizz", "Dibink", "Dimbick", "Dimbick", "Dimbick", "Dindamink", "Dindamink", "Dinkulo", "Ditink", "Ditink", "Dosizz", "Fenflynk", "Fenyvizzle", "Filgus", "Fynkkink", "Gelulo", "Gelulo", "Glinbynus", "Glinbynus", "Gynnoago", "Juladink", "Katdomink", "Ketklinkle", "Ketris", "Kitlelinkey", "Liskink", "Liskink", "Lokeefizzy", "Lymtink", "Lymtink", "Lysthink", "Merdiwack", "Nittlebik", "Tallinkey", "Tallinkey", "Tallinkey", "Tannus", "Thinbythin", "Thinkkeesizzle", "Thinkkeesizzle", "Tilkink", "Tilkitinkle"


* "gnome male"

   "Baolink", "Bawack", "Bilkeefinkle", "Bimleeble", "Bimliarn", "Binaris", "Binkflonk", "Binklbus", "Binklbus", "Binwick", "Binwick", "Bolink", "Bonkbus", "Bonleble", "Bonleble", "Buris", "Burtink", "Carlobrick", "Diledus", "Dinkbitank", "Dobeeble", "Dobeeble", "Dobeeble", "Dodibrick", "Donkleedink", "Fenklink", "Fenklink", "Fenlflonk", "Finflonk", "Finkvash", "Gelklink", "Gelsizz", "Gelsizz", "Gimlulo", "Hinbmink", "Hinklosizz", "Hinklosizz", "Laflink", "Nitago", "Nitkeeklonk", "Nitkeeklonk", "Tenkathink", "Tenlink", "Tenlink", "Tenlink", "Thenflink", "Tockawick", "Tockawick", "Tovash", "Tovash"


* "gnome surname"

   "Acerpipe", "Berryspindle", "Berryspinner", "Blackbus", "Blackbus", "Castfizzle", "Clickgear", "Clickgear", "Clickspring", "Coggauge", "Draxlepipe", "Fastspring", "Finecrank", "Finefizzle", "Finesteel", "Finesteel", "Fizzleblast", "Fizzlepipe", "Gearwizzle", "Grindspan", "Mechaspan", "Mechasteel", "Mekkakettle", "Mekkakettle", "Puddlehouse", "Puddlehouse", "Puddlepipe", "Puddlespinner", "Sadbus", "Shortwhistle", "Spannerblast", "Spannerblast", "Sparkspanner", "Sparkspanner", "Sparkwhistle", "Springgear", "Sprygrinder", "Steamgauge", "Steamnozzle", "Steamnozzle", "Stormgrinder", "Stormgrinder", "Stormtorque", "Stormwizzle", "Swiftdwadle", "Swiftnozzle", "Tinkcrank", "Tinkmaster", "Twistcrank", "Wobblecrank"


* "goblin female"

   "Achgukgah", "Achshukah", "Adznazah", "Azakay", "Azsnigy", "Bilgyigy", "Blokbolgy", "Bloksniknigay", "Bolgdrikya", "Bugkrigay", "Burkblidya", "Drizkrigay", "Drizzizgah", "Dufbalgay", "Fluggaah", "Gadgaty", "Gahblidy", "Gakyipgah", "Gazbloty", "Ghagirkah", "Gitblokya", "Gliggligay", "Glokazy", "Glokspikay", "Guknazghy", "Higroky", "Kakflugghy", "Khadgadya", "Khadmazah", "Krigligy", "Maknagah", "Nadgazlakay", "Nadrokay", "Niggazghy", "Ragkhady", "Shrigadzya", "Shriggargah", "Shukglizay", "Skragyaggy", "Skugratya", "Snabligah", "Snatnokya", "Sniggatgah", "Snikshukay", "Togsnikghy", "Yagglikkay", "Yarpgarghy", "Yigslaigah", "Yiproky", "Zibkrigay"


* "goblin male"

   "Achzat", "Adzglat", "Adzgnat", "Blidglag", "Blidgrat", "Blidloz", "Bloknok", "Burkguk", "Burksnat", "Drikyip", "Drikzit", "Dufslog", "Flugsnat", "Gadduf", "Gadloznogg", "Gagblok", "Gakyig", "Glakglat", "Gligsnik", "Gogzib", "Higvark", "Khadach", "Krigirk", "Mizyad", "Nigsnit", "Nikkglag", "Ragglak", "Ragyark", "Ratsna", "Rokblid", "Rokgrat", "Shukmaz", "Skugslai", "Snatgar", "Snigglag", "Snignikk", "Spikzit", "Toggatgak", "Togloz", "Tognigsnig", "Togyarp", "Urfmak", "Urfmak", "Varknazgah", "Yarksog", "Yarpgad", "Yigga", "Yiggah", "Yipsnat", "Zizbolg"


* "halfling female"

   "Allison", "Alpaide", "Alyssa", "Amanda", "Amaranth", "Amber", "Bave", "Bave", "Berenga", "Bertha", "Camelia", "Camelia", "Cheryl", "Chrodechildis", "Diamond", "Engelberga", "Erica", "Erica", "Esmee", "Esmee", "Fatima", "Gudula", "Gudula", "Jenna", "Kaitlyn", "Kunegund", "Kunegund", "Leesha", "Leesha", "Luitgarde", "Marcatrude", "Marcatrude", "Marigold", "Mary", "Melissa", "Moira", "Moira", "Myrna", "Myrtle", "Pervinca", "Rotrudis", "Saffron", "Savanna", "Selina", "Shelby", "Tabitha", "Tasha", "Theoderada", "Theodrada", "Vulfegundis"


* "halfling male"

   "Aega", "Arnoul", "Arnoul", "Balbo", "Basso", "Bero", "Bilba", "Bilbo", "Bildad", "Blanco", "Bucca", "Clodio", "Drogon", "Enurchus", "Erard", "Faro", "Fastred", "Giseler", "Giseler", "Grossman", "Guntram", "Guntramn", "Heribert", "Hildibrand", "Lo", "Lotho", "Madoc", "Majorian", "Majorian", "Marachar", "Mauger", "Melampus", "Merimac", "Ragnfred", "Rathar", "Rathar", "Rathar", "Rathar", "Sadoc", "Taurin", "Thankmar", "Togo", "Togo", "Unroch", "Waldolanus", "Waltgaud", "Waltgaud", "Waltgaud", "Waltgaud", "Willibrord"


* "halfling surname"

   "Bolger-Baggins", "Brandagamba", "Brandybuck", "Brandybuck", "Brown", "Brown", "Brown", "Brownlock", "Burrowes", "Elvellon", "Featherbottom", "Fleetfoot", "Gammidge", "Gammidge", "Gluttonbelly", "Gluttonbelly", "Gluttonbelly", "Goodbody", "Goodbody", "Goold", "Greenhill", "Greenhill", "Hairyfoot", "Harfoot", "Hayward", "Heathertoes", "Heathertoes", "Heathertoes", "Hornblower", "Hornblower", "Hornwood", "Labingi", "Labingi", "Longfoot", "Lothran", "Lothran", "Oldbuck", "Proudfoot", "Proudfoot", "Proudmead", "Sandyman", "Smallburrow", "Took-Brandybuck", "Townsend", "Townsend", "Twofoot", "Twofoot", "Underlake", "Undertree", "Zaragamba"


* "homely halfling female"

   "Adelia", "Adina", "Adrice", "Adrwisa", "Albina", "Bandwisa", "Bardwisa", "Bena", "Biffia", "Biffia", "Bildia", "Bildice", "Bomba", "Bombina", "Brama", "Droca", "Droca", "Drocice", "Durla", "Ernwina", "Everwina", "Falca", "Falca", "Falcina", "Ferdily", "Gamwisa", "Haldia", "Hascia", "Hoda", "Hoda", "Hodwina", "Hodwisa", "Huga", "Huga", "Ivia", "Ivia", "Ivia", "Markwina", "Mungily", "Oda", "Oda", "Sabwisa", "Sama", "Samice", "Samina", "Sega", "Wanwisa", "Wiga", "Wyda", "Wyda"


* "homely halfling male"

   "Adelert", "Adelwin", "Adert", "Adro", "Ailwise", "Almert", "Ambard", "Bandfast", "Bandfast", "Bandold", "Bardo", "Benfast", "Biffo", "Biffwin", "Bildold", "Blanco", "Bombo", "Bungo", "Bungo", "Drogo", "Durlald", "Durlwin", "Erdo", "Erno", "Ernwise", "Falco", "Ferdard", "Ferdard", "Ferdo", "Frobwin", "Fulbo", "Gamo", "Haldard", "Haldert", "Haldfast", "Hasco", "Hasco", "Hodert", "Hodo", "Hugo", "Ivard", "Ivwise", "Milard", "Milo", "Milo", "Odo", "Othert", "Sabo", "Wano", "Wydald"


* "human female"

   "Adinor", "Adissra", "Aelfsig", "Aethelbeald", "Aethelmaer", "Aethelraed", "Bealdhere", "Beranweald", "Betomina", "Cwenburg", "Cynein", "Demelza", "Deorburg", "Deorsige", "Eadflaed", "Eadstan", "Ealdmaer", "Ealdrun", "Ealdson", "Frithbeald", "Goddeal", "Graegmaer", "Gunnwaru", "Haligwig", "Heathusige", "Helmsige", "Herlecyne", "Hildsige", "Isenor", "Islynn", "Ivithra", "Layedavea", "Leofmaer", "Leofor", "Leofwil", "Mayoldakira", "Mildrun", "Morwenna", "Nerama", "Rozenwyn", "Salywyn", "Secgflaed", "Thuror", "Velalle", "Vorokira", "Wiggifu", "Wineflaed", "Xerawe", "Zubana", "Zubuwyn"


* "human male"

   "A-bri", "Aelfkettil", "Aelfmund", "Aenesric", "Alagise", "Balrach", "Bardahard", "Beorhthun", "Bregudeor", "Breguson", "Cenarm", "Censige", "Chalrochak", "Chaltorek", "Cynebeorht", "Delmkor", "Deorgar", "Deorweald", "Ealdcromb", "Ealdmaer", "Ealhbeald", "Ervan", "Garsige", "Gilrek", "Godbeorht", "Godweard", "Gunndur", "Heanawulf", "Herebrand", "Hlar", "Hrofweard", "Hwitnoth", "Instan", "Leodhere", "Leofric", "Myghal", "Osraed", "Osstan", "Perran", "Sigeleof", "Sigeric", "Sigeweard", "Sjarguri", "Thurheard", "Wella", "Wigarm", "Winewulf", "Wulfheard", "Zldir", "Zlen"


* "human surname"

   "'Bishop' Trafield", "'Contemptible' Russell", "'Old' Cripps", "'Palmer' Dorain", "'Pegram' Hawkeye", "'Strong' Bulwark", "'Sweltering' Conidwine", "'Young' Brandy-Shield", "Andrewartha", "Atruius", "Baines", "Biedwulf", "Bold", "Brandy-Shield", "Brittle-Maiden", "Brown", "Care", "Cheek", "Cloud-Strider", "Coad", "Crow", "Curicinnius", "Dark-Bearer", "Despicable", "Fraslle", "Fraslle", "Godwin", "Harding", "Harorkesdottir", "Helton", "Mantanus", "Mojensvesdottir", "Moody", "Moreley", "Nuncdes", "Peacock", "Pelitian", "Pettit", "Plalia", "Plalia", "Presley", "Pudding", "Quick", "Remington", "Rosewarne", "Royston", "Stevens", "Swift", "Trevorrow", "the Peacock"


* "infernal dull heavy"

   "Algzourb", "Barg-izkolg", "Bubzudregh", "Bulgvifelg", "Chagojbub", "Dreghulthog", "Dreghzakrolg", "Droogujyeeg", "Frubrafrub", "Glaag-rokrolg", "Glablatzolg", "Gragyaulb", "Grolbazvulb", "Gubujzugt", "Hegalrung", "Hegrodrog", "Hurgarjulb", "Iog-joolb", "Iogivnaug", "Iugyimag", "Julbrukag", "Kleguvdergh", "Kolg-yurung", "Krolgortzolg", "Kwargzaglab", "Maug-jusug", "Naug-yemog", "Nogvaulb", "Nud-jelaug", "Nuguvgub", "Nulbivgaub", "Nulbjodruj", "Nyogvidraug", "Olburbulg", "Raagiyolb", "Raagvavub", "Rungaynaag", "Saugazgaub", "Shubaraag", "Sugojgrolb", "Trobizghad", "Tzolgvomag", "Urbuykolg", "Vulbyuyibb", "Yibb-urlaug", "Yibbejglaag", "Yibbivhaag", "Zug-yaagh", "Zugaviog", "Zugvuagh"


* "infernal sharp spiky"

   "Achoybrax", "Akkvaslarv", "Barlavap", "Brax-ursark", "Dek-zikrych", "Dunazbar", "Dunjaoch", "Duumyuech", "Duumzakrych", "Gaanzabahor", "Gaurlamuth", "Glaur-vusark", "Glaurlulok", "Gochlinam", "Gochovhaerx", "Hraxzunazt", "Inaxuvdak", "Irschjotlizit", "Khorjurolk", "Khoryithak", "Kirluazt", "Kosilmoch", "Lachuznazt", "Lis-zovap", "Lothluoth", "Luthlolach", "Luthujlazt", "Met-libor", "Metizgoth", "Metvikhor", "Moth-vuutuk", "Noc-evmet", "Nur-uyoth", "Ralkulgoth", "Raukozfesh", "Ruaakvosark", "Sarklaazt", "Slarvalach", "Slarvuvirsch", "Sothjuazt", "Sotviigm", "Sutovralk", "Tashlubrax", "Tlizituvazt", "Turzethalk", "Urtvaakk", "Utukurgith", "Uztrulok", "Vach-azdek", "Vachaynyth"


* "infernal soft spongy"

   "Alzivbre", "Baalrobul", "Baelovmau", "Baz-zubial", "Bre-ulalu", "Buyihuz", "Chru-ezssu", "Draualyee", "Druoygel", "Garl-jathalu", "Garu-uyreoz", "Garulibu", "Garuuyghu", "Gelyubaal", "Ghaaevhez", "Glayuhuz", "Glezahra", "Guzeyidrau", "Hezjoziel", "Hriz-orglau", "Hruz-azbial", "Juuruyaa", "Kraayuidrau", "Mauyorezu", "Nee-uzmuz", "Neeruthu", "Neeuvgzi", "Oazo-ivzuu", "Oazourgro", "Raz-lamuz", "Razayhra", "Razyuzu", "Rhuu-jihra", "Riz-ulgla", "Ruazergarl", "Ruazurgla", "Saaellilu", "Sauzonee", "Shai-rotho", "Soaz-ujmoz", "Thaajidrau", "Thaluuzru", "Thuyuchru", "Tzauiltze", "Tzauyuolth", "Utuyuhez", "Vuliyrezu", "Yeejagel", "Zulritha", "Zuyahez"


* "malevolent female"

   "Aaggiu", "Alurdusla", "Arakziu", "Azulla", "Bralizil", "Brazxhiu", "Drulgjiul", "Idrudusla", "Jurgizil", "Jurzija", "Jurzsula", "Kaazrhyl", "Krivgiu", "Kuazsula", "Luribau", "Lurigiu", "Mulkrhyl", "Mulkskiu", "Mulkskiu", "Naurhyl", "Nauulla", "Nidzihyl", "Ninjbau", "Nulanil", "Nymnalu", "Ranaganil", "Rilthudusla", "Rilthusula", "Rukjiul", "Rukziu", "Ulthuulla", "Urzgiu", "Urzsula", "Uznidanil", "Virnziu", "Vlaajbau", "Vlagdiu", "Vlashxhiu", "Vluzakdiu", "Vulkbau", "Xidzihyl", "Xurajdiu", "Xurajdusla", "Xurajziu", "Zugdiu", "Zuglin", "Zuldudiu", "Zulduija", "Zuvdusla", "Zuvziu"


* "malevolent male"

   "Aagsuruk", "Alurlun", "Alurull", "Arakbru", "Araklurug", "Brallurr", "Draaninu", "Drulguvik", "Guzsuruk", "Hauglurug", "Hauguvik", "Jidinu", "Jidzuk", "Jiusuruk", "Jurglun", "Jurgundak", "Jurzzuk", "Kaazull", "Kargzuk", "Kharkundak", "Kraurul", "Kuazdrul", "Kuduzuk", "Nidarag", "Nullurug", "Nymlurug", "Ranaglurug", "Ranagsuruk", "Rilthunal", "Rilthuxulg", "Rulksalk", "Ruzlurr", "Ruzzu", "Ulthuruzuk", "Utizuk", "Uznidlun", "Virnsul", "Vlaglun", "Vlashsalk", "Vluzaksalk", "Vluzakxulg", "Vrazinu", "Vrazsuruk", "Xaulank", "Xidsalk", "Xiduvik", "Xurajarag", "Xurajzu", "Zauvarag", "Zauvxulg"


* "ogre female"

   "Arghklobglugah", "Arghthulkya", "Bogduzya", "Burzguhlay", "Dubdulghy", "Dubshuzay", "Dubulgghy", "Dugkugya", "Dusharghgah", "Dushmugay", "Duzkaigah", "Fugglugghy", "Ghashgluby", "Gholhurgya", "Ghortrugghy", "Ghukkbogay", "Ghulgrulay", "Ghulgrumfay", "Ghulthragy", "Gradsludah", "Grashdrokay", "Groggkaiay", "Grulshugah", "Grumfkurah", "Grumslubay", "Grutduzy", "Gruzdofy", "Gruzmudya", "Gulvgluzobbgah", "Hurgludghy", "Hurgsnogy", "Lukhklobya", "Lukhlumgah", "Lushrukhgah", "Mauggruya", "Mugdrubah", "Mugobbgah", "Nakhlumgah", "Nargbarshghy", "Slubdurshghy", "Slubgludy", "Slugmolgay", "Snoglushy", "Trugobby", "Urdhrungy", "Urghakhay", "Urghkrody", "Urobbah", "Uzguhlay", "Uzgulvgah"


* "ogre male"

   "Arghargh", "Arghdursh", "Barshgluz", "Boglorg", "Bogthurk", "Burzlug", "Burzlukhgrumf", "Drugkrod", "Duglorg", "Dugmakh", "Dulburz", "Dushthrag", "Duzgrut", "Duzlurz", "Ghashmuzd", "Gludyur", "Grobrolb", "Groggkrod", "Grokshud", "Grollurzmolg", "Grukkrod", "Grulgom", "Grumfnakh", "Grumgulv", "Guhlhai", "Haigrul", "Haishuz", "Klobgrum", "Klobmolg", "Lorgdub", "Lukhgrash", "Lummul", "Makhkai", "Mughai", "Mugsnog", "Murkgrum", "Nakhgrum", "Nakhslud", "Nargkug", "Obbmud", "Rukhshud", "Shudgrash", "Shudlush", "Shudmakh", "Shurburz", "Shuzmudshug", "Slugruz", "Thulktrug", "Urkhgrul", "Yugduz"


* "orc female"

   "Augbragy", "Bagumshgah", "Bazkrudgah", "Blagkhagruday", "Dagkragy", "Drabrorgah", "Dugmolkghy", "Ghazsnurry", "Glakhmukah", "Glolzahkghy", "Gnarlhroggnashy", "Gnashlubgah", "Gobragghy", "Gokhbrogghy", "Gorhrugah", "Grakhdakky", "Grakholggah", "Grashslurah", "Grathlashghy", "Grazshaday", "Grotlobghy", "Grotlufghy", "Grubgrathah", "Gutkharbakhya", "Hagglufah", "Hakkbragya", "Khagghazghy", "Kharaugya", "Lubyashlufya", "Lukgrazy", "Mukbadya", "Olgdagay", "Olggrubghy", "Olgshogah", "Raghrogy", "Rashgolay", "Roggsnubya", "Rotsnorlghy", "Rudsodah", "Rutdrabah", "Shaglobya", "Shoggnashghazghy", "Skardaggah", "Snorlghazay", "Sodbruzah", "Sodlufya", "Thakrudghy", "Troghrugay", "Uthkragghy", "Yobgudgrakhya"


* "orc male"

   "Aglash", "Bakhag", "Bazgokh", "Bragzahkmuz", "Brogzahk", "Dobzog", "Drabgrath", "Dugshaz", "Ghazbrag", "Ghazglur", "Glazmuk", "Glolrud", "Gnashdog", "Gokhluk", "Grathbakh", "Grathung", "Grotgrot", "Grotruft", "Grubgol", "Grublub", "Grubskar", "Gutbrag", "Haggokh", "Khaggor", "Khagluk", "Khargraz", "Kragskar", "Krudgrathgob", "Krudgraz", "Lakhsnurr", "Ludug", "Lufgud", "Mukogg", "Muzbash", "Muzglursnorl", "Olghrug", "Rashgut", "Rorggrub", "Rutdag", "Shakbruzrut", "Skulgbag", "Skulgdur", "Skulgslur", "Slurglol", "Snarug", "Snurrzog", "Thakrag", "Trogdarg", "Uthsnub", "Yashgrash"


* "orc surname"

   "Bagdlor", "Barad", "Barlob", "Basgakh", "Boggrak", "Bogugk", "Bogugol", "Buglul", "Bugpok", "Bumptur", "Bural", "Buraum", "Burbrkub", "Burgk", "Burgul", "Burorz", "Dugk", "Duguh", "Dullump", "Dushgub", "Gashur", "Hubor", "Khagth", "Khalob", "Laglob", "Largbek", "Logrgul", "Lumoim", "Luzph", "Magrg", "Malgdum", "Maroar", "Maroar", "Mashma", "Mashma", "Masrag", "Morbak", "Morggurz", "Muzurn", "Nayba", "Ogduborgob", "Orbuduk", "Shadra", "Shulharzol", "Shulz", "Trairbag", "Ugrump", "Ulargk", "Uzgh", "Yarurga"


* "sinister dark elf female"

   "Balnosylna", "Balnyllivil", "Baltorlinvra", "Bursullevia", "Burthalsylil", "Charyaspirra", "Choryolrindra", "Colsinelene", "Colsoldylia", "Dolmyrlavtra", "Dortullenra", "Doryolralith", "Drirhasylhel", "Drisinralrin", "Drisinrilrin", "Dulrelrillin", "Dulyaslavdra", "Durorrildril", "Eilnelrinith", "Eksusidvra", "Enonlenistra", "Envolisia", "Erolgsiniln", "Eronralna", "Gonothsinil", "Gonporlevdril", "Gulmyrpelna", "Gultormlivvril", "Imnilrana", "Insnellevistra", "Inssabsinrin", "Insvilrailn", "Insyaserrin", "Istverelna", "Jegtullenlin", "Jegvrilenna", "Jermyrilra", "Lilothenvril", "Lilvillinra", "Lultorelra", "Mabsunsinna", "Mabtormpelil", "Mabyaslenrin", "Marsinpirrin", "Marsuspelra", "Mersabralia", "Molorgpirrin", "Nothorlavra", "Nothtulidlin", "Olsollavil"


* "sinister dark elf male"

   "Balsinlavul", "Baltelilrim", "Balthalidrid", "Bertullavriv", "Burolgilird", "Buronpeluld", "Buronrilald", "Choronernaz", "Chortormlavlim", "Chorvorenred", "Colorgsylald", "Colsunervid", "Divnylenred", "Divsusrineld", "Divveklivnid", "Dolverisird", "Drirhalenid", "Driteldylird", "Drivekpelviz", "Driyelidriv", "Drommyrsylriv", "Dromvekralim", "Durpelsinild", "Eilsulsylnim", "Eiltelennim", "Eknesylild", "Eknylelviz", "Erporelred", "Gonrhaenrid", "Gulorgerred", "Insnelavred", "Instelisvim", "Insyaslavid", "Istruelrim", "Istyolidvim", "Jegsullivul", "Lilnoenvim", "Lulyellinrim", "Maborlevviz", "Mabtormenild", "Mezvilrilnid", "Mezvirlinrid", "Mezvrillavnid", "Molsekidvim", "Molsundyluld", "Moltenpelnim", "Morrhalenvir", "Morsabrinald", "Olondylriv", "Olothlenid"


* "small spry female 1"

   "Dexerel", "Flissifer", "Flissifer", "Fossafer", "Fossamer", "Fossenti", "Friskerel", "Frissirel", "Frissirel", "Glanirel", "Glaxenti", "Glimarel", "Glimirel", "Glissamer", "Glissinel", "Glissinel", "Glissirel", "Gossenti", "Lissefer", "Minenti", "Minimer", "Miskafer", "Miskamer", "Miskimer", "Ressirel", "Riffafer", "Riffamer", "Riffimer", "Riffinel", "Rillanel", "Rillerel", "Rillimer", "Shimafer", "Shimarel", "Tinkenti", "Tinkinel", "Tissafer", "Trillasti", "Tristimer", "Tristinel", "Tristirel", "Twillanel", "Twillefer", "Twispamer", "Twispefer", "Weftafer", "Weftafer", "Weskasti", "Winnarel", "Wispasti"


* "small spry female 2"

   "Brisliss", "Brisnyx", "Crylkiss", "Crylnyx", "Elsikiss", "Elsiynx", "Emberla", "Emberla", "Eskriss", "Eskynx", "Ferisnyx", "Ferisree", "Friminyx", "Ganree", "Glinknyx", "Glinkynx", "Iphilkiss", "Iphilsa", "Ispelliss", "Ispelnyx", "Istleriss", "Jusniss", "Lirrakiss", "Lirrala", "Lirraliss", "Malitiss", "Minkla", "Mirradee", "Mistlenyx", "Mistleree", "Ninkakiss", "Ninkariss", "Ninkasa", "Opalkiss", "Orifdee", "Orifdee", "Orifree", "Orisree", "Oristiss", "Sarmliss", "Sprinmee", "Stithdee", "Stithmee", "Stithsa", "Tansikiss", "Tansiniss", "Trumpla", "Trumpriss", "Zandokiss", "Zandoynx"


* "small spry male 1"

   "Dexaroll", "Dexeroll", "Dexesto", "Flaxaroll", "Flaxasto", "Flissaldo", "Flissaron", "Flixeron", "Fossallo", "Friskaldo", "Friskaron", "Frissendo", "Gessaldo", "Gessaroll", "Glanamo", "Glimaroll", "Glimaron", "Glimendo", "Glimeron", "Glissendo", "Hexaron", "Lissaldo", "Lissando", "Lisseroll", "Minaron", "Mineroll", "Miskondo", "Rafferoll", "Rafferon", "Ressasto", "Riffando", "Rillaroll", "Rilleroll", "Saffondo", "Saffondo", "Shimaldo", "Tinkesto", "Trillallo", "Trilleroll", "Tristamo", "Tristaron", "Twissendo", "Twissondo", "Twixaron", "Weftando", "Weskondo", "Winnaroll", "Wispasto", "Wisperoll", "Wisperon"


* "small spry male 2"

   "Brismit", "Crylbrix", "Elsitross", "Emberbik", "Emberbik", "Emberfrell", "Emberfret", "Embermit", "Emberzisk", "Feriswin", "Frimibik", "Ganbik", "Ganfrell", "Halzisk", "Helrix", "Histwin", "Josttwik", "Jostzisk", "Juskin", "Lirrarix", "Malikin", "Maliwin", "Malizisk", "Mirrabik", "Mirrazisk", "Mistlefrell", "Mistlemit", "Mistletross", "Mistlezisk", "Opalfret", "Opalkin", "Opaltwik", "Oriftwik", "Oriftwik", "Orifzisk", "Orisfrell", "Oriskin", "Perifrell", "Perikin", "Peritross", "Sarmfrell", "Sprinbrix", "Tansimit", "Tirratross", "Tirrawin", "Whisfrell", "Whistwik", "Zandofrell", "Zandotross", "Zandotross"
