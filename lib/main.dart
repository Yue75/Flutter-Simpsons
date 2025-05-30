import 'package:flutter/material.dart';
import './vues/accueil.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Wiki des Simpsons',
      theme: ThemeData(primarySwatch: Colors.yellow),
      home: const Accueil(),
    );
  }
}

