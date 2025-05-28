import 'dart:async';
import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/episode.dart';
import '../models/personnage.dart';

class EpisodeController {
  // Utilisation d'une URL dynamique selon la plateforme
  final String baseUrl = 'http://localhost:3030';

  Future<List<Episode>> fetchEpisodes() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/episodes'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('La requête a expiré');
            },
          );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((jsonEpisode) {
          final personnagesData = jsonEpisode['personnages'] ?? [];
          final personnages = List<Personnage>.from(
            personnagesData.map((p) => Personnage.fromMap(p)),
          );

          return Episode(
            title: jsonEpisode['title'],
            slug: jsonEpisode['slug'],
            description: jsonEpisode['description'],
            image: jsonEpisode['image'],
            critique: jsonEpisode['critique'],
            dateDiffuse: jsonEpisode['dateDiffuse'],
            musiques: List<String>.from(jsonEpisode['musiques']),
            personnages: personnages,
          );
        }).toList();
      } else {
        throw Exception('Erreur chargement épisodes : ${response.statusCode}');
      }
    } catch (e) {
      if (e is TimeoutException) {
        throw Exception(
          'Le serveur met trop de temps à répondre. Veuillez réessayer.',
        );
      }
      throw Exception('Erreur de connexion : ${e.toString()}');
    }
  }
}
