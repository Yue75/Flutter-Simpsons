import 'package:flutter/material.dart';
import '../models/personnage.dart';

class PersonnageCard extends StatelessWidget {
  final Personnage personnage;

  const PersonnageCard({Key? key, required this.personnage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 8, horizontal: 12),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Image.network(personnage.imageUrl, height: 150),
            SizedBox(height: 8),
            Text(personnage.nom, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 8),
            Text("Statut : ${personnage.statut}"),
            Text("Sexe : ${personnage.genre}"),
            Text("Occupation : ${personnage.occupation}"),
            Text("AKA : ${personnage.aka}"),
            Text("Cheveux : ${personnage.cheveux}"),
            SizedBox(height: 4),
            Text("Relations : ${personnage.relations.join(', ')}"),
          ],
        ),
      ),
    );
  }
}
