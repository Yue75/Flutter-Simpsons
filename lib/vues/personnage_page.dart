import 'package:flutter/material.dart';
import 'package:simpson_app/widgets/personnage_cards.dart';
import '../controllers/personnage_controller.dart';
import '../widgets/personnage_cards.dart';
import '../models/personnage.dart';

class PersonnagePage extends StatefulWidget {
  @override
  State<PersonnagePage> createState() => _PersonnagePageState();
}

class _PersonnagePageState extends State<PersonnagePage> {
  final personnageController = PersonnageController();
  late Future<List<Personnage>> futurePersonnages;

  @override
  void initState() {
    super.initState();
    futurePersonnages = personnageController.fetchPersonnagesFromMongo();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Personnages")),
      body: FutureBuilder<List<Personnage>>(
        future: futurePersonnages,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }
          if (snapshot.hasError) {
            return Center(child: Text("Erreur : ${snapshot.error}"));
          }

          final personnages = snapshot.data!;
          return ListView.builder(
            itemCount: personnages.length,
            itemBuilder: (context, index) {
              return PersonnageCard(personnage: personnages[index]);
            },
          );
        },
      ),
    );
  }
}

