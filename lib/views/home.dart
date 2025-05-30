import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, String>> protagonistes = [
    {
      'nom': 'Homer Simpson',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/0/02/Homer_Simpson_2006.png',
    },
    {
      'nom': 'Marge Simpson',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/0/0b/Marge_Simpson.png',
    },
    {
      'nom': 'Bart Simpson',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/a/aa/Bart_Simpson_200px.png',
    },
    {
      'nom': 'Lisa Simpson',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/e/ec/Lisa_Simpson.png',
    },
    {
      'nom': 'Maggie Simpson',
      'image':
          'https://upload.wikimedia.org/wikipedia/en/9/9d/Maggie_Simpson.png',
    },
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
          saisons =
              jsonData.map((item) => item as Map<String, dynamic>).toList();
        });
      } else {
        throw Exception('Erreur lors de la récupération des données');
      }
    } catch (e) {
      print('Erreur : $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: saisons.isEmpty
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Section de présentation
                    const Text(
                      'Les Simpsons',
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      'Les Simpsons est une série télévisée d\'animation américaine créée par Matt Groening et diffusée depuis le 17 décembre 1989 sur le réseau Fox. Elle met en scène les Simpson, stéréotype d\'une famille de classe moyenne américaine.',
                      style: TextStyle(fontSize: 16),
                    ),
                    const SizedBox(height: 16),

                    // Section des protagonistes
                    const Text(
                      'Protagonistes',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: protagonistes.map((protagoniste) {
                          return Container(
                            width: 100,
                            margin: const EdgeInsets.symmetric(horizontal: 8),
                            child: Column(
                              children: [
                                ClipOval(
                                  child: Image.network(
                                    protagoniste['image'] ?? '',
                                    width: 80,
                                    height: 80,
                                    fit: BoxFit.cover,
                                    loadingBuilder:
                                        (context, child, loadingProgress) {
                                      if (loadingProgress == null) return child;
                                      return const SizedBox(
                                        width: 80,
                                        height: 80,
                                        child: Center(
                                          child: CircularProgressIndicator(
                                            strokeWidth: 2,
                                          ),
                                        ),
                                      );
                                    },
                                    errorBuilder: (context, error, stackTrace) {
                                      return const Icon(
                                        Icons.broken_image,
                                        size: 80,
                                      );
                                    },
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(
                                  protagoniste['nom'] ?? '',
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(fontSize: 12),
                                  maxLines: 2,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Section des saisons
                    const Text(
                      'Saisons',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: saisons.map((saison) {
                          return GestureDetector(
                            onTap: () {
                              showDialog(
                                context: context,
                                builder: (context) => AlertDialog(
                                  title: Text(saison['titre']),
                                  content: Column(
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      ClipRRect(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        child: Image.network(
                                          saison['image'] ?? '',
                                          width: 100,
                                          height: 100,
                                          fit: BoxFit.cover,
                                          loadingBuilder: (context, child,
                                              loadingProgress) {
                                            if (loadingProgress == null)
                                              return child;
                                            return const SizedBox(
                                              width: 100,
                                              height: 100,
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(
                                                  strokeWidth: 2,
                                                ),
                                              ),
                                            );
                                          },
                                        ),
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
                            child: Container(
                              width: 140,
                              margin: const EdgeInsets.symmetric(horizontal: 8),
                              child: Column(
                                children: [
                                  ClipRRect(
                                      borderRadius: BorderRadius.circular(12.0),
                                      child: Image(
                                        image: AssetImage(
                                          saison['image'] ?? '',
                                        ),
                                        height: 100,
                                        fit: BoxFit.cover,
                                        loadingBuilder:
                                            (context, child, loadingProgress) {
                                          if (loadingProgress == null)
                                            return child;
                                          return const SizedBox(
                                            width: 100,
                                            height: 100,
                                            child: Center(
                                              child: CircularProgressIndicator(
                                                strokeWidth: 2,
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                                  const SizedBox(height: 8),
                                  Text(
                                    saison['titre'] ?? '',
                                    textAlign: TextAlign.center,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  Text(
                                    'Saison ${saison['numero']}',
                                    style: const TextStyle(color: Colors.grey),
                                  ),
                                ],
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                    const SizedBox(height: 16),

                    // Section des actualités
                    const Text(
                      'Actualités',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    const SizedBox(height: 8),
                    Column(
                      children: actualites.map((actualite) {
                        return ListTile(
                          leading: const Icon(Icons.article),
                          title: Text(actualite),
                        );
                      }).toList(),
                    ),
                  ],
                ),
              ),
            ),
    );
  }
}
