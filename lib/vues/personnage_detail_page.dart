import 'package:flutter/material.dart';
import '../models/personnage.dart';
import 'episode_page.dart';

class PersonnageDetailPage extends StatelessWidget {
  final Personnage personnage;

  const PersonnageDetailPage({super.key, required this.personnage});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(personnage.name),
        actions: [
          IconButton(
            icon: const Icon(Icons.tv),
            tooltip: 'Voir les épisodes',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (_) => const EpisodePage()),
              );
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12),
                child: Image.network(
                  personnage.image.startsWith('http')
                      ? personnage.image
                      : 'http://10.0.2.2:3030${personnage.image}',
                  height: 250,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const Icon(Icons.broken_image, size: 100),
                ),
              ),
            ),
            const SizedBox(height: 16),

            Text(
              'Slug: ${personnage.slug}',
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),

            Text(personnage.description),
            const SizedBox(height: 12),

            Text("Cheveux : ${personnage.cheveux}"),
            Text("Genre : ${personnage.genre}"),
          ],
        ),
      ),
    );
  }
}
