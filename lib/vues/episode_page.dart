import 'package:flutter/material.dart';
import '../controllers/episode_controller.dart';
import '../widgets/episode_card.dart';

class EpisodePage extends StatelessWidget {
  final episodeController = EpisodeController();

  @override
  Widget build(BuildContext context) {
    final episodes = episodeController.getEpisodes();

    return Scaffold(
      appBar: AppBar(title: Text("Épisodes")),
      body: ListView.builder(
        itemCount: episodes.length,
        itemBuilder: (context, index) {
          return EpisodeCard(episode: episodes[index]);
        },
      ),
    );
  }
}
