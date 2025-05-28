import 'package:flutter/material.dart';
import '../controllers/episode_controller.dart';
import '../widgets/episode_card.dart';
import '../models/episode.dart';

class EpisodePage extends StatefulWidget {
  @override
  State<EpisodePage> createState() => _EpisodePageState();
}

class _EpisodePageState extends State<EpisodePage> {
  final episodeController = EpisodeController();
  late Future<List<Episode>> futureEpisodes;

  @override
  void initState() {
    super.initState();
    futureEpisodes = episodeController.fetchEpisodesFromMongo();
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
