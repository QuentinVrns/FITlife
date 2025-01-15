import 'package:http/http.dart' as http;
import 'dart:convert';

Future<String> sendMessageToOllama(String message) async {
  final url = Uri.parse('http://127.0.0.1:11434/api/chat'); // URL du serveur Ollama

  try {
    final response = await http.post(
      url,
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'model': 'llama2', // Spécifiez ici le modèle que vous utilisez
        'input': message,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return data['response'] ?? 'Aucune réponse.';
    } else {
      print('Erreur: ${response.body}');
      return 'Erreur: ${response.statusCode}, ${response.body}';
    }
  } catch (e) {
    print('Exception : $e');
    return 'Erreur de connexion : $e';
  }
}
