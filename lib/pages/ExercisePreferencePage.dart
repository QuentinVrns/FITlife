import 'package:flutter/material.dart';
import 'WeightPage.dart'; // Page suivante

class ExercisePreferencePage extends StatefulWidget {
  const ExercisePreferencePage({Key? key}) : super(key: key);

  @override
  State<ExercisePreferencePage> createState() => _ExercisePreferencePageState();
}

class _ExercisePreferencePageState extends State<ExercisePreferencePage> {
  String? selectedExercise; // Variable pour stocker le choix de l'utilisateur

  Future<void> savePreferenceAndProceed() async {
    if (selectedExercise == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une préférence d\'exercice.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const WeightPage()), // Passe à la page suivante
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

              // Bouton "Continuer"
              ElevatedButton(
                onPressed: savePreferenceAndProceed,
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

// Liste des options d'exercice et leurs icônes associées
final exerciseOptions = [
  'Jogging', 'Walking', 'Hiking', 'Natation', 'Biking', 'Fitness', 'Cardio', 'Yoga', 'Autre'
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
