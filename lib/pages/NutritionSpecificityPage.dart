import 'package:flutter/material.dart';
import 'NutritionChatBotPage.dart';

class NutritionSpecificityPage extends StatelessWidget {
  final String goalTitle;
  final String basePrompt;

  const NutritionSpecificityPage({Key? key, required this.goalTitle, required this.basePrompt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> specificities = [
      {'title': 'Petit déjeuner', 'detail': 'Idées de petit déjeuner'},
      {'title': 'Déjeuner', 'detail': 'Suggestions pour le déjeuner'},
      {'title': 'Dîner', 'detail': 'Suggestions pour le dîner'},
      {'title': 'Collations', 'detail': 'Options pour les collations'},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text('Spécificités pour $goalTitle'),
        centerTitle: true,
      ),
      body: ListView.builder(
        itemCount: specificities.length,
        itemBuilder: (context, index) {
          final specificity = specificities[index];
          return ListTile(
            title: Text(specificity['title']!, style: const TextStyle(fontSize: 18)),
            subtitle: Text(specificity['detail']!, style: const TextStyle(color: Colors.grey)),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {
              final completePrompt = '$basePrompt avec des suggestions pour ${specificity['detail']}';

              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => NutritionChatBotPage(
                    title: 'Assistant Nutritionnel',
                    options: [completePrompt],
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