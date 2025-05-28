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
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              personnage.image.startsWith("http")
                  ? personnage.image
                  : "http://localhost:3000${personnage.image}",
              height: 150,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 8),
            Text(personnage.name, style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            Text(personnage.description),
            SizedBox(height: 8),
            Text("Genre : ${personnage.genre}"),
            Text("Cheveux : ${personnage.cheveux}"),
            Text("Occupation : ${personnage.occupation}"),
          ],
        ),
      ),
    );
  }
}
