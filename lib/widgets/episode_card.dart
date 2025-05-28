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
            Image.network("http://localhost:3000${episode.image}", height: 150),
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
