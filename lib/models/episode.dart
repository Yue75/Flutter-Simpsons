class Episode {
  final String titre;
  final String description;
  final String musique;
  final List<String> personnages;
  final String critique;
  final String imageUrl;
  final int saison;
  final int numero;

  Episode({
    required this.titre,
    required this.description,
    required this.musique,
    required this.personnages,
    required this.critique,
    required this.imageUrl,
    required this.saison,
    required this.numero,
  });
}
