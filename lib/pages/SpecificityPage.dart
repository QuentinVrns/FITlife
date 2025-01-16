import 'package:flutter/material.dart';
import 'ChatBotPage.dart';

class SpecificityPage extends StatelessWidget {
  final String goalTitle;
  final String basePrompt;

  const SpecificityPage({Key? key, required this.goalTitle, required this.basePrompt})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> specificities = [
      {'title': 'Séance courte', 'detail': 'moins de 30 minutes'},
      {'title': 'Séance modérée', 'detail': 'environ 1 heure'},
      {'title': 'Séance intense', 'detail': 'plus d’1 heure'},
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
            final colors = [Colors.green, Colors.orange, Colors.red];
            return GestureDetector(
              onTap: () {
                final completePrompt = '$basePrompt avec une séance ${specificity['detail']}';

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => ChatBotPage(
                      title: 'Assistant Sportif',
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
                        color: colors[index % colors.length],
                        shape: BoxShape.circle,
                      ),
                      child: Icon(
                        Icons.timer,
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
                            specificity['title']!,
                            style: const TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            specificity['detail']!,
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
