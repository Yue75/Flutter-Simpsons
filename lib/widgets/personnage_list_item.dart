import 'package:flutter/material.dart';
import '../models/personnage.dart';

class PersonnageListItem extends StatelessWidget {
  final Personnage personnage;
  final VoidCallback onTap;

  const PersonnageListItem({
    Key? key,
    required this.personnage,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: EdgeInsets.symmetric(vertical: 6, horizontal: 12),
      child: ListTile(
        onTap: onTap,
        leading: ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: Image.network(
            personnage.image.startsWith('http')
                ? personnage.image
                : "http://10.0.2.2:3000${personnage.image}",
            width: 60,
            height: 60,
            fit: BoxFit.cover,
          ),
        ),
        title: Text(personnage.name),
      ),
    );
  }
}
