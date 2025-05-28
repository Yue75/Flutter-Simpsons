class Episode {
  final String titre;
  final String description;
  final String imageUrl;
  final List<String> personnages;
  final int saison;
  final int numero;

  Episode({
    required this.titre,
    required this.description,
    required this.imageUrl,
    required this.personnages,
    required this.saison,
    required this.numero,
  });
}
