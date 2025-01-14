import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'GenderPage.dart'; // Importer la page suivante

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  final TextEditingController fullNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  String errorMessage = '';

  /// Valider le format de l'e-mail
  bool isValidEmail(String email) {
    final regex = RegExp(r'^[a-zA-Z0-9._%-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,4}$');
    return regex.hasMatch(email);
  }

  /// Enregistrer les informations de base temporairement
  Future<void> saveBasicInfo(String username, String email, String password) async {
    try {
      final prefs = await SharedPreferences.getInstance();

      // Vérifie si l'email est déjà utilisé
      final accounts = prefs.getStringList('accounts') ?? [];
      if (accounts.any((line) => line.split(':')[1] == email)) {
        setState(() {
          errorMessage = 'Email already exists!';
        });
        return;
      }

      // Enregistrer les informations utilisateur
      await prefs.setString('username', username);
      await prefs.setString('email', email);
      await prefs.setString('password', password);

      // Naviguer vers la page suivante
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => const GenderPage()),
      );
    } catch (e) {
      setState(() {
        errorMessage = 'Failed to save account: $e';
      });
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
              'assets/images/background.jpg',
              fit: BoxFit.cover,
            ),
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

                    // Titre
                    const Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 40),

                    // Champ Full Name
                    TextField(
                      controller: fullNameController,
                      decoration: InputDecoration(
                        labelText: 'Full Name',
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

                    // Champ Email
                    TextField(
                      controller: emailController,
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
                      controller: passwordController,
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
                    const SizedBox(height: 20),

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

                    // Bouton pour continuer
                    Align(
                      alignment: Alignment.centerRight,
                      child: ElevatedButton(
                        onPressed: () {
                          final fullName = fullNameController.text.trim();
                          final email = emailController.text.trim();
                          final password = passwordController.text.trim();

                          if (fullName.isEmpty || email.isEmpty || password.isEmpty) {
                            setState(() {
                              errorMessage = 'Please fill in all fields';
                            });
                            return;
                          }

                          if (!isValidEmail(email)) {
                            setState(() {
                              errorMessage = 'Invalid email format';
                            });
                            return;
                          }

                          saveBasicInfo(fullName, email, password);
                        },
                        style: ElevatedButton.styleFrom(
                          shape: const CircleBorder(),
                          padding: const EdgeInsets.all(16),
                          backgroundColor: Colors.white,
                        ),
                        child: const Icon(
                          Icons.arrow_forward,
                          color: Colors.black,
                        ),
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
