class Character {
  final int id;
  final String name;
  final String imageUrl;
  final String description;
  final bool isMainCharacter;

  Character({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.isMainCharacter,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return Character(
      id: json['id'] as int,
      name: json['name'] as String,
      imageUrl: json['imageUrl'] as String,
      description: json['description'] as String,
      isMainCharacter: json['isMainCharacter'] as bool,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'imageUrl': imageUrl,
      'description': description,
      'isMainCharacter': isMainCharacter,
    };
  }
}
