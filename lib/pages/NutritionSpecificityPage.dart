import 'package:flutter/material.dart';
import 'NutritionChatBotPage.dart';

class NutritionSpecificityPage extends StatelessWidget {
  final String goalTitle;
  final String basePrompt;

  const NutritionSpecificityPage({Key? key, required this.goalTitle, required this.basePrompt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, dynamic>> specificities = [
      {'title': 'Petit déjeuner', 'detail': 'Idées de petit déjeuner', 'icon': Icons.breakfast_dining, 'color': Colors.orange},
      {'title': 'Déjeuner', 'detail': 'Suggestions pour le déjeuner', 'icon': Icons.lunch_dining, 'color': Colors.green},
      {'title': 'Dîner', 'detail': 'Suggestions pour le dîner', 'icon': Icons.dinner_dining, 'color': Colors.blue},
      {'title': 'Collations', 'detail': 'Options pour les collations', 'icon': Icons.fastfood, 'color': Colors.purple},
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Spécificités pour $goalTitle',
          style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
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
          itemCount: specificities.length,
          itemBuilder: (context, index) {
            final specificity = specificities[index];
            return GestureDetector(
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
                        color: specificity['color'],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        specificity['icon'],
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
                            specificity['title'],
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            specificity['detail'],
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
