import 'package:flutter/material.dart';

import '../components/personnage_card.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Accueil'),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Section de présentation
            Container(
              padding: const EdgeInsets.all(16.0),
              child: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Les Simpsons',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                  SizedBox(height: 16),
                  Text(
                    'Les Simpsons est une série télévisée d\'animation américaine créée par Matt Groening et diffusée depuis le 17 décembre 1989 sur le réseau Fox. Elle met en scène les Simpson, stéréotype d\'une famille de classe moyenne américaine.',
                    style: TextStyle(fontSize: 16),
                  ),
                ],
              ),
            ),

            // Section des personnages principaux
            Container(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Personnages Principaux',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    height: 200,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        // TODO: Remplacer par les données de l'API
                        return Padding(
                          padding: const EdgeInsets.only(right: 16),
                          child: PersonnageCard(
                            id: '1', // À remplacer par l'ID réel du personnage
                            name:
                                'Homer Simpson', // À remplacer par le nom réel
                            imageUrl:
                                'https://placeholder.com/150', // À remplacer par l'URL réelle
                          ),
                        );
                      },
                      itemCount:
                          5, // TODO: Remplacer par le nombre réel de personnages
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
