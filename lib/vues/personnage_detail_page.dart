import 'package:flutter/material.dart';
import '../models/personnage.dart';
import 'episode_page.dart';

class PersonnageDetailPage extends StatelessWidget {
  final Personnage personnage;

  const PersonnageDetailPage({Key? key, required this.personnage})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personnage.name),
        actions: [
          IconButton(
            icon: Icon(Icons.tv),
            tooltip: 'Voir les épisodes',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => EpisodePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  personnage.image.startsWith('http')
                      ? personnage.image
                      : "http://10.0.2.2:3000${personnage.image}",
                  height: 250,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(height: 16),
            Text(
              'Slug: ${personnage.slug}',
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 12),
            Text(personnage.description),
            SizedBox(height: 12),
            Text("Cheveux : ${personnage.cheveux}"),
            Text("Genre : ${personnage.genre}"),
            Text("Occupation : ${personnage.occupation}"),
          ],
        ),
      ),
    );
  }
}
