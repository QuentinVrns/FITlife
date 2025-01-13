import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'AgePage.dart'; // Page suivante

class HeightPage extends StatefulWidget {
  const HeightPage({Key? key}) : super(key: key);

  @override
  State<HeightPage> createState() => _HeightPageState();
}

class _HeightPageState extends State<HeightPage> {
  double height = 160.0; // Hauteur initiale
  final double minHeight = 50.0; // Hauteur minimale
  final double maxHeight = 250.0; // Hauteur maximale

  Future<void> saveHeightAndProceed() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setDouble('height', height); // Enregistre temporairement
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => const AgePage()), // Va à la page suivante
    );
  }

  void _onPanUpdate(DragUpdateDetails details) {
    setState(() {
      height -= details.delta.dy * 0.2; // Ajuste la hauteur en fonction du mouvement vertical
      height = height.clamp(minHeight, maxHeight); // Limite la hauteur entre min et max
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
                      '3 of 6',
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
                  'Quelle est votre taille ?',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Frise verticale avec la valeur de la taille
              Expanded(
                child: GestureDetector(
                  onPanUpdate: _onPanUpdate, // Détecte les mouvements verticaux
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      // Affichage de la hauteur
                      RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: '${height.round()}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 56,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const TextSpan(
                              text: ' cm',
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 24,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),

                      // Frise verticale personnalisée
                      Center(
                        child: SizedBox(
                          height: 300, // Hauteur visible de la frise
                          width: 80, // Rétrécit la largeur de la frise
                          child: CustomPaint(
                            painter: HeightBarPainter(
                              height: height,
                              minHeight: minHeight,
                              maxHeight: maxHeight,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              // Bouton "Continuer"
              ElevatedButton(
                onPressed: saveHeightAndProceed, // Navigue vers la page suivante
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
                        fontSize: 18,
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

class HeightBarPainter extends CustomPainter {
  final double height;
  final double minHeight;
  final double maxHeight;

  HeightBarPainter({
    required this.height,
    required this.minHeight,
    required this.maxHeight,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white24
      ..strokeWidth = 2;

    final activePaint = Paint()
      ..color = Colors.orange
      ..strokeWidth = 4;

    const double step = 30.0; // Distance entre les traits
    const double longTickWidth = 40.0;
    const double shortTickWidth = 20.0;

    final centerY = size.height / 2;

    for (double i = -10; i <= 10; i++) {
      final isLongTick = (height + i * 2).round() % 5 == 0;

      final y = centerY + i * step;
      final xStart = size.width / 2 - (isLongTick ? longTickWidth : shortTickWidth) / 2;
      final xEnd = size.width / 2 + (isLongTick ? longTickWidth : shortTickWidth) / 2;

      // Ligne active (au centre)
      if (i == 0) {
        canvas.drawLine(Offset(xStart, y), Offset(xEnd, y), activePaint);
      } else {
        canvas.drawLine(Offset(xStart, y), Offset(xEnd, y), paint);
      }

      // Texte pour les longues graduations
      if (isLongTick && y >= 0 && y <= size.height) {
        final textSpan = TextSpan(
          text: '${(height + i * 2).clamp(minHeight, maxHeight).round()}',
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
          ),
        );
        final textPainter = TextPainter(
          text: textSpan,
          textDirection: TextDirection.ltr,
        );
        textPainter.layout();
        textPainter.paint(
          canvas,
          Offset(size.width / 2 - textPainter.width / 2, y - 10),
        );
      }
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
