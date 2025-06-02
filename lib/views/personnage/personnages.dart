import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../../components/personnage-card.dart';
import '../../models/personnage.model.dart';
import './personnage.dart';

class Personnages extends StatefulWidget {
  const Personnages({super.key});

  @override
  State<Personnages> createState() => _PersonnagesState();
}

class _PersonnagesState extends State<Personnages> {
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
          await http.get(Uri.parse('http://localhost:3030/personnages'));

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

  void _navigateToPersonnage(Personnage personnage) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => PersonnageDetailView(
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
        title: const Text(
          'Personnages',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFD521), // Jaune Simpson
        elevation: 0,
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
                      onTap: () => _navigateToPersonnage(personnage),
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
