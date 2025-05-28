import 'package:flutter/material.dart';

class Accueil extends StatefulWidget {
  const Accueil({super.key});

  @override
  State<Accueil> createState() => _AccueilState();
}

class _AccueilState extends State<Accueil> {
  final List<String> protagonistes = [
    'Homer',
    'Marge',
    'Bart',
    'Lisa',
    'Maggie',
  ];
  final List<String> saisons = ['Saison 1', 'Saison 2', 'Saison 3'];
  final List<String> actualites = [
    'Nouvel épisode diffusé hier soir !',
    'Les Simpsons fêtent leur 30e anniversaire.',
    'Un documentaire sur les créateurs de la série sort bientôt.',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Wiki des Simpsons')),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Section Intro
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

              // Section Protagonistes
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

              // Section Saisons
              const Text(
                'Saisons',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: saisons
                    .map(
                      (saison) => ListTile(
                        leading: const Icon(Icons.tv),
                        title: Text(saison),
                      ),
                    )
                    .toList(),
              ),
              const SizedBox(height: 16),

              // Section Actualités
              const Text(
                'Actualités',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Column(
                children: actualites
                    .map(
                      (news) => ListTile(
                        leading: const Icon(Icons.article),
                        title: Text(news),
                      ),
                    )
                    .toList(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
