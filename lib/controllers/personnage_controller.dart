import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/personnage.dart';

class PersonnageController {
  final String baseUrl = 'http://10.0.2.2:3030';

  Future<List<Personnage>> fetchPersonnages() async {
    final response = await http.get(Uri.parse('$baseUrl/personnages'));

    if (response.statusCode == 200) {
      final List<dynamic> data = json.decode(response.body);
      return data.map((p) => Personnage.fromMap(p)).toList();
    } else {
      throw Exception('Erreur chargement personnages : ${response.statusCode}');
    }
  }
}
