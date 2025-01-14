import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'HeightPage.dart';

class WeightPage extends StatefulWidget {
  const WeightPage({Key? key}) : super(key: key);

  @override
  State<WeightPage> createState() => _WeightPageState();
}

class _WeightPageState extends State<WeightPage> {
  double weight = 70.0; // Poids initial
  final double minWeight = 30.0; // Poids minimum
  final double maxWeight = 200.0; // Poids maximum

  Future<void> saveWeightAndProceed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('weight', weight); // Enregistre le poids temporairement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const HeightPage()), // Redirige vers la page suivante
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      weight += details.delta.dx * 0.2; // Ajuste le poids par petites étapes
      weight = weight.clamp(minWeight, maxWeight); // Limite le poids entre le minimum et le maximum
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Barre supérieure
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white.withOpacity(0.2),
                      ),
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.arrow_back_ios,
                        color: Colors.white,
                        size: 24,
                      ),
                    ),
                  ),
                  const Text(
                    'Questionnaire',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: Colors.blue.withOpacity(0.2),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: const Text(
                      '2 of 6',
                      style: TextStyle(
                        color: Colors.blue,
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 30),

              // Question centrée
              Center(
                child: const Text(
                  'Quel est votre poids ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 40),

              // Affichage du poids et barre personnalisée
              Expanded(
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate, // Détecte les balayages horizontaux
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Affichage centré du poids
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${weight.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 64,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' kg',
                              style: TextStyle(
                                color: Colors.white70,
                                fontSize: 20,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Barre de mesure personnalisée
                      CustomPaint(
                        size: const Size(double.infinity, 100), // Taille réduite
                        painter: WeightBarPainter(
                          weight: weight,
                          minWeight: minWeight,
                          maxWeight: maxWeight,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bouton "Continuer"
              ElevatedButton(
                onPressed: saveWeightAndProceed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.orange,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30),
                  ),
                  padding: const EdgeInsets.symmetric(vertical: 15),
                  shadowColor: Colors.orange.withOpacity(0.4),
                  elevation: 8,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Text(
                      'Continuer',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    SizedBox(width: 10),
                    Icon(
                      Icons.arrow_forward,
                      color: Colors.white,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

class WeightBarPainter extends CustomPainter {
  final double weight;
  final double minWeight;
  final double maxWeight;

  WeightBarPainter({
    required this.weight,
    required this.minWeight,
    required this.maxWeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 1.5;

    final activePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 3;

    const double step = 20.0;
    const double longTickHeight = 30.0;
    const double shortTickHeight = 15.0;

    final centerX = size.width / 2;
    final centerY = size.height / 2;

    for (double i = -10; i <= 10; i++) {
      final isLongTick = (weight + i).round() % 5 == 0;

      final x = centerX + i * step;
      final yStart = centerY - (isLongTick ? longTickHeight : shortTickHeight);
      final yEnd = centerY;

      // Ligne active (au centre)
      if (i == 0) {
        canvas.drawLine(Offset(x, yStart), Offset(x, yEnd), activePaint);
      } else {
        canvas.drawLine(Offset(x, yStart), Offset(x, yEnd), paint);
      }

      // Texte pour les longues graduations
      if (isLongTick) {
        final textSpan = TextSpan(
          text: '${(weight + i).clamp(minWeight, maxWeight).round()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 12,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(x - textPainter.width / 2, centerY + 10),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
