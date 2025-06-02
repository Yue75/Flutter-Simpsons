import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:simpsons/views/saison/saison.dart';

import '../../components/saison-card.dart';
import '../../models/saison.model.dart';

class Saisons extends StatefulWidget {
  const Saisons({super.key});

  @override
  State<Saisons> createState() => _SaisonsState();
}

class _SaisonsState extends State<Saisons> {
  List<Season> _seasons = [];
  bool _isLoading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _fetchSeasons();
  }

  Future<void> _fetchSeasons() async {
    try {
      final response =
          await http.get(Uri.parse('http://10.0.2.2:3030:3030/saisons'));

      if (response.statusCode == 200) {
        final List<dynamic> data = json.decode(response.body);
        setState(() {
          _seasons = data.map((json) => Season.fromJson(json)).toList();
          _isLoading = false;
        });
      } else {
        setState(() {
          _error = 'Erreur lors du chargement des saisons';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _error = 'Erreur de connexion au serveur';
        _isLoading = false;
      });
    }
  }

  void _navigateToSeasonDetail(Season season) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => Saison(season: season),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Saisons',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: const Color(0xFFFFD521), // Jaune Simpson
        elevation: 0,
        centerTitle: true,
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    if (_isLoading) {
      return const Center(child: CircularProgressIndicator());
    }

    if (_error != null) {
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(_error!, style: const TextStyle(color: Colors.red)),
            const SizedBox(height: 16),
            ElevatedButton(
              onPressed: _fetchSeasons,
              child: const Text('Réessayer'),
            ),
          ],
        ),
      );
    }

    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: _seasons.length,
      itemBuilder: (context, index) {
        final season = _seasons[index];
        return SaisonCard(
          season: season,
          onTap: () => _navigateToSeasonDetail(season),
        );
      },
    );
  }
}
