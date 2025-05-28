class Personnage {
  final String nom;
  final String imageUrl;
  final String statut;
  final String genre;
  final String occupation;
  final String aka;
  final String cheveux;
  final List<String> relations;

  Personnage({
    required this.nom,
    required this.imageUrl,
    required this.statut,
    required this.genre,
    required this.occupation,
    required this.aka,
    required this.cheveux,
    required this.relations,
  });
}
