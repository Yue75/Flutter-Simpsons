import 'package:flutter/material.dart';
import './vues/accueil.dart';
import 'package:simpson_app/vues/home_screen.dart';
import 'vues/home_screen.dart';

void main() {
  runApp(SimpsonsApp());
}

class SimpsonsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpsons Wiki',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const Accueil(),
    );
  }
}
