import 'package:fitlife/pages/FitnessExperiencePage.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> {
  int age = 25; // Âge initial
  final int minAge = 18; // Âge minimum
  final int maxAge = 100; // Âge maximum

  Future<void> saveAgeAndProceed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setInt('age', age); // Enregistre temporairement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const FitnessExperiencePage()), // Va à la page suivante
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barre supérieure
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const Text(
                    'Questionnaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      '4 of 6',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Question centrée
              Center(
                child: const Text(
                  'Quel est votre âge ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Slider pour l'âge
              Slider(
                value: age.toDouble(),
                min: minAge.toDouble(),
                max: maxAge.toDouble(),
                divisions: maxAge - minAge,
                label: '$age ans',
                onChanged: (double newValue) {
                  setState(() {
                    age = newValue.toInt();
                  });
                },
              ),

              // Bouton "Continuer"
              ElevatedButton(
                onPressed: saveAgeAndProceed, // Navigue vers la page suivante
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shadowColor: Colors.orange.withOpacity(0.4),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Continuer',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
