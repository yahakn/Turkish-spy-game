import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

void main() {
  runApp(SpyGameApp());
}

class SpyGameApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Spy Game',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSwatch().copyWith(
          primary: Colors.blueGrey.shade900,
          secondary: Colors.amber,
        ),
        scaffoldBackgroundColor: Colors.grey.shade900,
        textTheme: TextTheme(
          titleLarge: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
          bodyMedium: TextStyle(
            fontSize: 16,
            color: Colors.grey[300],
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int playerCount = 4;
  int spyCount = 1;
  int gameDuration = 60;
  String selectedTheme = "Lezzetler";

  final Map<String, List<String>> kelimeHavuzu = {
    "Lezzetler": [
      "pizza",
      "hamburger",
      "makarna",
      "sushi",
      "dondurma",
      "kebap",
      "baklava",
      "çikolata",
      "kahve",
      "limonata",
    ],
    "Spor Dünyası": [
      "futbol",
      "basketbol",
      "tenis",
      "yüzme",
      "koşu",
      "bisiklet",
      "voleybol",
      "boks",
      "yoga",
      "kayak",
    ],
    "Ülkeler": [
      "Türkiye",
      "Fransa",
      "Almanya",
      "Japonya",
      "Brezilya",
      "İtalya",
      "İspanya",
      "Kanada",
      "Amerika",
      "Avustralya",
    ],
    "Hayvanlar": [
      "aslan",
      "kaplan",
      "fil",
      "köpek",
      "kedi",
      "tavşan",
      "zebra",
      "kanguru",
      "yunus",
      "koyun",
    ],
    "Süper Kahramanlar": [
      "Batman",
      "Spider-Man",
      "Hulk",
      "Superman",
      "Flash",
      "Wonder Woman",
      "Thor",
      "Iron Man",
      "Black Panther",
      "Deadpool",
    ],
    "Çizgi Film Karakterleri": [
      "Bugs Bunny",
      "Tom",
      "Jerry",
      "Scooby-Doo",
      "SpongeBob",
      "Shaggy",
      "Mickey Mouse",
      "Donald Duck",
      "Fred Flintstone",
      "Yogi Bear",
    ],
    "Tatlılar": [
      "pasta",
      "kek",
      "çikolata",
      "kurabiye",
      "lokum",
      "sütlaç",
      "baklava",
      "dondurma",
      "waffle",
      "profiterol",
    ],
    "İçecekler": [
      "kahve",
      "çay",
      "limonata",
      "gazoz",
      "ayran",
      "meyve suyu",
      "soda",
      "kola",
      "şarap",
      "bira",
    ],
    "Gezegenler": [
      "Merkür",
      "Venüs",
      "Dünya",
      "Mars",
      "Jüpiter",
      "Satürn",
      "Uranüs",
      "Neptün",
      "Plüton",
      "Asteroit Kuşağı",
    ],
  };

  // "Nasıl Oynanır?" dialogunu gösteren fonksiyon
  void _showHowToPlayDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Nasıl Oynanır?"),
        content: SingleChildScrollView(
          child: Text(
            "1. Oyuncu sayısını, casus sayısını ve oyun süresini belirleyin.\n"
            "2. Bir tema seçin (örneğin, meyveler, hayvanlar, ülkeler).\n"
            "3. 'Oyuna Başla' butonuna tıklayın.\n"
            "4. Her oyuncu sırayla kartını görecek. Kartta yazan kelimeyi hatırlayın.\n"
            "5. Casuslar, diğer oyuncuların kelimesini bilmez.\n"
            "6. Oyun süresi içinde casus(lar)ı bulmaya çalışın.\n"
            "7. Süre dolduğunda casus(lar)ı tahmin edin.\n"
            "8. Kazananı belirleyin!",
            style: TextStyle(fontSize: 16),
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text("Tamam"),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: null,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            // Logo Ekleniyor
            Image.asset(
              'assets/logo.png', // Logo dosyasının yolu
              height: 150, // Logo yüksekliği
              width: 150, // Logo genişliği
            ),
            SizedBox(height: 20),
            // "Nasıl Oynanır?" Butonu
            ElevatedButton(
              onPressed: () {
                _showHowToPlayDialog(context);
              },
              child: Text("Nasıl Oynanır?"),
            ),
            SizedBox(height: 20),
            DropdownButton<String>(
              value: selectedTheme,
              items: kelimeHavuzu.keys.map((String tema) {
                return DropdownMenuItem<String>(
                  value: tema,
                  child: Text(tema),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  selectedTheme = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            Text("Oyuncu Sayısı: $playerCount"),
            Slider(
              value: playerCount.toDouble(),
              min: 2,
              max: 16,
              divisions: 14,
              label: playerCount.toString(),
              onChanged: (double value) {
                setState(() {
                  playerCount = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            Text("Casus Sayısı: $spyCount"),
            Slider(
              value: spyCount.toDouble(),
              min: 1,
              max: playerCount - 1,
              divisions: playerCount - 2,
              label: spyCount.toString(),
              onChanged: (double value) {
                setState(() {
                  spyCount = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            Text("Oyun Süresi: $gameDuration saniye"),
            Slider(
              value: gameDuration.toDouble(),
              min: 30,
              max: 300,
              divisions: 27,
              label: gameDuration.toString(),
              onChanged: (double value) {
                setState(() {
                  gameDuration = value.toInt();
                });
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => GameScreen(
                      playerCount: playerCount,
                      spyCount: spyCount,
                      gameDuration: gameDuration,
                      selectedTheme: selectedTheme,
                      kelimeHavuzu: kelimeHavuzu,
                    ),
                  ),
                );
              },
              child: Text("Oyuna Başla"),
            ),
          ],
        ),
      ),
    );
  }
}

class GameScreen extends StatefulWidget {
  final int playerCount;
  final int spyCount;
  final int gameDuration;
  final String selectedTheme;
  final Map<String, List<String>> kelimeHavuzu;

  GameScreen({
    required this.playerCount,
    required this.spyCount,
    required this.gameDuration,
    required this.selectedTheme,
    required this.kelimeHavuzu,
  });

  @override
  _GameScreenState createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  List<String> players = [];
  List<String> words = [];
  List<String> spies = [];
  int currentPlayerIndex = 0;
  int remainingTime = 0;
  Timer? timer;
  bool isCardVisible = false;
  bool isGameStarted = false;
  bool isRedTheme = false;
  bool isBlinking = false;

  @override
  void initState() {
    super.initState();
    initializeGame();
  }

  void initializeGame() {
    // Oyuncuları oluştur
    players =
        List.generate(widget.playerCount, (index) => "Oyuncu ${index + 1}");

    // Kelimeleri seç
    final List<String> temaKelimeleri =
        widget.kelimeHavuzu[widget.selectedTheme]!;
    final Random random = Random();

    // Normal kelimeyi seç
    final String normalKelime =
        temaKelimeleri[random.nextInt(temaKelimeleri.length)];

    // Casus kelimesini seç (normal kelimeden farklı olmalı)
    String casusKelimesi =
        temaKelimeleri[random.nextInt(temaKelimeleri.length)];
    while (casusKelimesi == normalKelime) {
      casusKelimesi = temaKelimeleri[random.nextInt(temaKelimeleri.length)];
    }

    // Tüm oyunculara normal kelimeyi ver
    words = List.filled(widget.playerCount, normalKelime);

    // Casusları belirle ve onlara farklı kelimeyi ver
    spies = [];
    for (int i = 0; i < widget.spyCount; i++) {
      int spyIndex = random.nextInt(widget.playerCount);
      while (spies.contains(players[spyIndex])) {
        spyIndex = random.nextInt(widget.playerCount);
      }
      spies.add(players[spyIndex]);
      words[spyIndex] = casusKelimesi;
    }

    // Oyun süresini ayarla
    remainingTime = widget.gameDuration;
  }

  void startGame() {
    setState(() {
      isGameStarted = true;
    });

    timer = Timer.periodic(Duration(seconds: 1), (timer) {
      setState(() {
        if (remainingTime > 0) {
          remainingTime--;
          if (remainingTime <= widget.gameDuration * 0.1) {
            isRedTheme = true;
            isBlinking = !isBlinking;
          } else {
            isRedTheme = false;
          }
        } else {
          timer.cancel();
          showDialog(
            context: context,
            builder: (context) => AlertDialog(
              title: Text("Oyun Bitti!"),
              content: Text("Süre doldu. Casus(lar): ${spies.join(", ")}"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  },
                  child: Text("Tamam"),
                ),
              ],
            ),
          );
        }
      });
    });
  }

  void showNextPlayerWord() {
    setState(() {
      if (currentPlayerIndex < players.length - 1) {
        currentPlayerIndex++;
        isCardVisible = false;
      } else {
        startGame();
      }
    });
  }

  @override
  void dispose() {
    timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Kelime Öğrenme"),
      ),
      backgroundColor: isRedTheme && isBlinking
          ? Colors.red.shade900
          : isRedTheme
              ? Colors.red.shade800
              : Colors.grey.shade900,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (!isGameStarted)
              GestureDetector(
                onTap: () {
                  setState(() {
                    isCardVisible = true;
                  });
                },
                onHorizontalDragEnd: (details) {
                  if (details.primaryVelocity! < 0) {
                    // Sola kaydırma
                    showNextPlayerWord();
                  }
                },
                child: AnimatedSwitcher(
                  duration: Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) {
                    return SlideTransition(
                      position: Tween<Offset>(
                        begin: Offset(1.0, 0.0),
                        end: Offset.zero,
                      ).animate(animation),
                      child: child,
                    );
                  },
                  child: Card(
                    key: ValueKey<int>(currentPlayerIndex),
                    color: Colors.blueGrey.shade800,
                    elevation: 5,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Container(
                      width: 275, // Kart genişliği
                      height: 412.5, // Kart yüksekliği
                      alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            players[currentPlayerIndex],
                            style: TextStyle(
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          SizedBox(height: 20),
                          isCardVisible
                              ? Text(
                                  words[currentPlayerIndex],
                                  style: TextStyle(
                                    fontSize: 24,
                                    color: Colors.white,
                                  ),
                                )
                              : Icon(
                                  Icons.help_outline,
                                  size: 50,
                                  color: Colors.white,
                                ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            if (isGameStarted)
              Column(
                children: [
                  Text(
                    "Kalan Süre: $remainingTime saniye",
                    style: TextStyle(fontSize: 24, color: Colors.white),
                  ),
                  SizedBox(height: 20),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                    },
                    child: Text("Oyunu Bitir"),
                  ),
                ],
              ),
          ],
        ),
      ),
    );
  }
}
