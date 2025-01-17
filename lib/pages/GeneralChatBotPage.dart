import 'package:flutter/material.dart';
import '../pages/api_service.dart'; // Assurez-vous que ce fichier contient la fonction `sendMessageToOllama`.

class GeneralChatBotPage extends StatefulWidget {
  const GeneralChatBotPage({Key? key}) : super(key: key);

  @override
  _GeneralChatBotPageState createState() => _GeneralChatBotPageState();
}

class _GeneralChatBotPageState extends State<GeneralChatBotPage> {
  List<Map<String, String>> messages = [];
  bool isLoading = false;
  final TextEditingController _controller = TextEditingController();

  // Fonction pour envoyer un message
  Future<void> _sendMessage(String message) async {
    if (message.trim().isEmpty) return;

    setState(() {
      messages.add({'role': 'user', 'content': message});
      isLoading = true;
    });

    // Appel API pour obtenir la réponse du bot
    final botResponse = await sendMessageToOllama(message);

    setState(() {
      messages.add({'role': 'bot', 'content': botResponse});
      isLoading = false;
    });

    // Efface le champ de texte après envoi
    _controller.clear();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("General ChatBot"),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Liste des messages
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['role'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade800,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['content'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.grey.shade200,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // Affiche un indicateur de chargement si le bot répond
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),

          // Barre d'entrée utilisateur
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              children: [
                // Champ de saisie pour écrire une question
                Expanded(
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      hintText: "Posez une question...",
                      filled: true,
                      fillColor: Colors.grey.shade200,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(8.0),
                        borderSide: BorderSide.none,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 8.0),

                // Bouton d'envoi
                IconButton(
                  icon: const Icon(Icons.send, color: Colors.blue),
                  onPressed: () {
                    _sendMessage(_controller.text);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
