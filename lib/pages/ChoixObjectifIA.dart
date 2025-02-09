import 'package:flutter/material.dart';
import 'BodyPartSelectionPage.dart';
import 'SpecificityPage.dart';

class GoalSelectionPage extends StatelessWidget {
  const GoalSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> goals = [
      {
        'title': 'Perte de poids',
        'prompt': 'Donne-moi un entraînement pour perdre du poids',
        'icon': Icons.fitness_center,
        'color': Colors.orange
      },
      {
        'title': 'Prise de masse',
        'prompt': 'Donne-moi un entraînement pour prendre de la masse',
        'icon': Icons.line_weight,
        'color': Colors.green
      },
      {
        'title': 'Amélioration de l’endurance',
        'prompt': 'Donne-moi un entraînement pour améliorer mon endurance',
        'icon': Icons.directions_run,
        'color': Colors.blue
      },
      {
        'title': 'Entraînement type',
        'prompt': 'Donne-moi un entraînement type',
        'icon': Icons.fitness_center,
        'color': Colors.red
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choisissez un objectif',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.orange,
        elevation: 0,
        centerTitle: true,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: Container(
        color: Colors.black,
        padding: const EdgeInsets.all(16),
        child: ListView.builder(
          itemCount: goals.length,
          itemBuilder: (context, index) {
            final goal = goals[index];
            return GestureDetector(
              onTap: () {
                if (goal['title'] == 'Entraînement type') {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BodyPartSelectionPage(
                        basePrompt: goal['prompt'],
                      ),
                    ),
                  );
                } else {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => SpecificityPage(
                        goalTitle: goal['title'],
                        basePrompt: goal['prompt'],
                      ),
                    ),
                  );
                }
              },
              child: Container(
                margin: const EdgeInsets.only(bottom: 16),
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.grey[900],
                  borderRadius: BorderRadius.circular(12),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.5),
                      blurRadius: 8,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Row(
                  children: [
                    // Icône
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: goal['color'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        goal['icon'],
                        color: Colors.white,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 16),
                    // Titre et description
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            goal['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            goal['prompt'],
                            style: TextStyle(
                              fontSize: 14,
                              color: Colors.white.withOpacity(0.8),
                            ),
                          ),
                        ],
                      ),
                    ),
                    // Flèche
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white54,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
