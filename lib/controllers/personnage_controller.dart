import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/personnage.dart';

class PersonnageController {
  final String baseUrl = 'http://10.0.2.2:3030';

  Future<List<Personnage>> fetchPersonnages() async {
    try {
      final response = await http
          .get(Uri.parse('$baseUrl/personnages'))
          .timeout(
            const Duration(seconds: 10),
            onTimeout: () {
              throw TimeoutException('La requête a expiré');
            },
          );

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        return data.map((p) => Personnage.fromMap(p)).toList();
      } else {
        throw Exception('Erreur chargement personnages : ${response.statusCode}');
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
