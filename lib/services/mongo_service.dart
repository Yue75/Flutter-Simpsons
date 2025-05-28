import 'package:mongo_dart/mongo_dart.dart';
import '../models/episode.dart';
import '../models/personnage.dart';

class MongoService {
  static late Db db;
  static late DbCollection episodesCollection;
  static late DbCollection personnagesCollection;

  static Future<void> connect() async {
    db = await Db.create("mongodb://10.0.2.2:27017/simpsonsDB");
    await db.open();
    episodesCollection = db.collection("episodes");
    personnagesCollection = db.collection("personnages");
  }

  static Future<List<Episode>> getEpisodesWithPersonnages() async {
    final episodesRaw = await episodesCollection.find().toList();
    List<Episode> episodes = [];

    for (var ep in episodesRaw) {
      final epId = ep['_id'];
      final personnagesRaw = await personnagesCollection
          .find(where.eq('episodeId', epId))
          .toList();
      final personnages = personnagesRaw
          .map((p) => Personnage.fromMap(p))
          .toList();

      episodes.add(
        Episode(
          title: ep['title'],
          slug: ep['slug'],
          description: ep['description'],
          image: ep['image'],
          critique: ep['critique'],
          dateDiffuse: ep['dateDiffuse'],
          musiques: List<String>.from(ep['musiques']),
          personnages: personnages,
        ),
      );
    }

    return episodes;
  }

  static Future<List<Personnage>> getAllPersonnages() async {
    final personnagesRaw = await personnagesCollection.find().toList();
    return personnagesRaw.map((p) => Personnage.fromMap(p)).toList();
  }

  static Future<void> close() async {
    await db.close();
  }
}
