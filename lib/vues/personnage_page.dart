import 'package:flutter/material.dart';
import 'package:simpson_app/widgets/personnage_cards.dart';
import '../controllers/personnage_controller.dart';
import '../widgets/personnage_cards.dart';

class PersonnagePage extends StatelessWidget {
  final personnageController = PersonnageController();

  @override
  Widget build(BuildContext context) {
    final personnages = personnageController.getPersonnages();

    return Scaffold(
      appBar: AppBar(title: Text("Personnages")),
      body: ListView.builder(
        itemCount: personnages.length,
        itemBuilder: (context, index) {
          return PersonnageCard(personnage: personnages[index]);
        },
      ),
    );
  }
}
