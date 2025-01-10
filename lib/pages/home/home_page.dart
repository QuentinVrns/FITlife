import 'package:flutter/material.dart';
import 'widgets/header.dart'; // Import du fichier Header

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Accueil'),
      ),
      body: Column(
        children: [
          Header(), // Utilisation du widget Header
          Expanded(
            child: Center(
              child: Text('Bienvenue dans mon application !'),
            ),
          ),
        ],
      ),
    );
  }
}
