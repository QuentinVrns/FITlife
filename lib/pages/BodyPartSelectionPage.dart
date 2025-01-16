import 'package:flutter/material.dart';
import 'ChatBotPage.dart';

class BodyPartSelectionPage extends StatefulWidget {
  final String basePrompt;

  const BodyPartSelectionPage({Key? key, required this.basePrompt})
      : super(key: key);

  @override
  _BodyPartSelectionPageState createState() => _BodyPartSelectionPageState();
}

class _BodyPartSelectionPageState extends State<BodyPartSelectionPage> {
  final List<String> bodyParts = ['Bras', 'Jambes', 'Abdominaux', 'Dos', 'Épaules'];
  final List<String> selectedParts = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ciblez vos muscles'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: bodyParts.length,
              itemBuilder: (context, index) {
                final part = bodyParts[index];
                final isSelected = selectedParts.contains(part);

                return CheckboxListTile(
                  title: Text(part, style: const TextStyle(fontSize: 18)),
                  value: isSelected,
                  onChanged: (value) {
                    setState(() {
                      if (value == true) {
                        selectedParts.add(part);
                      } else {
                        selectedParts.remove(part);
                      }
                    });
                  },
                  activeColor: Colors.orange,
                  checkColor: Colors.black,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: ElevatedButton(
              onPressed: () {
                if (selectedParts.isNotEmpty) {
                  final completePrompt =
                      'Fait moi une réponse courte et seulement en Français : Donne-moi un entraînement pour travailler les ${selectedParts.join(", ")}.';

                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatBotPage(
                        title: 'Assistant Sportif',
                        options: [completePrompt],
                      ),
                    ),
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez sélectionner au moins une partie.')),
                  );
                }
              },
              child: const Text('Valider'),
            ),
          ),
        ],
      ),
    );
  }
}