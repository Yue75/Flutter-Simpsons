class Personnage {
  final String name;
  final String slug;
  final String image;
  final String description;
  final String cheveux;
  final String genre;
  final String occupation;
  final String episodeId;  // si utile

  Personnage({
    required this.name,
    required this.slug,
    required this.image,
    required this.description,
    required this.cheveux,
    required this.genre,
    required this.occupation,
    required this.episodeId,
  });

  factory Personnage.fromMap(Map<String, dynamic> map) {
    return Personnage(
      name: map['name'] ?? '',
      slug: map['slug'] ?? '',
      image: map['image'] ?? '',
      description: map['description'] ?? '',
      cheveux: map['cheveux'] ?? '',
      genre: map['genre'] ?? '',
      occupation: map['occupation'] ?? '',
      episodeId: map['episodeId'] ?? '',
    );
  }
}
