import 'package:flutter/material.dart';
import '../pages/api_service.dart';

class NutritionChatBotPage extends StatefulWidget {
  final String title;
  final List<String> options;

  const NutritionChatBotPage({Key? key, required this.title, required this.options})
      : super(key: key);

  @override
  _NutritionChatBotPageState createState() => _NutritionChatBotPageState();
}

class _NutritionChatBotPageState extends State<NutritionChatBotPage> {
  List<Map<String, String>> messages = [];
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    if (widget.options.isNotEmpty) {
      _sendInitialMessage(widget.options.first);
    }
  }

  void _sendInitialMessage(String message) async {
    setState(() {
      messages.add({'role': 'user', 'content': message});
      isLoading = true;
    });

    final botResponse = await sendMessageToOllama(message);

    setState(() {
      messages.add({'role': 'bot', 'content': botResponse});
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        centerTitle: true,
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
          if (isLoading)
            const Padding(
              padding: EdgeInsets.all(8.0),
              child: CircularProgressIndicator(),
            ),
        ],
      ),
    );
  }
}