import 'package:flutter/material.dart';
import 'package:simpson_app/vues/personnage_page.dart';
import 'vues/personnage_page.dart';

void main() {
  runApp(SimpsonsApp());
}

class SimpsonsApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simpsons Characters',
      theme: ThemeData(
        primarySwatch: Colors.yellow,
      ),
      home: PersonnagePage(),
    );
  }
}
