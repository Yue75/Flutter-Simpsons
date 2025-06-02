import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AdminPage extends StatefulWidget {
  @override
  _AdminPageState createState() => _AdminPageState();
}

class _AdminPageState extends State<AdminPage> {
  final TextEditingController _saisonController = TextEditingController();
  final TextEditingController _episodeTitreController = TextEditingController();
  final TextEditingController _episodeNumeroController = TextEditingController();
  final TextEditingController _userEmailController = TextEditingController();
  final TextEditingController _userPasswordController = TextEditingController();

  List<String> saisons = [];
  String? selectedSaison;

  final String backendUrl = 'http://<TON_BACKEND_URL>'; // ← Remplace par ton URL backend

  Future<void> _ajouterSaison() async {
    final saison = _saisonController.text.trim();
    if (saison.isEmpty) return;

    final response = await http.post(
      Uri.parse('$backendUrl/api/saisons'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({'nom': saison}),
    );

    if (response.statusCode == 201) {
      setState(() {
        saisons.add(saison);
        _saisonController.clear();
      });
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Saison '$saison' ajoutée.")));
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Erreur: ${response.body}")));
    }
  }

  Future<void> _ajouterEpisode() async {
    if (selectedSaison == null) return;

    final titre = _episodeTitreController.text.trim();
    final numero = _episodeNumeroController.text.trim();

    if (titre.isEmpty || numero.isEmpty) return;

    final response = await http.post(
      Uri.parse('$backendUrl/api/episodes'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode({
        'titre': titre,
        'numero': int.parse(numero),
        'saison': selectedSaison,
      }),
    );

    if (response.statusCode == 201) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Épisode '$titre' ajouté à $selectedSaison.")),
      );
      _episodeTitreController.clear();
      _episodeNumeroController.clear();
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur: ${response.body}")),
      );
    }
  }

  Future<void> _creerUtilisateur() async {
    final email = _userEmailController.text.trim();
    final password = _userPasswordController.text;

    if (email.isEmpty || password.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Email et mot de passe sont obligatoires")),
      );
      return;
    }

    try {
      final response = await http.post(
        Uri.parse('$backendUrl/api/users'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'email': email,
          'password': password,
        }),
      );

      print('Status code: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 201) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Utilisateur créé.")),
        );
        _userEmailController.clear();
        _userPasswordController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erreur: ${response.body}")),
        );
      }
    } catch (e) {
      print('Erreur lors de la requête: $e');
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erreur réseau ou serveur")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Admin Panel')),
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: ListView(
          children: [
            Text('Ajouter une Saison', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _saisonController,
              decoration: InputDecoration(labelText: 'Nom de la saison'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _ajouterSaison,
              child: Text('Ajouter Saison'),
            ),
            Divider(height: 32),

            Text('Ajouter un Épisode', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            DropdownButton<String>(
              hint: Text('Choisir une saison'),
              value: selectedSaison,
              items: saisons.map((saison) {
                return DropdownMenuItem(value: saison, child: Text(saison));
              }).toList(),
              onChanged: (value) => setState(() => selectedSaison = value),
            ),
            TextField(
              controller: _episodeTitreController,
              decoration: InputDecoration(labelText: 'Titre de l\'épisode'),
            ),
            TextField(
              controller: _episodeNumeroController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(labelText: 'Numéro de l\'épisode'),
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _ajouterEpisode,
              child: Text('Ajouter Épisode'),
            ),
            Divider(height: 32),

            Text('Créer un Utilisateur', style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
            TextField(
              controller: _userEmailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _userPasswordController,
              decoration: InputDecoration(labelText: 'Mot de passe'),
              obscureText: true,
            ),
            SizedBox(height: 8),
            ElevatedButton(
              onPressed: _creerUtilisateur,
              child: Text('Créer Utilisateur'),
            ),
          ],
        ),
      ),
    );
  }
}
