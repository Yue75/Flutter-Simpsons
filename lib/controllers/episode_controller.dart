import '../models/episode.dart';
import '../services/mongo_service.dart';

class EpisodeController {
  Future<List<Episode>> fetchEpisodesFromMongo() async {
    await MongoService.connect();
    final episodes = await MongoService.getEpisodesWithPersonnages();
    await MongoService.close();
    return episodes;
  }
}

