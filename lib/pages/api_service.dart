import 'dart:convert';
import 'package:http/http.dart' as http;

Future<String> sendMessageToOllama(String message) async {
  final String baseUrl = "http://127.0.0.1:11434/api/chat";

  try {
    // Envoyer la requête
    final response = await http.post(
      Uri.parse(baseUrl),
      headers: {
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "model": "llama3:latest",
        "messages": [
          {
            "role": "user",
            "content": '$message Réponds de manière concise et uniquement en français.',
          }
        ],
        "stream": false // Désactiver le streaming
      }),
    );

    // Vérifier si la requête a réussi
    if (response.statusCode == 200) {
      // Décoder la réponse JSON
      final data = jsonDecode(response.body);

      // Extraire et retourner uniquement le contenu
      if (data["message"] != null && data["message"]["content"] != null) {
        return data["message"]["content"];
      } else {
        return "Réponse mal formatée : pas de contenu.";
      }
    } else {
      return "Erreur : ${response.statusCode} - ${response.reasonPhrase}";
    }
  } catch (e) {
    return "Erreur : $e";
  }
}