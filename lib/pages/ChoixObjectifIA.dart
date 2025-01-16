import 'package:flutter/material.dart';
import 'BodyPartSelectionPage.dart';
import 'SpecificityPage.dart'; // Page pour choisir les spécificités

class GoalSelectionPage extends StatelessWidget {
  const GoalSelectionPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> goals = [
      {'title': 'Perte de poids', 'prompt': 'Donne-moi un entraînement pour perdre du poids'},
      {'title': 'Prise de masse', 'prompt': 'Donne-moi un entraînement pour prendre de la masse'},
      {'title': 'Amélioration de l’endurance', 'prompt': 'Donne-moi un entraînement pour améliorer mon endurance'},
      {'title': 'Entraînement type', 'prompt': 'Donne-moi un entraînement type'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Choisissez un objectif'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: goals.length,
        itemBuilder: (context, index) {
          final goal = goals[index];
          return ListTile(
            title: Text(goal['title']!, style: const TextStyle(fontSize: 18)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              if (goal['title'] == 'Entraînement type') {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => BodyPartSelectionPage(
                      basePrompt: goal['prompt']!,
                    ),
                  ),
                );
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SpecificityPage(
                      goalTitle: goal['title']!,
                      basePrompt: goal['prompt']!,
                    ),
                  ),
                );
              }
            },
          );
        },
      ),
    );
  }
}