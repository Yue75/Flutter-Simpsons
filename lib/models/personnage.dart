class Personnage {
  final String name;
  final String image;
  final String description;
  final String cheveux;
  final String genre;
  final String occupation;

  Personnage({
    required this.name,
    required this.image,
    required this.description,
    required this.cheveux,
    required this.genre,
    required this.occupation,
  });

  factory Personnage.fromMap(Map<String, dynamic> map) {
    return Personnage(
      name: map['name'],
      image: map['image'],
      description: map['description'],
      cheveux: map['cheveux'],
      genre: map['genre'],
      occupation: map['occupation'],
    );
  }
}
