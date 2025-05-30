import 'package:flutter/material.dart';
import '../models/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({super.key, required this.episode});

  Widget sectionTitle(String label) => Padding(
    padding: const EdgeInsets.only(top: 10.0, bottom: 4),
    child: Text(
      label,
      style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
    ),
  );

  @override
  Widget build(BuildContext context) {
    // URL complète de l'image avec fallback sur baseUrl si nécessaire
    final imageUrl = episode.image.startsWith('http')
        ? episode.image
        : 'http://10.0.2.2:3030${episode.image}';  // adapte le port ici si besoin
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Affichage de l'image avec contrôle de l'URL
            Image.network(
              imageUrl,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: Center(child: Icon(Icons.broken_image, size: 40)),
                );
              },
            ),

            sectionTitle(episode.title),
            Text("Diffusé le : ${episode.dateDiffuse}"),
            sectionTitle("Description"),
            Text(episode.description),
            sectionTitle("Musique(s)"),
            Text(episode.musiques.join(", ")),
            sectionTitle("Critique"),
            Text(episode.critique),
            sectionTitle("Personnages"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: episode.personnages
                  .map((p) => Text("- ${p.name} (${p.occupation})"))
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }
}
