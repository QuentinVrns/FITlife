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
          );
        },
      ),
    );
  }
}