class Episode {
  final String id;
  final String title;
  final String slug;
  final String description;
  final String image;
  final String critique;
  final String dateDiffuse;
  final List<String> musiques;

  Episode({
    required this.id,
    required this.title,
    required this.slug,
    required this.description,
    required this.image,
    required this.critique,
    required this.dateDiffuse,
    required this.musiques,
  });

  factory Episode.fromJson(Map<String, dynamic> json) {
    return Episode(
      id: json['id'] as String,
      title: json['title'] as String,
      slug: json['slug'] as String,
      description: json['description'] as String,
      image: json['image'] as String,
      critique: json['critique'] as String,
      dateDiffuse: json['dateDiffuse'] as String,
      musiques: List<String>.from(json['musiques'] as List),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'description': description,
      'image': image,
      'critique': critique,
      'dateDiffuse': dateDiffuse,
      'musiques': musiques,
    };
  }
}

class Season {
  final String id;
  final int numero;
  final String titre;
  final String slug;
  final String image;
  final List<Episode> episodes;

  Season({
    required this.id,
    required this.numero,
    required this.titre,
    required this.slug,
    required this.image,
    required this.episodes,
  });

  factory Season.fromJson(Map<String, dynamic> json) {
    return Season(
      id: json['id'] as String,
      numero: json['numero'] as int,
      titre: json['titre'] as String,
      slug: json['slug'] as String,
      image: json['image'] as String,
      episodes: (json['episodes'] as List?)
              ?.map((e) => Episode.fromJson(e as Map<String, dynamic>))
              .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'numero': numero,
      'titre': titre,
      'slug': slug,
      'image': image,
      'episodes': episodes.map((e) => e.toJson()).toList(),
    };
  }
}
