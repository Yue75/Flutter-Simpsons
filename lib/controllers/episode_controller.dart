import '../models/episode.dart';

class EpisodeController {
  List<Episode> getEpisodes() {
    return [
      Episode(
        titre: "Simpsons Roasting on an Open Fire",
        description: "Premier épisode : Homer devient Père Noël pour acheter des cadeaux.",
        musique: "Jingle Bells, Carol of the Bells",
        personnages: ["Homer", "Marge", "Bart", "Lisa", "Maggie"],
        critique: "Un épisode fondateur, tendre et drôle.",
        imageUrl: "https://static.wikia.nocookie.net/simpsons/images/3/3e/S1e1.png",
        saison: 1,
        numero: 1,
      ),
      Episode(
        titre: "Bart the Genius",
        description: "Bart est envoyé dans une école de surdoués après avoir triché.",
        musique: "Beethoven - Ode à la joie",
        personnages: ["Bart", "Lisa", "Homer"],
        critique: "Une bonne satire sur l'éducation et l'étiquette d'intelligence.",
        imageUrl: "https://static.wikia.nocookie.net/simpsons/images/f/f3/Bart_the_Genius.png",
        saison: 1,
        numero: 2,
      ),
    ];
  }
}
