import 'package:flutter/material.dart';

import '../controllers/personnage_controller.dart';
import '../models/personnage.dart';
import '../widgets/personnage_list_item.dart';
import 'personnage_detail_page.dart';

class PersonnagePage extends StatefulWidget {
  const PersonnagePage({super.key});

  @override
  State<PersonnagePage> createState() => _PersonnagePageState();
}

class _PersonnagePageState extends State<PersonnagePage> {
  final personnageController = PersonnageController();
  late Future<List<Personnage>> futurePersonnages;

  @override
  void initState() {
    super.initState();
    futurePersonnages = personnageController.fetchPersonnages();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Personnages"),
        // suppression du bouton dans l'AppBar
      ),
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
              final p = personnages[index];
              return PersonnageListItem(
                personnage: p,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => PersonnageDetailPage(personnage: p),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
