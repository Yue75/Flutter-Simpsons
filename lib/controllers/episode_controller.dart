import '../models/episode.dart';

class EpisodeController {
  List<Episode> getEpisodes() {
    return [
      Episode(
        titre: "Simpsons Roasting on an Open Fire",
        description: "Le premier épisode de la série où Homer devient Père Noël pour acheter des cadeaux.",
        imageUrl: "https://static.wikia.nocookie.net/simpsons/images/3/3e/S1e1.png",
        personnages: ["Homer", "Marge", "Bart", "Lisa", "Maggie"],
        saison: 1,
        numero: 1,
      ),
      Episode(
        titre: "Bart the Genius",
        description: "Bart est envoyé dans une école pour surdoués après avoir triché à un test de QI.",
        imageUrl: "https://static.wikia.nocookie.net/simpsons/images/f/f3/Bart_the_Genius.png",
        personnages: ["Bart", "Homer", "Lisa"],
        saison: 1,
        numero: 2,
      ),
      Episode(
        titre: "Homer's Odyssey",
        description: "Homer perd son emploi et devient militant pour la sécurité.",
        imageUrl: "https://static.wikia.nocookie.net/simpsons/images/d/d3/Homer%27s_Odyssey.png",
        personnages: ["Homer", "Marge", "Bart"],
        saison: 1,
        numero: 3,
      ),
    ];
  }
}
