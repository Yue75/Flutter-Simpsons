import 'package:flutter/material.dart';
import '../models/episode.dart';

class EpisodeCard extends StatelessWidget {
  final Episode episode;

  const EpisodeCard({Key? key, required this.episode}) : super(key: key);

  Widget sectionTitle(String label) => Padding(
        padding: const EdgeInsets.only(top: 10.0, bottom: 4),
        child: Text(
          label,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
        ),
      );

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(episode.imageUrl, height: 150),
            sectionTitle("${episode.saison}x${episode.numero} - ${episode.titre}"),
            Text(episode.description),
            sectionTitle("Musique"),
            Text(episode.musique),
            sectionTitle("Personnages"),
            Text(episode.personnages.join(', ')),
            sectionTitle("Critique"),
            Text(episode.critique),
          ],
        ),
      ),
    );
  }
}
