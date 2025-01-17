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

  @override
  void initState() {
    super.initState();
    if (widget.options.isNotEmpty) {
      handleOptionSelected(widget.options.first);
    }
  }

  void handleOptionSelected(String option) async {
    setState(() {
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
        centerTitle: true,
      ),
      body: Stack(
        children: [
          // Image de fond
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/backgroundchatbot.jpg'), // Vérifiez le chemin ici
                fit: BoxFit.cover,
              ),
            ),
          ),
          // Contenu principal
          Column(
            children: [
              Expanded(
                child: ListView.builder(
                  itemCount: messages.length,
                  itemBuilder: (context, index) {
                    final message = messages[index];

                    return Align(
                      alignment: Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.symmetric(
                            vertical: 8.0, horizontal: 12.0),
                        padding: const EdgeInsets.all(12.0),
                        decoration: BoxDecoration(
                          color: Colors.grey.shade800.withOpacity(0.8),
                          borderRadius: BorderRadius.circular(8.0),
                        ),
                        child: Text(
                          message['content'] ?? '',
                          style: TextStyle(
                            color: Colors.grey.shade200,
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
        ],
      ),
    );
  }
}
