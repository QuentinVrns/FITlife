import 'package:flutter/material.dart';
import 'package:fitlife/pages/home/home_page.dart';
import 'package:fitlife/routes/app_routes.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      routes: AppRoutes.routes, // Utilisation des routes
    );
  }
}
