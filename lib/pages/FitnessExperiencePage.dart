import 'package:flutter/material.dart';
import 'ExercisePreferencePage.dart'; // Page suivante

class FitnessExperiencePage extends StatefulWidget {
  const FitnessExperiencePage({Key? key}) : super(key: key);

  @override
  State<FitnessExperiencePage> createState() => _FitnessExperiencePageState();
}

class _FitnessExperiencePageState extends State<FitnessExperiencePage> {
  String? selectedExperience; // Variable pour stocker le choix de l'utilisateur

  Future<void> saveExperienceAndProceed() async {
    if (selectedExperience == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Veuillez sélectionner une option.'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const ExercisePreferencePage()), // Passe à la page suivante
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
                    'Assessment',
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
                      '5 of 17',
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
                  'What is your fitness experience?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
              const SizedBox(height: 30),

              // Quatre choix au centre de l'écran
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    // Option Débutant
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExperience = 'Débutant';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: selectedExperience == 'Débutant'
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedExperience == 'Débutant'
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Débutant',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Option Amateur
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExperience = 'Amateur';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: selectedExperience == 'Amateur'
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedExperience == 'Amateur'
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Amateur',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Option Expérimenté
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExperience = 'Expérimenté';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: selectedExperience == 'Expérimenté'
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedExperience == 'Expérimenté'
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Expérimenté',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    // Option Athletic
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          selectedExperience = 'Athletic';
                        });
                      },
                      child: Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: selectedExperience == 'Athletic'
                              ? Colors.orange.withOpacity(0.3)
                              : Colors.grey.shade900,
                          borderRadius: BorderRadius.circular(20),
                          border: Border.all(
                            color: selectedExperience == 'Athletic'
                                ? Colors.orange
                                : Colors.transparent,
                            width: 2,
                          ),
                        ),
                        padding: const EdgeInsets.all(16),
                        child: Center(
                          child: Text(
                            'Athletic',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              // Bouton "Continuer"
              ElevatedButton(
                onPressed: saveExperienceAndProceed,
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
                      'Continue',
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
