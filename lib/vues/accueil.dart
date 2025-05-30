import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'episode_page.dart';
import 'personnage_page.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  int _selectedIndex = 0;
  final List<Widget> _pages = const [PersonnagePage(), EpisodePage()];

  List<String> protagonistes = [
    'Homer Simpson',
    'Marge Simpson',
    'Bart Simpson',
    'Lisa Simpson',
    'Maggie Simpson',
  ];
  List<Map<String, dynamic>> saisons = [];
  List<String> actualites = [
    'La saison 34 est en cours de diffusion.',
    'Un nouvel épisode spécial est prévu pour Noël.',
    'Le film des Simpsons a été annoncé pour 2024.',
    'Un crossover avec Futurama est en préparation.',
    'Les Simpsons ont été renouvelés pour deux saisons supplémentaires.',
  ];

  @override
  void initState() {
    super.initState();
    fetchData();
  }

  Future<void> fetchData() async {
    try {
      final saisonsResponse = await http.get(
        Uri.parse('http://localhost:3030/saisons'),
      );

      if (saisonsResponse.statusCode == 200) {
        final List<dynamic> jsonData = json.decode(saisonsResponse.body);
        setState(() {
          saisons = jsonData
              .map((item) => item as Map<String, dynamic>)
              .toList();
        });
      } else {
        throw Exception('Erreur lors de la récupération des données');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  Widget _buildHomeContent() {
    return saisons.isEmpty
        ? const Center(child: CircularProgressIndicator())
        : SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Introduction',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                const Text(
                  'Les Simpsons est une série télévisée animée américaine créée par Matt Groening. '
                  'Elle raconte la vie quotidienne de la famille Simpson dans la ville fictive de Springfield.',
                ),
                const SizedBox(height: 16),
                const Text(
                  'Protagonistes',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: protagonistes
                      .map(
                        (protagoniste) => ListTile(
                          leading: const Icon(Icons.person),
                          title: Text(protagoniste),
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                const Text(
                  'Saisons',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
                const SizedBox(height: 8),
                Column(
                  children: saisons
                      .map(
                        (saison) => ListTile(
                          leading: ClipRRect(
                            borderRadius: BorderRadius.circular(8.0),
                            child: Image.network(
                              saison['image'],
                              width: 50,
                              height: 50,
                              fit: BoxFit.cover,
                              errorBuilder: (context, error, stackTrace) {
                                return const Icon(
                                  Icons.broken_image,
                                  size: 50,
                                );
                              },
                            ),
                          ),
                          title: Text(saison['titre']),
                          subtitle: Text('Numéro: ${saison['numero']}'),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) => AlertDialog(
                                title: Text(saison['titre']),
                                content: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    Image.network(
                                      saison['image'],
                                      width: 100,
                                      height: 100,
                                      fit: BoxFit.cover,
                                      errorBuilder: (context, error, stackTrace) {
                                        return const Icon(
                                          Icons.broken_image,
                                          size: 100,
                                        );
                                      },
                                    ),
                                    const SizedBox(height: 16),
                                    Text(
                                      'Slug: ${saison['slug']}\n'
                                      'ID: ${saison['id']}\n'
                                      'Nombre d\'épisodes: ${saison['episodes'].length}',
                                    ),
                                  ],
                                ),
                                actions: [
                                  TextButton(
                                    onPressed: () => Navigator.pop(context),
                                    child: const Text('Fermer'),
                                  ),
                                ],
                              ),
                            );
                          },
                        ),
                      )
                      .toList(),
                ),
                const SizedBox(height: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Actualités',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    ...actualites
                        .map((actu) => Text('• $actu',
                            style: const TextStyle(fontSize: 16)))
                        .toList(),
                  ],
                ),
              ],
            ),
          );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Wiki des Simpsons'),
      ),
      body: _selectedIndex == 0 ? _buildHomeContent() : _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        backgroundColor: Colors.yellow[700],
        selectedItemColor: Colors.brown[700],
        unselectedItemColor: Colors.brown[300],
        onTap: (index) => setState(() {
          _selectedIndex = index;
        }),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Accueil',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Personnages',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.movie),
            label: 'Épisodes',
          ),
        ],
      ),
    );
  }
}
