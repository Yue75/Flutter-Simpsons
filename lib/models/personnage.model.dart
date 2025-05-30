class Personnage {
  final String id;
  final String name;
  final String slug;
  final String image;
  final String description;
  final String cheveux;
  final String genre;
  final String occupation;

  Personnage({
    required this.id,
    required this.name,
    required this.slug,
    required this.image,
    required this.description,
    required this.cheveux,
    required this.genre,
    required this.occupation,
  });

  factory Personnage.fromJson(Map<String, dynamic> json) {
    return Personnage(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
      description: json['description'],
      cheveux: json['cheveux'],
      genre: json['genre'],
      occupation: json['occupation'],
    );
  }
}
