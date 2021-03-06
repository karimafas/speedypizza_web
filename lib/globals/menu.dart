class SpeedyMenu {
  static List fullVariations = [
    ["A", "Extra wurstel", "", "1", false],
    ["-A", "Senza wurstel", "", "1", false],
    ["AA", "Extra melanzane", "", "1", false],
    ["AC", "A calzone", "", "0", false],
    ["AG", "Extra aglio", "", "0", false],
    ["AK", "Art kebab", "", "1.5", false],
    ["AL", "Allegra", "", "1", false],
    ["AN", "Analcolica", "", "0.5", false],
    ["AR", "Araba", "", "2.5", false],
    ["AS", "Extra asparagi", "", "1", false],
    ["B", "Extra acciughe", "", "1", false],
    ["BA", "Extra basilico", "", "0", false],
    ["BB", "Extra peperoni", "", "1", false],
    ["BC", "Ben cotta", "", "0", false],
    ["BF", "Baffo d'Oro", "", "1", false],
    ["BM", "Portare bancomat", "", "0", false],
    ["BR", "Bresaola", "", "3", false],
    ["C", "Extra pomodoro", "", "1", false],
    ["CA", "Caprese", "", "1", false],
    ["CB", "Extra cipolla brasata", "", "1", false],
    ["CE", "Extra pomodoro (dentro)", "", "1", false],
    ["CF", "Al caffè", "", "0", false],
    ["CG", "Extra pomodoro", "", "0", false],
    ["CI", "Al cioccolato", "", "0", false],
    ["CL", "Caramello", "", "0", false],
    ["CM", "Completo", "", "0", false],
    ["CO", "Extra prosciutto cotto", "", "1", false],
    ["CP", "Cotta poco", "", "0", false],
    ["CR", "Extra prosciutto crudo", "", "2", false],
    ["CS", "Con salse", "", "0", false],
    ["D", "Extra carciofini", "", "1", false],
    ["DD", "Extra spinaci", "", "1", false],
    ["DI", "Doppi ingredienti", "", "3", false],
    ["DM", "Doppio malto", "", "1", false],
    ["DS", "Salse abbondanti", "", "0", false],
    ["E", "Extra capperi", "", "1", false],
    ["EE", "Extra mascarpone", "", "1", false],
    ["F", "Extra cipolla", "", "1", false],
    ["FB", "Frutti di bosco", "", "0", false],
    ["FF", "Senza pomodoro", "", "0", false],
    ["FG", "Extra cipolla", "", "0", false],
    ["FI", "Extra cime di rapa", "", "1.5", false],
    ["FO", "Extra fontina", "", "1", false],
    ["FR", "Alla fragola", "", "0", false],
    ["FU", "Extra funghi", "", "1", false],
    ["G", "Doppia pasta", "", "1", false],
    ["GA", "Extra gamberetti", "", "2", false],
    ["GG", "Senza mozzarella", "", "0", false],
    ["GI", "Gigante", "", "7", false],
    ["GR", "Extra grana", "", "2", false],
    ["GS", "Gassata", "", "0", false],
    ["GU", "Extra guanciale", "", "2", false],
    ["H", "Doppia mozzarella", "", "1", false],
    ["HH", "Senza peperoni", "", "0", false],
    ["IC", "In cottura", "", "0", false],
    ["IG", "Extra insalata", "", "0", false],
    ["IH", "Ichnusa", "", "1.5", false],
    ["II", "Senza funghi", "", "0", false],
    ["IN", "Extra insalata", "", "1", false],
    ["IT", "Integrale", "", "1", false],
    ["IV", "In vaschetta", "", "1", false],
    ["J", "Extra fontina", "", "0", false],
    ["JJ", "Senza melanzane", "", "0", false],
    ["KB", "Extra kebab", "", "2", false],
    ["KE", "Extra ketchup", "", "0", false],
    ["KK", "Senza gorgonzola", "", "0", false],
    ["L", "Extra salamino piccante", "", "1", false],
    ["LL", "Senza uovo sodo", "", "0", false],
    ["M", "Extra speck", "", "2", false],
    ["MA", "Extra maionese", "", "0", false],
    ["MC", "Extra mozzarella a crudo", "", "1", false],
    ["MF", "Extra mozzarella fresca", "", "0", false],
    ["MM", "Mezza e mezza", "", "0", false],
    ["MP", "Molto piccante", "", "0", false],
    ["MR", "Moretti", "", "0", false],
    ["MS", "Extra mais", "", "1", false],
    ["MZ", "Mozzarellina", "", "2", false],
    ["N", "Extra gorgonzola", "", "2", false],
    ["NA", "Senza carciofi", "", "0", false],
    ["NC", "Senza crauti", "", "0", false],
    ["ND", "Extra 'nduja", "", "2", false],
    ["NG", "Senza grana", "", "0", false],
    ["NI", "Senza insalata", "", "0", false],
    ["NM", "Senza maionese", "", "0", false],
    ["NN", "Senza prosciutto", "", "0", false],
    ["NP", "Senza piccante", "", "0", false],
    ["NR", "Senza rucola", "", "0", false],
    ["NS", "Senza salse", "", "0", false],
    ["NT", "Naturale", "", "0", false],
    ["NU", "Extra Nutella", "", "2", false],
    ["NY", "Senza yogurt", "", "0", false],
    ["NZ", "Senza zenzero", "", "0", false],
    ["O", "Extra tonno", "", "1", false],
    ["OC", "Extra noci", "", "2", false],
    ["OO", "Senza cipolla", "", "0", false],
    ["OP", "Extra olio piccante", "", "0", false],
    ["OR", "Extra origano", "", "0", false],
    ["P", "Extra pesto", "", "1", false],
    ["P1", "Pasta di grano", "", "0", false],
    ["P2", "Pasta fredda", "", "0", false],
    ["P3", "Risotto", "", "0", false],
    ["PA", "Extra panna", "", "1", false],
    ["PB", "Poco pomodoro", "", "0", false],
    ["PC", "Poca cipolla", "", "0", false],
    ["PD", "Piadina", "", "0", false],
    ["PE", "Extra pecorino", "", "2", false],
    ["PG", "Extra patatine", "", "0", false],
    ["PI", "Al piatto", "", "4.5", false],
    ["PM", "Poca mozzarella", "", "0", false],
    ["PN", "Extra piccante", "", "0", false],
    ["PO", "Extra pomodoro", "", "0", false],
    ["PP", "Poco piccante", "", "0", false],
    ["PR", "Peroni", "", "0", false],
    ["PS", "Extra pomodoro (sopra)", "", "1", false],
    ["PT", "Extra patatine", "", "1", false],
    ["PV", "Extra provola affumicata", "", "2", false],
    ["PZ", "A pizza", "", "1", false],
    ["GS", "Gassata", "", "0", false],
    ["R", "Extra olive", "", "1", false],
    ["RI", "Extra ricotta", "", "1", false],
    ["RO", "Extra rosmarino", "", "0", false],
    ["RR", "Piccola", "", "-1.5", false],
    ["RU", "Extra rucola", "", "1", false],
    ["S", "Extra salsiccia", "", "1", false],
    ["S1", "Carne rossa", "", "0", false],
    ["S2", "Carne bianca", "", "0", false],
    ["S3", "Piatto della casa", "", "0", false],
    ["SA", "Saporita", "", "2.5", false],
    ["SC", "Solo carne", "", "0", false],
    ["SE", "Extra senape", "", "0", false],
    ["SF", "Sfiziosa", "", "2.5", false],
    ["SG", "Senza glutine", "", "2", false],
    ["SK", "Solo ketchup", "", "0", false],
    ["SL", "Extra salmone", "", "2", false],
    ["SM", "Extra scamorza", "", "2", false],
    ["SO", "Solo", "", "0", false],
    ["SP", "Senza salamino piccante", "", "0", false],
    ["SQ", "Extra squacquerone", "", "1", false],
    ["SS", "Più salse", "", "0", false],
    ["ST", "Extra salamino toscano", "", "2", false],
    ["SU", "Super", "", "2", false],
    ["T", "Extra prosciutto cotto", "", "1", false],
    ["TA", "Tagliata", "", "0", false],
    ["TO", "Tonno", "", "2", false],
    ["TT", "Extra zucchine grigliate", "", "2", false],
    ["TY", "Tanto yogurt", "", "0", false],
    ["U", "Senza prosciutto crudo", "", "0", false],
    ["US", "Extra uovo sodo", "", "1", false],
    ["UF", "Extra vuovo fresco", "", "1", false],
    ["UU", "Extra peperoni grigliati", "", "2", false],
    ["V", "Senza mascarpone", "", "0", false],
    ["VA", "In vaschetta", "", "0", false],
    ["VE", "Vegetariana", "", "0", false],
    ["VT", "In vetro", "", "1", false],
    ["VV", "Extra melanzane grigliate", "", "2", false],
    ["WW", "Verdure grigliate", "", "3", false],
    ["X", "Extra pomodori a fette", "", "1", false],
    ["XP", "Extra pomodorini", "", "2", false],
    ["XX", "Extra bufala", "", "2.25", false],
    ["WB", "Caio", "", "1", false],
    ["YO", "Extra yogurt", "", "0", false],
    ["YY", "Con coperchio", "", "0", false],
    ["Z", "Extra stracchino", "", "1", false],
    ["ZE", "Zero", "", "0", false],
    ["ZU", "Extra zucchine fresche", "", "1", false],
    ["ZZ", "Extra funghi porcini", "", "3", false],
  ];

  static List allItems = [
    //Pizze P, Covaccini CO, Calzoni CA, Dolci D, Extra EXTRA
    ["1", "Margherita", "Pomodoro, mozzarella", "5.5", true, "P"],
    ["2", "Prosciutto", "Pomodoro, mozzarella, prosciutto cotto", "6.5", true, "P"],
    [
      "3",
      "Prosciutto e funghi",
      "Pomodoro, mozzarella, prosciutto, funghi",
      "7",
      true, "P"
    ],
    ["4", "Napoli", "Pomodoro, mozzarella, capperi, acciughe", "7", true, "P"],
    [
      "5",
      "Regina margherita",
      "Pomodoro, mozzarella, basilico, doppia pasta",
      "8.5",
      true, "P"
    ],
    ["6", "Funghi", "Pomodoro, mozzarella, funghi", "6.5", true, "P"],
    [
      "7",
      "Quattro stagioni",
      "Pomodoro, mozzarella, prosciutto, funghi, carciofi, olive",
      "8.5",
      true, "P"
    ],
    ["8", "Capricciosa", "Pomodoro, mozzarella, mascarpone", "8.5", true, "P"],
    ["9", "Wurstel", "Pomodoro, mozzarella, wurstel", "6.5", true, "P"],
    [
      "10",
      "Prosciutto e wurstel",
      "Pomodoro, mozzarella, prosciutto cotto, wurstel",
      "7",
      true, "P"
    ],
    ["11", "Covaccino quattro formaggi", "", "7.5", true, "CO"],
    ["12", "Marinara", "", "5", true, "P"],
    ["13", "Tonno e cipolla", "", "7.5", true, "P"],
    ["14", "Contadina", "", "8", true, "P"],
    ["15", "Vegetariana", "", "8.5", true, "P"],
    ["16", "Diavola", "", "6.5", true, "P"],
    ["17", "Fuego", "", "7", true, "P"],
    ["18", "Frutti di mare", "", "8.5", true, "P"],
    ["19", "Montanara", "", "8", true, "P"],
    ["20", "Mascarpone", "", "6.5", true, "P"],
    ["21", "Spinaci e mascarpone", "", "7", true, "P"],
    ["22", "Rucola e mascarpone", "", "7.5", true, "P"],
    ["23", "Calzopizza", "", "7.5", true, "P"],
    ["24", "Pomodoro", "", "5", true, "P"],
    ["25", "Atomica", "", "7", true, "P"],
    ["26", "Salsiccia", "", "6.5", true, "P"],
    ["27", "Rucola e gamberetti", "", "8.5", true, "P"],
    ["28", "Speck e mascarpone", "", "8", true, "P"],
    ["29", "Salsiccia e stracchino", "6 pezzi", "3.5", true, "P"],
    ["30", "Mare e monti", "", "8", true, "P"],
    ["31", "Americana", "", "7", true, "P"],
    ["32", "Covaccino gorgonzola", "", "7", true, "CO"],
    ["33", "Covaccino asparagi", "", "6.5", true, "CO"],
    ["34", "Covaccino ai funghi porcini", "", "8", true, "CO"],
    ["35", "Calzone classico", "", "7", true, "CA"],
    ["36", "Calzone misto", "", "8.5", true, "CA"],
    ["37", "Cazone Casablanca", "", "8.5", true, "CA"],
    ["38", "Calzone braccio di ferro", "", "8", true, "CA"],
    ["39", "Covaccino bianco", "", "4.5", true, "CO"],
    ["40", "Covaccino al cotto", "", "6", true, "CO"],
    ["41", "Covaccino al prosciutto crudo", "", "7", true, "CO"],
    ["42", "Pane arabo", "", "9", true, "CO"],
    ["43", "Porca vacca", "", "7.5", true, "P"],
    ["44", "Porca maiala", "", "8.5", true, "P"],
    ["45", "Covaccino salmone e rucola", "", "9", true, "CO"],
    ["46", "-", "", "0", true, ""],
    ["47", "Schiacciata ripiena", "", "8.5", true, "P"],
    ["48", "Covaccino Speedy", "", "7", true, "CO"],
    ["49", "Covaccino all'olio", "", "3.5", true, "CO"],
    ["50", "Schiacciata alla Nutella", "", "10", false, "D"],
    ["51", "Porca miseria", "", "6.5", true, "P"],
    ["52", "Spinaci", "", "6.5", true, "P"],
    ["53", "Shiro Saigo", "", "8.5", true, "P"],
    ["54", "Dinamite", "", "8", true, "P"],
    ["55", "Covaccino campagnolo", "", "7.5", true, "CO"],
    ["56", "-", "", "0", true, ""],
    ["57", "Covaccino zucchine e gamberetti", "", "9", true, "CO"],
    ["58", "Covaccino mediterraneo", "", "8.5", true, "CO"],
    ["59", "Covaccino primavera", "", "8", true, "CO"],
    ["90", "Pizza kebab", "", "8", true, "P"],
    ["91", "Focaccia kebab", "", "11", true, "CO"],
    ["92", "Calzone Napoli", "", "8", true, "CA"],
    ["95", "Contributo Just Eat", "", "2", true, "EXTRA"],

    //Panini PA
    ["101", "Panino al tonno", "", "5", true, "PA"],
    ["102", "Panino kebab", "", "5.5", true, "K"],
    ["103", "Panino con salsiccia", "", "5", true, "PA"],
    ["104", "Panino al crudo", "", "5", true, "PA"],
    ["105", "Panino capri", "", "5", true, "PA"],
    //["106", "Insalata verde", "", "5", true, "PA"],
    ["107", "Panino cotto e mozzarella", "", "5", true, "PA"],
    ["109", "Hamburger maxi", "", "5", true, "PA"],
    ["110", "Hot dog maxi", "", "5", true, "PA"],
    ["111", "Hot dog piccolo", "", "4", true, "PA"],
    ["112", "Hamburger piccolo", "", "4", true, "PA"],
    ["113", "Panino con cotoletta", "", "5", true, "PA"],

    //Bevande B
    ["130", "Birra", "", "2.5", true, "B"],
    ["131", "Acqua 1.5l", "", "2", true, "B"],
    ["132", "Acqua piccola", "", "1", true, "B"],
    ["133", "Tennent's", "", "3.5", true, "B"],
    ["134", "Becks", "", "3.5", true, "B"],
    ["135", "Birra 66cl", "", "3", true, "B"],
    ["136", "Birra Moretti 33cl", "", "2", true, "B"],
    ["137", "Bock", "", "4.5", true, "B"],
    ["138", "Weiss", "", "4.5", true, "B"],
    ["139", "Sprite lattina", "", "2", true, "B"],
    ["140", "Corona", "", "3.5", true, "B"],
    ["141", "Ceres", "", "3.5", true, "B"],
    ["142", "Coca-Cola 1.5l", "", "4.5", true, "B"],
    ["143", "Coca-Cola lattina", "", "2", true, "B"],
    ["144", "Budweiser", "", "3.5", true, "B"],
    ["145", "Fanta 1.5l", "", "4.5", true, "B"],
    ["146", "Fanta lattina", "", "2", true, "B"],
    ["147", "Sprite 1.5l", "", "4.5", true, "B"],
    ["148", "Tè al limone (lattina)", "", "2", true, "B"],
    ["149", "Tè al limone (lattina)", "", "2", true, "B"],
    ["150", "Birre estere 33cl", "", "3.5", true, "B"],
    ["158", "Heineken 33cl", "", "3", true, "B"],
    ["159", "Moretti Rossa", "", "3", true, "B"],
    ["160", "Bibita da 0.50cl", "", "2.5", true, "B"],
    ["802", "Birra bionda piccola", "", "2.5", true, "B"],
    ["803", "Birra bionda media", "", "3.5", true, "B"],
    ["804", "Birra rossa piccola", "", "3", true, "B"],
    ["805", "Birra rossa media", "", "4", true, "B"],
    ["806", "Boccale birra bionda", "1,5l", "12", true, "B"],
    ["807", "Boccale birra rossa", "1,5l", "14", true, "B"],
    ["808", "Vino della casa 0,25l", "", "2.5", true, "B"],
    ["809", "Vino della casa 0,5l", "", "4", true, "B"],
    ["810", "Vino della casa 1l", "", "8", true, "B"],
    ["811", "Caffè", "", "1", true, "B"],
    ["812", "Alcolici", "", "3", true, "B"],
    ["813", "Superalcolici", "", "3.5", true, "B"],
    ["814", "Coca-Cola piccola", "Alla spina", "2.5", true, "B"],
    ["815", "Coca-Cola media", "Alla spina", "3.5", true, "B"],
    ["817", "Chianti rosso", "", "15", true, "B"],
    ["818", "Vino bianco vermentino", "", "15", true, "B"],

    //Dolci D
    ["161", "Tiramisu", "", "4", true, "D"],
    ["162", "Crepe alla Nutella", "", "4", true, "D"],
    ["163", "Millefoglie scomposto", "", "4", true, "D"],
    ["164", "Panna cotta", "", "4", true, "D"],
    ["165", "Cheesecake", "", "4", true, "D"],
    ["166", "Tartufo bianco", "", "4", true, "D"],
    ["167", "Tartufo nero", "", "4", true, "D"],
    ["168", "Ananas", "", "4", true, "D"],
    ["169", "Gelato al cocco", "", "4", true, "D"],
    ["170", "Sorbetto al limone", "", "4", true, "D"],
    ["171", "Frutta di stagione", "", "4", true, "D"],
    ["172", "Macedonia", "", "4", true, "D"],

    //Primi PR
    ["180", "Tortellini panna e prosciutto", "", "8", true, "PR"],
    ["181", "Risotto pera e gorgonzola", "", "8", true, "PR"],
    ["182", "Gnocchi alla sorrentina", "", "8", true, "PR"],
    ["183", "Tortelli di patate ai formaggi", "", "9", true, "PR"],
    ["184", "Farfalle al salmone", "", "8", true, "PR"],
    ["185", "Penne mare e monti", "", "8", true, "PR"],
    ["186", "Penne al pesto", "", "6", true, "PR"],
    ["187", "Penne al pomodoro e basilico", "", "6", true, "PR"],
    ["188", "Ravioli ricotta e spinaci al ragù", "", "8", true, "PR"],
    ["189", "Risotti vari", "", "9", true, "PR"],
    ["190", "Spaghetti alla carbonara", "", "8", true, "PR"],
    ["191", "Penne all'arrabbiata", "", "6", true, "PR"],
    ["192", "Tagliatelle ai porcini", "", "9", true, "PR"],
    ["193", "Primo del giorno", "", "6", true, "PR"],
    ["194", "Pasta o riso in bianco", "", "4", true, "PR"],
    ["195", "Penne alla polpa di granchio", "", "9", true, "PR"],

    //Fritture F
    ["202", "Cotoletta di pollo", "Con patatine fritte", "6", true, "F"],
    ["203", "Crocchette di pollo", "", "5", true, "F"],
    ["204", "Crocchette di patate", "", "3.5", true, "F"],
    ["205", "Wurstel fritti e patatine", "", "6", true, "F"],
    ["206", "Mozzarelline fritte", "", "3.5", true, "F"],
    ["207", "Olive all'ascolana", "", "3.5", true, "F"],
    ["208", "Patatine fritte", "", "3", true, "F"],
    ["209", "Speedy Pollo", "", "5", true, "F"],
    ["210", "Frittura all'italiana", "", "6", true, "F"],
    ["212", "Ficattole e stracchino", "", "7", true, "F"],

    //Secondi SEC, Insalata INS, Kebab K
    ["201", "Insalata", "", "6", true, "INS"],
    ["213", "Secondi vari", "", "9", true, "SEC"],
    ["214", "Kebab piatto", "", "9", true, "K"],
    ["215", "Frittura di calamari e gamberi", "", "12", true, "F"],
    ["217", "Wurstel alla griglia", "Con patatine", "7", true, "SEC"],
    ["218", "Big burger alla griglia", "Con patatine", "8.5", true, "SEC"],
    ["219", "Bistecca di maiale", "Con insalata", "10", true, "SEC"],
    ["220", "Salsiccia alla griglia", "Con melanzane sott'olio e insalata", "8.5", true, "SEC"],
    ["221", "Tagliata di pollo", "Con verdure grigliate", "10", true, "SEC"],
    ["222", "Bresaola, rucola e grana", "", "10", true, "SEC"],
    ["223", "Tagliere kebab", "", "22", true, "K"],

    //Antipasti A
    ["223", "Crostini misti", "", "7", true, "A"],
    ["224", "Antipasto toscano", "", "8", true, "A"],
    ["225", "Affettati e formaggi all'etto", "", "2", true, "A"],
    ["226", "Contorno del giorno", "", "3", true, "A"],
    ["227", "Gran tagliere", "", "16", true, "A"],
    ["228", "Panino vuoto", "", "1", true, "PA"],
    ["229", "Piadina", "", "2.5", true, "PA"],
    ["230", "Gran fritto", "", "14", true, "F"],

    //Extra EXTRA
    ["300", "Maionese in bustina", "", "0.5", false, "EXTRA"],
    ["301", "Ketchup in bustina", "", "0.5", false, "EXTRA"],
    ["302", "Senape in bustina", "", "0.5", false, "EXTRA"],

    //Sala
    ["801", "Coperto", "", "1.5", true, "EXTRA"],
  ];

  List<String> getVariationAbbreviations() {
    List<String> abbreviations = [];

    for (int i = 0; i < fullVariations.length; i++) {
      abbreviations.add(fullVariations[i][0]);
    }
    return abbreviations;
  }
}
