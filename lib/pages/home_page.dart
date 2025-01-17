import 'package:flutter/material.dart';
import 'package:flutter_animation_progress_bar/flutter_animation_progress_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Map<String, dynamic> userData = {
    'username': 'User', // Valeur par défaut
    'calories': 0.0,   // Valeur par défaut
    'hydration': 0.0,  // Valeur par défaut
  };

  @override
  void initState() {
    super.initState();
    _initializeUserId(); // Initialise l'ID utilisateur
    _fetchUserInfo();    // Récupère les infos utilisateur
  }

  // Initialise l'ID utilisateur dans SharedPreferences
  Future<void> _initializeUserId() async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId');

    if (userId == null) {
      // Si aucun ID utilisateur, définir sur 0
      await prefs.setInt('userId', 0);
      print('ID utilisateur initialisé à 0.');
    } else {
      print('ID utilisateur existant : $userId');
    }
  }

  // Récupérer les informations de l'utilisateur depuis l'API
  Future<void> _fetchUserInfo() async {
    final prefs = await SharedPreferences.getInstance();

    // Récupérer l'ID utilisateur stocké ou définir une valeur par défaut
    final userId = prefs.getInt('userId') ?? 0;

    if (userId == 0) {
      setState(() {
        userData['username'] = 'User';
        userData['calories'] = 0.0;
        userData['hydration'] = 0.0;
      });
      print("Aucun utilisateur trouvé. ID utilisateur : 0");
      return;
    }

    final url = Uri.parse('https://reymond.alwaysdata.net/FITLife/get_info.php');
    const token = 'd8547be5-d190-11ef-8788-525400af6226';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'user_id': userId, // Envoyer l'ID utilisateur
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['success'] == true) {
          setState(() {
            userData['username'] = data['data']['username'] ?? 'User';
            userData['calories'] = (data['data']['calories'] ?? 0).toDouble();
            userData['hydration'] = (data['data']['water_ml'] ?? 0).toDouble();
          });
          print('Données utilisateur récupérées : ${data['data']}');
        } else {
          print('Erreur API : ${data['message']}');
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${data['message']}')),
          );
        }
      } else {
        print('Erreur de serveur : ${response.body}');
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur : ${response.body}')),
        );
      }
    } catch (e) {
      print('Exception : $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion : $e')),
      );
    }
  }

  // Méthode de déconnexion
  Future<void> _logout() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.clear(); // Supprime toutes les données stockées
    Navigator.pushReplacementNamed(context, '/login'); // Redirige vers la page de connexion
  }

  Future<void> _updateCalories(int newCalories) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    if (userId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur : Utilisateur non identifié')),
      );
      return;
    }

    final url = Uri.parse('https://reymond.alwaysdata.net/FITLife/add_calories.php');
    const token = 'd8547be5-d190-11ef-8788-525400af6226';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'user_id': userId,
          'calories': newCalories, // Nouvelle valeur saisie
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          setState(() {
            userData['calories'] = newCalories.toDouble(); // Met à jour la valeur locale
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Calories mises à jour avec succès !')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de serveur : ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion : $e')),
      );
    }
  }


  // Méthode pour ajouter de l'eau
  Future<void> _updateWater(int newAmount) async {
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getInt('userId') ?? 0;

    if (userId == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Erreur : Utilisateur non identifié')),
      );
      return;
    }

    final url = Uri.parse('https://reymond.alwaysdata.net/FITLife/add_water.php');
    const token = 'd8547be5-d190-11ef-8788-525400af6226';

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'token': token,
          'user_id': userId,
          'water_ml': newAmount, // Nouvelle valeur saisie
        }),
      );

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);

        if (data['status'] == 'success') {
          setState(() {
            userData['hydration'] = newAmount.toDouble(); // Met à jour la valeur locale
          });
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Hydratation mise à jour avec succès !')),
          );
        } else {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Erreur : ${data['message']}')),
          );
        }
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Erreur de serveur : ${response.body}')),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur de connexion : $e')),
      );
    }
  }

  void _showUpdateCaloriesDialog() {
    final TextEditingController _caloriesController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier les calories'),
          content: TextField(
            controller: _caloriesController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Entrez la nouvelle valeur en kCal',
              suffixText: 'kCal',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final int newCalories = int.tryParse(_caloriesController.text) ?? 0;
                if (newCalories > 0) {
                  _updateCalories(newCalories);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez entrer une quantité valide')),
                  );
                }
              },
              child: const Text('Mettre à jour'),
            ),
          ],
        );
      },
    );
  }



// Afficher une boîte de dialogue pour ajouter de l'eau
  void _showUpdateWaterDialog() {
    final TextEditingController _waterController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Modifier l\'hydratation'),
          content: TextField(
            controller: _waterController,
            keyboardType: TextInputType.number,
            decoration: InputDecoration(
              hintText: 'Entrez la nouvelle valeur en mL',
              suffixText: 'mL',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('Annuler'),
            ),
            TextButton(
              onPressed: () {
                final int newAmount = int.tryParse(_waterController.text) ?? 0;
                if (newAmount > 0) {
                  _updateWater(newAmount);
                  Navigator.of(context).pop();
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Veuillez entrer une quantité valide')),
                  );
                }
              },
              child: const Text('Mettre à jour'),
            ),
          ],
        );
      },
    );
  }



  @override
  Widget build(BuildContext context) {
    return WillPopScope(
        onWillPop: () async {
      return false; // Empêche l'utilisateur de revenir en arrière
    },
    child: Scaffold(
    backgroundColor: Colors.black,
    body: SafeArea(
    child: SingleChildScrollView(
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    // Header Section avec bouton de déconnexion
    Padding(
    padding: const EdgeInsets.all(12.0),
    child: Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    children: [
    Text(
    "Hello, ${userData['username'] ?? 'User'}!",
    style: const TextStyle(
    color: Colors.white,
    fontSize: 20,
    fontWeight: FontWeight.bold,
    ),
    ),
    IconButton(
    icon: const Icon(Icons.logout, color: Colors.white),
    onPressed: _logout, // Appelle la méthode de déconnexion
    ),
    ],
    ),
    ),
    const SizedBox(height: 16),

    // Informations Section Title
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: const Text(
    "Informations",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(height: 8),

    // Metrics Cards Row
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: Row(
    children: [
    // Calories Burned Card
    Expanded(
    child: GestureDetector(
    onTap: _showUpdateCaloriesDialog,
    child: Container(
    margin: const EdgeInsets.only(right: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.orange.withOpacity(0.4),
    blurRadius: 8,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    const Text(
    "Calories",
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(width: 6),
    Image.asset(
    'assets/images/flamme.png',
    width: 20,
    height: 20,
    ),
    ],
    ),
    const SizedBox(height: 12),
    FAProgressBar(
    currentValue: userData['calories'].toDouble(),
    maxValue: 3000,
    size: 10,
    backgroundColor: Colors.white.withOpacity(0.2),
    progressColor: Colors.white,
    animatedDuration:
    const Duration(milliseconds: 300),
    ),
    const SizedBox(height: 12),
    Text(
    "${userData['calories']} kCal / 3000 kCal",
    style: const TextStyle(
    color: Colors.white,
    fontSize: 10,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    // Hydration Metrics Card
    Expanded(
    child: GestureDetector(
    onTap: _showUpdateWaterDialog,
    child: Container(
    margin: const EdgeInsets.only(left: 6),
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.blue,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.blue.withOpacity(0.4),
    blurRadius: 8,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
    Row(
    children: [
    const Text(
    "Hydration",
    style: TextStyle(
    color: Colors.white,
    fontSize: 16,
    fontWeight: FontWeight.bold,
    ),
    ),
    const SizedBox(width: 6),
    Image.asset(
    'assets/images/goutte.png',
    width: 20,
    height: 20,
    ),
    ],
    ),
    const SizedBox(height: 12),
    FAProgressBar(
    currentValue: userData['hydration'].toDouble(),
    maxValue: 3000,
    size: 10,
    backgroundColor: Colors.white.withOpacity(0.2),
    progressColor: Colors.white,
    animatedDuration:
    const Duration(milliseconds: 300),
    ),
    const SizedBox(height: 12),
    Text(
    "${userData['hydration']} mL / 3L",
    style: const TextStyle(
    color: Colors.white,
    fontSize: 10,
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    const SizedBox(height: 16),

    // AI Coach Section Title
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: const Text(
    "AI Coach",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(height: 8),

    // Virtual AI Coach Card
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: GestureDetector(
    onTap: () {
    Navigator.pushNamed(context, '/choixobjectif');
    },
    child: Container(
    width: double.infinity,
    height: 160,
    decoration: BoxDecoration(
    color: Colors.orange,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.orange.withOpacity(0.4),
    blurRadius: 8,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Stack(
    children: [
    Positioned.fill(
    child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.asset(
    'assets/images/robot1.jpg',
    fit: BoxFit.cover,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.5),
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Align(
    alignment: Alignment.bottomLeft,
    child: Text(
    "AI Conversations",
    style: TextStyle(
    color: Colors.white70,
    fontSize: 14,
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),

    // AI Nutrition Section Title
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: const Text(
    "AI Nutrition",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(height: 8),

    // AI Nutrition Card
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: GestureDetector(
    onTap: () {
    Navigator.pushNamed(context, '/nutrition');
    },
    child: Container(
    width: double.infinity,
    height: 160,
    decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.green.withOpacity(0.4),
    blurRadius: 8,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Stack(
    children: [
    Positioned.fill(
    child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.asset(
    'assets/images/nutrition.webp',
    fit: BoxFit.cover,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.5),
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Align(
    alignment: Alignment.bottomLeft,
    child: Text(
    "AI Nutrition Guide",
    style: TextStyle(
    color: Colors.white70,
    fontSize: 14,
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),

    // Chatbot Section Title
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: const Text(
    "Chatbot",
    style: TextStyle(
    color: Colors.white,
    fontSize: 18,
    fontWeight: FontWeight.bold,
    ),
    ),
    ),
    const SizedBox(height: 8),

    // Chatbot Card
    Padding(
    padding: const EdgeInsets.symmetric(horizontal: 12.0),
    child: GestureDetector(
    onTap: () {
    Navigator.pushNamed(context, '/general_chatbot');
    },
    child: Container(
    width: double.infinity,
    height: 160,
    decoration: BoxDecoration(
    color: Colors.green,
    borderRadius: BorderRadius.circular(12),
    boxShadow: [
    BoxShadow(
    color: Colors.green.withOpacity(0.4),
    blurRadius: 8,
    offset: const Offset(0, 3),
    ),
    ],
    ),
    child: Stack(
    children: [
    Positioned.fill(
    child: ClipRRect(
    borderRadius: BorderRadius.circular(12),
    child: Image.asset(
    'assets/images/chatbot.png',
    fit: BoxFit.cover,
    ),
    ),
    ),
    Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
    color: Colors.black.withOpacity(0.5),
    borderRadius: BorderRadius.circular(12),
    ),
    child: const Align(
    alignment: Alignment.bottomLeft,
    child: Text(
    "ChatBot",
    style: TextStyle(
    color: Colors.white70,
    fontSize: 14,
    ),
    ),
    ),
    ),
    ],
    ),
    ),
    ),
    ),
    const SizedBox(height: 16),

              // Navigation Bar
              Container(
                color: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 6.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.fitness_center),
                      color: Colors.white,
                      iconSize: 26,
                      onPressed: () {
                        Navigator.pushNamed(context, '/choixobjectif');
                      },
                    ),
                    FloatingActionButton(
                      backgroundColor: Colors.orange,
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Icon(
                        Icons.home,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.restaurant_menu),
                      color: Colors.white,
                      iconSize: 26,
                      onPressed: () {
                        Navigator.pushNamed(context, '/nutrition');
                      },
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    ),
    );
  }
}
