import 'package:flutter/material.dart';
import 'NutritionSpecificityPage.dart';

class NutritionGoalPage extends StatelessWidget {
  const NutritionGoalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> nutritionGoals = [
      {
        'title': 'Prise de masse',
        'prompt': 'Donne-moi des idées de repas pour prendre de la masse',
        'icon': Icons.restaurant,
        'color': Colors.orange,
      },
      {
        'title': 'Healthy et simple',
        'prompt': 'Propose-moi des repas simples et sains',
        'icon': Icons.local_dining,
        'color': Colors.green,
      },
      {
        'title': 'Perte de poids',
        'prompt': 'Fournis-moi des repas adaptés pour perdre du poids',
        'icon': Icons.fitness_center,
        'color': Colors.red,
      },
      {
        'title': 'Végétarien',
        'prompt': 'Fais une suggestion de repas végétariens',
        'icon': Icons.eco,
        'color': Colors.blue,
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Choisissez un objectif nutritionnel',
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
          itemCount: nutritionGoals.length,
          itemBuilder: (context, index) {
            final goal = nutritionGoals[index];
            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => NutritionSpecificityPage(
                      goalTitle: goal['title'],
                      basePrompt: goal['prompt'],
                    ),
                  ),
                );
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
                    // Icône colorée
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
                    // Texte principal
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
                    // Flèche directionnelle
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
