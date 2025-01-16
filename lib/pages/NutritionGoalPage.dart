import 'package:flutter/material.dart';
import 'NutritionSpecificityPage.dart';

class NutritionGoalPage extends StatelessWidget {
  const NutritionGoalPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> nutritionGoals = [
      {'title': 'Prise de masse', 'prompt': 'Donne-moi des idées de repas pour prendre de la masse'},
      {'title': 'Healthy et simple', 'prompt': 'Propose-moi des repas simples et sains'},
      {'title': 'Perte de poids', 'prompt': 'Fournis-moi des repas adaptés pour perdre du poids'},
      {'title': 'Végétarien', 'prompt': 'Fais une suggestion de repas végétariens'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisissez un objectif nutritionnel'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: nutritionGoals.length,
        itemBuilder: (context, index) {
          final goal = nutritionGoals[index];
          return ListTile(
            title: Text(goal['title']!, style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NutritionSpecificityPage(
                    goalTitle: goal['title']!,
                    basePrompt: goal['prompt']!,
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}