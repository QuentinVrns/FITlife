import 'package:fitlife/pages/ChoixObjectifIA.dart';
import 'pages/NutritionGoalPage.dart'; // Import de la page principale pour la nutrition
import 'package:flutter/material.dart';
import 'pages/home_page.dart';
import 'pages/login_page.dart';
import 'pages/signup_page.dart';
import 'pages/splash_page.dart';
import 'pages/HeightPage.dart';
import 'pages/WeightPage.dart';
import 'pages/AgePage.dart';
import 'pages/GenderPage.dart';
import 'pages/FitnessExperiencePage.dart';
import 'pages/ExercisePreferencePage.dart';
import 'pages/training_page.dart'; // Import de la page Training
import 'pages/nutrition_page.dart'; // Import de la page Nutrition
import 'pages/GeneralChatBotPage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'FITlife',
      initialRoute: '/splash',
      routes: {
        '/splash': (context) => const SplashPage(),
        '/weight': (context) => const WeightPage(),
        '/height': (context) => const HeightPage(),
        '/age': (context) => const AgePage(),
        '/home': (context) => HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/gender': (context) => const GenderPage(),
        '/fitness': (context) => const FitnessExperiencePage(),
        '/exercice': (context) => const ExercisePreferencePage(),
        '/choixobjectif': (context) => const GoalSelectionPage(),
        '/training': (context) => const TrainingPage(), // Route pour AI Training
        '/nutrition': (context) => const NutritionGoalPage(), // Route pour AI Nutrition
        '/general_chatbot': (context) => const GeneralChatBotPage(),
      },
    );
  }
}