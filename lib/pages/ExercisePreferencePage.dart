import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';

class ExercisePreferencePage extends StatefulWidget {
  const ExercisePreferencePage({Key? key}) : super(key: key);

  @override
  State<ExercisePreferencePage> createState() => _ExercisePreferencePageState();
}

class _ExercisePreferencePageState extends State<ExercisePreferencePage> {
  String? selectedExercise;

  Future<void> saveExercisePreference(String exercise) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('exercise_preference', exercise);
  }

  Future<void> submitData() async {
    final prefs = await SharedPreferences.getInstance();
    final String token = 'd8547be5-d190-11ef-8788-525400af6226';

    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    final String? email = prefs.getString('email');
    final String? favorite_sport =
        prefs.getString('exercise_preference') ?? 'Non spécifié';
    final String? experience = prefs.getString('fitness_experience');
    final String? gender = prefs.getString('gender');
    final double? weight = prefs.getDouble('weight');
    final double? height = prefs.getDouble('height');
    final int weightInt = weight?.toInt() ?? 0;
    final int heightInt = height?.toInt() ?? 0;
    final int? age = prefs.getInt('age');

    sendDataToAPI(token, username, password, email, favorite_sport, experience,
        gender, weightInt, heightInt, age);
  }

  Future<void> sendDataToAPI(
      String token,
      String? username,
      String? password,
      String? email,
      String? exercisePreference,
      String? experience,
      String? gender,
      int? weight,
      int? height,
      int? age,
      ) async {
    final Uri apiUrl =
    Uri.parse('https://reymond.alwaysdata.net/FITLife/register.php');

    final Map<String, dynamic> data = {
      'token': token,
      'username': username,
      'password': password,
      'email': email,
      'favorite_sport': exercisePreference,
      'experience': experience,
      'gender': gender,
      'weight': weight?.toString(),
      'height': height?.toString(),
      'age': age?.toString(),
    };

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription terminée avec succès.'),
            backgroundColor: Colors.green,
          ),
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'inscription.'),
            backgroundColor: Colors.red,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur s\'est produite. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
    }
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
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      '6 de 6',
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
              Center(
                child: Text(
                  'Avez-vous une préférence d\'exercice spécifique ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemCount: exerciseOptions.length,
                  itemBuilder: (context, index) {
                    final exercise = exerciseOptions[index];
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExercise = exercise;
                          saveExercisePreference(exercise);
                        });
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: selectedExercise == exercise
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedExercise == exercise
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              exerciseIcons[exercise] ?? Icons.help,
                              color: Colors.white,
                              size: 40,
                            ),
                            const SizedBox(height: 10),
                            Text(
                              exercise,
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: submitData,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                ),
                child: const Text(
                  'Finir l\'inscription',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
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

final exerciseOptions = [
  'course à pied',
  'marche',
  'randonnée',
  'natation',
  'vélo',
  'musculation',
  'cardio',
  'yoga',
  'autre'
];

final exerciseIcons = {
  'course à pied': Icons.directions_run,
  'marche': Icons.directions_walk,
  'randonnée': Icons.terrain,
  'natation': Icons.pool,
  'vélo': Icons.directions_bike,
  'musculation': Icons.fitness_center,
  'cardio': Icons.favorite,
  'yoga': Icons.self_improvement,
  'autre': Icons.more_horiz,
};
