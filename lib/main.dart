import 'package:flutter/material.dart';
import 'package:simpson_app/vues/home_screen.dart';
import 'vues/home_screen.dart';
import 'styles/style.dart';  // Import du thème personnalisé

void main() {
  runApp(SimpsonsApp());
}

class SimpsonsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpsons Wiki',
      debugShowCheckedModeBanner: false,
      theme: appTheme,  // Utilisation de ton thème custom depuis style.dart
      home: HomeScreen(),
    );
  }
}


