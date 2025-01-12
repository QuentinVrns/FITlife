import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AgePage extends StatefulWidget {
  const AgePage({Key? key}) : super(key: key);

  @override
  State<AgePage> createState() => _AgePageState();
}

class _AgePageState extends State<AgePage> with SingleTickerProviderStateMixin {
  int age = 25;

  late FixedExtentScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = FixedExtentScrollController(initialItem: age - 1); // Démarre à 25 ans
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Future<void> saveAgeAndFinish() async {
    final prefs = await SharedPreferences.getInstance();

    // Enregistre l'âge
    await prefs.setInt('age', age);

    // Récupère les données temporaires
    final fullName = prefs.getString('fullName') ?? '';
    final email = prefs.getString('email') ?? '';
    final password = prefs.getString('password') ?? '';
    final weight = prefs.getDouble('weight') ?? 0.0;
    final height = prefs.getDouble('height') ?? 0.0;

    // Vérifie si tout est présent
    if (fullName.isNotEmpty &&
        email.isNotEmpty &&
        password.isNotEmpty &&
        weight > 0.0 &&
        height > 0.0 &&
        age > 0) {
      // Ajoute les informations au fichier des comptes
      final accounts = prefs.getStringList('accounts') ?? [];
      final newAccount = '$fullName:$email:$password:$weight:$height:$age';
      accounts.add(newAccount);
      await prefs.setStringList('accounts', accounts);

      // Debugging
      print('Comptes enregistrés : $accounts');

      // Nettoie les données temporaires
      await prefs.remove('fullName');
      await prefs.remove('email');
      await prefs.remove('password');
      await prefs.remove('weight');
      await prefs.remove('height');
      await prefs.remove('age');

      // Redirige vers la page Home
      Navigator.pushNamed(context, '/home');
    } else {
      // Affiche une erreur si les données sont incomplètes
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: const Text('Erreur'),
          content: const Text('Impossible d’enregistrer les données. Veuillez recommencer.'),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: const Text('OK'),
            ),
          ],
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/horloge.jpg', // Image de fond
              fit: BoxFit.cover,
            ),
          ),
          // Superposition sombre
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre
                const Text(
                  'Quel est votre âge ?',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),

                // Compteur interactif vertical
                SizedBox(
                  height: 200,
                  child: ListWheelScrollView.useDelegate(
                    controller: _scrollController,
                    itemExtent: 50,
                    perspective: 0.01,
                    physics: const FixedExtentScrollPhysics(),
                    onSelectedItemChanged: (index) {
                      setState(() {
                        age = index + 1; // Convertit l'index en âge
                      });
                    },
                    childDelegate: ListWheelChildBuilderDelegate(
                      builder: (context, index) {
                        return Center(
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              fontSize: age == index + 1 ? 36 : 26,
                              fontWeight: FontWeight.bold,
                              color: age == index + 1 ? Colors.orange : Colors.white,
                            ),
                          ),
                        );
                      },
                      childCount: 100, // Limite supérieure (100 ans)
                    ),
                  ),
                ),
                const SizedBox(height: 20),

                // Bouton pour terminer
                ElevatedButton(
                  onPressed: saveAgeAndFinish,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20),
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Terminer',
                    style: TextStyle(color: Colors.black, fontSize: 20),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
