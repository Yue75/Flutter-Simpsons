import 'personnage.dart';

class Episode {
  final String title;
  final String slug;
  final String description;
  final String image;
  final String critique;
  final String dateDiffuse;
  final List<String> musiques;
  final List<Personnage> personnages;

  Episode({
    required this.title,
    required this.slug,
    required this.description,
    required this.image,
    required this.critique,
    required this.dateDiffuse,
    required this.musiques,
    required this.personnages,
  });
}
