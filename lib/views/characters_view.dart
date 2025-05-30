import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../components/personnage_card.dart';
import '../models/personnage.dart';
import 'personnage_view.dart';

class CharactersView extends StatefulWidget {
  const CharactersView({super.key});

  @override
  State<CharactersView> createState() => _CharactersViewState();
}

class _CharactersViewState extends State<CharactersView> {
  List<Personnage> personnages = [];
  bool isLoading = true;
  String? error;

  @override
  void initState() {
    super.initState();
    fetchPersonnages();
  }

  Future<void> fetchPersonnages() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3030/personnages'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          personnages = data.map((json) => Personnage.fromJson(json)).toList();
          isLoading = false;
        });
      } else {
        print('Erreur API: ${response.statusCode} - ${response.body}');
        setState(() {
          error = 'Erreur lors du chargement des personnages';
          isLoading = false;
        });
      }
    } catch (e) {
      print('Exception: $e');
      setState(() {
        error = 'Erreur de connexion au serveur';
        isLoading = false;
      });
    }
  }

  void _navigateToPersonnageDetail(Personnage personnage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonnageView(
          id: personnage.id,
          name: personnage.name,
          imageUrl: personnage.image,
          description: personnage.description,
          cheveux: personnage.cheveux,
          genre: personnage.genre,
          occupation: personnage.occupation,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Personnages'),
        centerTitle: true,
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : error != null
              ? Center(child: Text(error!))
              : GridView.builder(
                  padding: const EdgeInsets.all(16),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: 0.75,
                    crossAxisSpacing: 16,
                    mainAxisSpacing: 16,
                  ),
                  itemBuilder: (context, index) {
                    final personnage = personnages[index];
                    return GestureDetector(
                      onTap: () => _navigateToPersonnageDetail(personnage),
                      child: PersonnageCard(
                        id: personnage.id,
                        name: personnage.name,
                        imageUrl: personnage.image,
                      ),
                    );
                  },
                  itemCount: personnages.length,
                ),
    );
  }
}
