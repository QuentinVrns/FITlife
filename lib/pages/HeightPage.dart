import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AgePage.dart'; // Importe la page suivante

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> with SingleTickerProviderStateMixin {
  double height = 160.0; // Hauteur initiale
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;
  late Animation<double> _opacityAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    );
    _scaleAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeInOut);
    _opacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> saveHeightAndProceed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', height); // Enregistre temporairement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgePage()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/taille.jpg', // Image de fond
              fit: BoxFit.cover,
            ),
          ),
          // Superposition en dégradé
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [Colors.black.withOpacity(0.7), Colors.black.withOpacity(0.4)],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
              ),
            ),
          ),
          SafeArea(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Titre animé
                ScaleTransition(
                  scale: _scaleAnimation,
                  child: FadeTransition(
                    opacity: _opacityAnimation,
                    child: const Text(
                      'Entrer votre taille',
                      style: TextStyle(
                        fontSize: 32, // Taille agrandie
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Espace légèrement augmenté

                // Slider vertical avec effet stylisé
                SizedBox(
                  height: 300, // Augmente la hauteur pour plus de visibilité
                  child: RotatedBox(
                    quarterTurns: -1, // Tourne le slider verticalement
                    child: SliderTheme(
                      data: SliderTheme.of(context).copyWith(
                        trackHeight: 8, // Épaisseur légèrement augmentée
                        thumbShape: const RoundSliderThumbShape(enabledThumbRadius: 14), // Bouton agrandi
                        overlayShape: const RoundSliderOverlayShape(overlayRadius: 28),
                        activeTrackColor: Colors.orange,
                        inactiveTrackColor: Colors.white24,
                        thumbColor: Colors.orange,
                        overlayColor: Colors.orange.withOpacity(0.3),
                      ),
                      child: Slider(
                        value: height,
                        min: 50.0, // Hauteur minimale
                        max: 250.0, // Hauteur maximale
                        divisions: 200,
                        label: '${height.round()} cm',
                        onChanged: (value) {
                          setState(() {
                            height = value;
                          });
                        },
                      ),
                    ),
                  ),
                ),

                // Texte de la hauteur sélectionnée
                FadeTransition(
                  opacity: _opacityAnimation,
                  child: Text(
                    '${height.round()} cm',
                    style: const TextStyle(
                      fontSize: 40, // Texte agrandi
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 30), // Espace ajusté

                // Bouton pour continuer
                ElevatedButton(
                  onPressed: saveHeightAndProceed,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 20), // Bouton agrandi
                    backgroundColor: Colors.white,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  ),
                  child: const Text(
                    'Suivant',
                    style: TextStyle(color: Colors.black, fontSize: 20), // Texte agrandi
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
