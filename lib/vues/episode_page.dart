import 'package:flutter/material.dart';

import '../controllers/episode_controller.dart';
import '../models/episode.dart';
import '../widgets/episode_card.dart';

class EpisodePage extends StatefulWidget {
  const EpisodePage({super.key});

  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  final episodeController = EpisodeController();
  late Future<List<Episode>> futureEpisodes;

  @override
  void initState() {
    super.initState();
    // On appelle directement la méthode http dans le controller
    futureEpisodes = episodeController.fetchEpisodes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Épisodes")),
      body: FutureBuilder<List<Episode>>(
        future: futureEpisodes,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          final episodes = snapshot.data!;
          return ListView.builder(
            itemCount: episodes.length,
            itemBuilder: (context, index) {
              return EpisodeCard(episode: episodes[index]);
            },
          );
        },
      ),
    );
  }
}
