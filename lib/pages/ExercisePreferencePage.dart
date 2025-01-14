import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'login_page.dart';  // Importer votre page de connexion

class ExercisePreferencePage extends StatefulWidget {
  const ExercisePreferencePage({Key? key}) : super(key: key);

  @override
  State<ExercisePreferencePage> createState() => _ExercisePreferencePageState();
}

class _ExercisePreferencePageState extends State<ExercisePreferencePage> {
  String? selectedExercise; // Variable pour stocker le choix de l'utilisateur

  // Fonction pour enregistrer la préférence de sport dans SharedPreferences
  Future<void> saveExercisePreference(String exercise) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('exercise_preference', exercise); // Enregistre la préférence de sport
  }

  // Fonction pour envoyer les données à l'API
  Future<void> submitData() async {
    final prefs = await SharedPreferences.getInstance();

    // Définir un token fixe
    final String token = 'd8547be5-d190-11ef-8788-525400af6226'; // Token fixe

    // Récupérer les autres informations de SharedPreferences
    final String? username = prefs.getString('username');
    final String? password = prefs.getString('password');
    final String? email = prefs.getString('email');
    final String? favorite_sport = prefs.getString('exercise_preference') ?? 'Non spécifié'; // Valeur par défaut si null
    final String? experience = prefs.getString('fitness_experience');
    final String? gender = prefs.getString('gender');

    // Utilise getDouble pour récupérer des valeurs de type double et les convertir en int
    final double? weight = prefs.getDouble('weight');
    final double? height = prefs.getDouble('height');

    // Convertir les valeurs double en int si nécessaire
    final int weightInt = weight?.toInt() ?? 0; // Utiliser 0 par défaut si weight est null
    final int heightInt = height?.toInt() ?? 0; // Utiliser 0 par défaut si height est null

    // Utilise getInt pour récupérer des valeurs de type int
    final int? age = prefs.getInt('age');

    // Appeler la fonction pour envoyer les données à l'API
    sendDataToAPI(token, username, password, email, favorite_sport, experience, gender, weightInt, heightInt, age);
  }

  // Fonction pour envoyer les données à l'API
  Future<void> sendDataToAPI(String token, String? username, String? password, String? email, String? exercisePreference, String? experience, String? gender, int? weight, int? height, int? age) async {
    final Uri apiUrl = Uri.parse('https://reymond.alwaysdata.net/FITLife/register.php'); // Remplace l'URL par celle de ton API

    // Données à envoyer
    final Map<String, dynamic> data = {
      'token': token,  // Utilise le token fixe
      'username': username,
      'password': password,
      'email': email,
      'favorite_sport': exercisePreference,
      'experience': experience,
      'gender': gender,
      'weight': weight?.toString(), // Convertir le int en String
      'height': height?.toString(), // Convertir le int en String
      'age': age?.toString(), // Convertir l'int en String
    };

    print('Données envoyées à l\'API:');
    print(data);

    try {
      final response = await http.post(
        apiUrl,
        headers: {'Content-Type': 'application/json'},
        body: json.encode(data),
      );

      if (response.statusCode == 200) {
        // Si la requête est réussie
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Inscription terminée avec succès.'),
            backgroundColor: Colors.green,
          ),
        );
        print('Réponse de l\'API: ${response.body}');
        // Rediriger vers la page de connexion après l'inscription réussie
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()), // Naviguer vers la page de connexion
        );
      } else {
        // Si la requête échoue
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Erreur lors de l\'inscription.'),
            backgroundColor: Colors.red,
          ),
        );
        print('Erreur lors de l\'inscription: ${response.body}');
      }
    } catch (e) {
      // Gestion des erreurs
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Une erreur s\'est produite. Veuillez réessayer.'),
          backgroundColor: Colors.red,
        ),
      );
      print('Erreur lors de l\'appel à l\'API: $e');
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
                    'Évaluation',
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

              // Titre
              Center(
                child: Text(
                  'Avez-vous une préférence d\'exercice spécifique ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Options d'exercice
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
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
                          saveExercisePreference(exercise);  // Sauvegarder le sport préféré
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
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Icon(
                                exerciseIcons[exercise] ?? Icons.help,
                                color: Colors.white,
                                size: 32,
                              ),
                              const SizedBox(height: 8),
                              Text(
                                exercise,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),

              // Bouton "Finir l'inscription"
              ElevatedButton(
                onPressed: submitData, // Envoie les données vers l'API
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
                      'Finir l\'inscription',
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

// Liste des options d'exercice et leurs icônes associées
final exerciseOptions = [
  'course à pied', 'marche', 'randonnée', 'natation', 'vélo', 'musculation', 'cardio', 'yoga', 'autre'
];

final exerciseIcons = {
  'Jogging': Icons.directions_run,
  'Walking': Icons.directions_walk,
  'Hiking': Icons.nature_people,
  'Natation': Icons.pool, // Icône de natation
  'Biking': Icons.directions_bike,
  'Fitness': Icons.fitness_center,
  'Cardio': Icons.favorite,
  'Yoga': Icons.self_improvement,
  'Autre': Icons.more_horiz,
};
