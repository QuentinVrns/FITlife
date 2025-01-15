import 'package:flutter/material.dart';
import '/pages/api_service.dart'; // Ajustez le chemin si nécessaire


class ChatBotPage extends StatefulWidget {
  final String title;
  final List<String> options;

  const ChatBotPage({Key? key, required this.title, required this.options})
      : super(key: key);

  @override
  _ChatBotPageState createState() => _ChatBotPageState();
}

class _ChatBotPageState extends State<ChatBotPage> {
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  void handleOptionSelected(String option) async {
    setState(() {
      messages.add({'role': 'user', 'content': option});
      isLoading = true;
    });

    final response = await sendMessageToOllama(option);

    setState(() {
      messages.add({'role': 'bot', 'content': response});
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: Colors.orange,
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: messages.length,
              itemBuilder: (context, index) {
                final message = messages[index];
                final isUser = message['role'] == 'user';

                return Align(
                  alignment: isUser ? Alignment.centerRight : Alignment.centerLeft,
                  child: Container(
                    margin: const EdgeInsets.symmetric(
                        vertical: 8.0, horizontal: 12.0),
                    padding: const EdgeInsets.all(12.0),
                    decoration: BoxDecoration(
                      color: isUser ? Colors.blue : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                    child: Text(
                      message['content'] ?? '',
                      style: TextStyle(
                        color: isUser ? Colors.white : Colors.black,
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
          Container(
            padding: const EdgeInsets.symmetric(vertical: 8.0),
            child: Wrap(
              spacing: 8.0,
              children: widget.options.map((option) {
                return ElevatedButton(
                  onPressed: () => handleOptionSelected(option),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.orange,
                  ),
                  child: Text(option),
                );
              }).toList(),
            ),
          ),
        ],
      ),
    );
  }
}
