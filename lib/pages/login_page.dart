import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';


class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  // Variables pour les champs de texte
  String email = '';
  String password = '';

  // Liste des utilisateurs enregistrés
  Map<String, String> users = {};

  // Variable pour le message d'erreur
  String errorMessage = '';

  @override
  void initState() {
    super.initState();
    _loadUsers();
  }

  // Fonction pour charger les utilisateurs enregistrés
  Future<void> _loadUsers() async {
    final prefs = await SharedPreferences.getInstance();
    final accounts = prefs.getStringList('accounts') ?? [];

    // Transformer la liste en Map : email -> password
    final Map<String, String> loadedUsers = {};
    for (var account in accounts) {
      final parts = account.split(':'); // Format : fullName:email:password:weight:height:age
      if (parts.length >= 3) { // Ignore les champs supplémentaires
        loadedUsers[parts[1]] = parts[2]; // email -> password
      }
    }

    setState(() {
      users = loadedUsers;
    });

    // Debugging
    print('Utilisateurs chargés : $users');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset('assets/images/background.jpg', fit: BoxFit.cover),
          ),

          // Contenu principal
          Container(
            color: Colors.black.withOpacity(0.5), // Fond transparent
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Bouton retour
                    IconButton(
                      icon: const Icon(Icons.arrow_back, color: Colors.white),
                      onPressed: () {
                        Navigator.pop(context);
                      },
                    ),
                    const SizedBox(height: 20),

                    // Titre "Sign In"
                    const Text(
                      'Sign In',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Champ Email
                    TextField(
                      onChanged: (value) {
                        setState(() {
                          email = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Email',
                        labelStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 20),

                    // Champ Password
                    TextField(
                      obscureText: true,
                      onChanged: (value) {
                        setState(() {
                          password = value.trim();
                        });
                      },
                      decoration: InputDecoration(
                        labelText: 'Password',
                        labelStyle: const TextStyle(
                          color: Colors.white70,
                        ),
                        filled: true,
                        fillColor: Colors.white.withOpacity(0.2),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide.none,
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(color: Colors.white),
                        ),
                      ),
                      style: const TextStyle(color: Colors.white),
                    ),
                    const SizedBox(height: 10),

                    // Message d'erreur
                    if (errorMessage.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8.0),
                        child: Text(
                          errorMessage,
                          style: const TextStyle(
                            color: Colors.red,
                            fontSize: 14,
                          ),
                        ),
                      ),

                    const SizedBox(height: 40),

                    // Bouton de connexion
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          if (users[email] == password) {
                            // Si l'utilisateur est trouvé
                            Navigator.pushNamed(context, '/home');
                          } else {
                            setState(() {
                              errorMessage = 'Incorrect email or password';
                            });
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white, // Bouton blanc
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black, // Icône noire
                        ),
                      ),
                    ),

                    // Lien "Sign Up"
                    const Spacer(),
                    Center(
                      child: Column(
                        children: [
                          const Text(
                            "Vous n'avez pas de compte?",
                            style: TextStyle(color: Colors.white70),
                          ),
                          TextButton(
                            onPressed: () {
                              Navigator.pushNamed(context, '/signup');
                            },
                            child: const Text(
                              'Sign Up',
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
