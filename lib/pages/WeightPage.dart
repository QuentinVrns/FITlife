import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HeightPage.dart'; // Importe la page suivante

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  double weight = 60.0; // Poids initial
  double minWeight = 30.0; // Poids minimum
  double maxWeight = 200.0; // Poids maximum
  bool isHolding = false; // Pour détecter la pression continue

  Future<void> saveWeightAndProceed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', weight); // Enregistre temporairement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HeightPage()),
    );
  }

  // Fonction pour incrémenter ou décrémenter en continu
  void _startAdjustingWeight(bool isIncrement) {
    setState(() {
      isHolding = true;
    });

    Future.doWhile(() async {
      if (!isHolding) return false; // Arrêter si l'utilisateur relâche
      setState(() {
        if (isIncrement && weight < maxWeight) {
          weight += 1;
        } else if (!isIncrement && weight > minWeight) {
          weight -= 1;
        }
      });
      await Future.delayed(const Duration(milliseconds: 100)); // Vitesse d'ajustement
      return isHolding;
    });
  }

  // Fonction pour arrêter l'ajustement
  void _stopAdjustingWeight() {
    setState(() {
      isHolding = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Image de fond
          Positioned.fill(
            child: Image.asset(
              'assets/images/balance.jpg', // Image de fond
              fit: BoxFit.cover,
            ),
          ),
          // Superposition sombre
          Container(
            color: Colors.black.withOpacity(0.6),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Titre
                  const Text(
                    'Entrer votre poids',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 20),

                  // Cercle avec poids et progression
                  Stack(
                    alignment: Alignment.center,
                    children: [
                      // Fond du cercle
                      SizedBox(
                        width: 200,
                        height: 200,
                        child: CircularProgressIndicator(
                          value: (weight - minWeight) / (maxWeight - minWeight), // Remplissage
                          strokeWidth: 10,
                          backgroundColor: Colors.white24,
                          valueColor: const AlwaysStoppedAnimation<Color>(Colors.orange),
                        ),
                      ),
                      // Texte du poids
                      Text(
                        '${weight.round()} kg',
                        style: const TextStyle(
                          fontSize: 36,
                          fontWeight: FontWeight.bold,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Boutons "+" et "-"
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Bouton "-"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (weight > minWeight) weight -= 1;
                          });
                        },
                        onLongPress: () => _startAdjustingWeight(false), // Décrément continu
                        onLongPressUp: _stopAdjustingWeight, // Arrêter quand relâché
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.remove,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                      const SizedBox(width: 40),
                      // Bouton "+"
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (weight < maxWeight) weight += 1;
                          });
                        },
                        onLongPress: () => _startAdjustingWeight(true), // Incrément continu
                        onLongPressUp: _stopAdjustingWeight, // Arrêter quand relâché
                        child: Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Colors.white,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.add,
                            color: Colors.black,
                            size: 30,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 40),

                  // Bouton pour continuer
                  ElevatedButton(
                    onPressed: saveWeightAndProceed,
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                      backgroundColor: Colors.white,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                    child: const Text(
                      'Suivant',
                      style: TextStyle(color: Colors.black, fontSize: 18),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
