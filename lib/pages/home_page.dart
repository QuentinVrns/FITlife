import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userData = {
    'username': 'User', // Valeur par défaut
    'calories': 0.0,      // Valeur par défaut en double
    'hydration': 0.0,     // Valeur par défaut en double
  };

  @override
  void initState() {
    super.initState();
    _getUserData();
  }

  // Récupérer les données de l'utilisateur
  Future<void> _getUserData() async {
    final prefs = await SharedPreferences.getInstance();
    final String? userDataJson = prefs.getString('user');

    if (userDataJson != null) {
      setState(() {
        userData = jsonDecode(userDataJson);
      });
    } else {
      setState(() {
        // Si aucune donnée n'est trouvée, on initialise avec des valeurs par défaut
        userData = {
          'username': 'User',
          'calories': 0.0,   // Conversion en double
          'hydration': 0.0,  // Conversion en double
        };
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;  // Empêche l'utilisateur de revenir en arrière
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Header Section
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: Text(
                  "Hello, ${userData['username'] ?? 'User'}!",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Informations Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: const Text(
                  "Informations",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

              // Metrics Cards Row
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: Row(
                  children: [
                    // Calories Burned Card
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(right: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.orange,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.orange.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Calories",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Image.asset(
                                  'assets/images/flamme.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            FAProgressBar(
                              currentValue: userData['calories'].toDouble(),
                              maxValue: 1000,
                              size: 10,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              progressColor: Colors.white,
                              animatedDuration: const Duration(milliseconds: 300),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "${userData['calories']} kCal / 1000 kCal",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    // Hydration Metrics Card
                    Expanded(
                      child: Container(
                        margin: const EdgeInsets.only(left: 6),
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(
                          color: Colors.blue,
                          borderRadius: BorderRadius.circular(12),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.blue.withOpacity(0.4),
                              blurRadius: 8,
                              offset: const Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "Hydration",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                const SizedBox(width: 6),
                                Image.asset(
                                  'assets/images/goutte.png',
                                  width: 20,
                                  height: 20,
                                ),
                              ],
                            ),
                            const SizedBox(height: 12),
                            FAProgressBar(
                              currentValue: userData['hydration'].toDouble(),
                              maxValue: 1000,
                              size: 10,
                              backgroundColor: Colors.white.withOpacity(0.2),
                              progressColor: Colors.white,
                              animatedDuration: const Duration(milliseconds: 300),
                            ),
                            const SizedBox(height: 12),
                            Text(
                              "${userData['hydration']} mL / 1L",
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 16),
              // AI Coach Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: const Text(
                  "AI Coach",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

// Virtual AI Coach Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/training'); // Navigue vers le ChatBot
                  },
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.orange,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.orange.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/robot1.jpg',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "AI Conversations",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 16), // Ajout d'un espacement entre les deux cartes

// AI Nutrition Section Title
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: const Text(
                  "AI Nutrition",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 8),

// AI Nutrition Card
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, '/nutrition'); // Navigue également vers le ChatBot
                  },
                  child: Container(
                    width: double.infinity,
                    height: 160,
                    decoration: BoxDecoration(
                      color: Colors.green,
                      borderRadius: BorderRadius.circular(12),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.green.withOpacity(0.4),
                          blurRadius: 8,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Stack(
                      children: [
                        Positioned.fill(
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(12),
                            child: Image.asset(
                              'assets/images/nutrition.webp',
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.all(12),
                          decoration: BoxDecoration(
                            color: Colors.black.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: const Align(
                            alignment: Alignment.bottomLeft,
                            child: Text(
                              "AI Nutrition Guide",
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              const Spacer(),

              // Navigation Bar
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.fitness_center),
                      color: Colors.white,
                      iconSize: 26,
                      onPressed: () {
                        Navigator.pushNamed(context, '/ai_conversations');
                      },
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.restaurant_menu),
                      color: Colors.white,
                      iconSize: 26,
                      onPressed: () {
                        Navigator.pushNamed(context, '/ai_nutrition');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
