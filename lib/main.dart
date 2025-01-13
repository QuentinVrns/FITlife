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


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

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
        '/home': (context) => const HomePage(),
        '/login': (context) => const LoginPage(),
        '/signup': (context) => const SignupPage(),
        '/gender': (context) => const GenderPage(),
        '/fitness': (context) => const FitnessExperiencePage(),
        '/exercice': (context) => const ExercisePreferencePage(),


      },
    );
  }
}
