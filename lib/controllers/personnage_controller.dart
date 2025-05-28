import '../models/personnage.dart';

class PersonnageController {
  List<Personnage> getPersonnages() {
    return [
      Personnage(
        nom: 'Homer Simpson',
        imageUrl: 'https://static.wikia.nocookie.net/simpsons/images/0/02/Homer_Simpson.png',
        statut: 'Vivant',
        genre: 'Masculin',
        occupation: 'Inspecteur de sécurité à la centrale nucléaire',
        aka: 'Homer Jay Simpson',
        cheveux: 'Chauve (2 cheveux)',
        relations: ['Marge Simpson', 'Bart', 'Lisa', 'Maggie'],
      ),
      Personnage(
        nom: 'Marge Simpson',
        imageUrl: 'https://static.wikia.nocookie.net/simpsons/images/0/0b/Marge_Simpson.png',
        statut: 'Vivante',
        genre: 'Féminin',
        occupation: 'Mère au foyer',
        aka: 'Marjorie Bouvier Simpson',
        cheveux: 'Bleus',
        relations: ['Homer', 'Bart', 'Lisa', 'Maggie'],
      ),
      Personnage(
        nom: 'Bart Simpson',
        imageUrl: 'https://static.wikia.nocookie.net/simpsons/images/a/aa/Bart_Simpson.png',
        statut: 'Vivant',
        genre: 'Masculin',
        occupation: 'Écolier',
        aka: 'El Barto',
        cheveux: 'Jaunes',
        relations: ['Homer', 'Marge', 'Lisa', 'Maggie'],
      ),
    ];
  }
}
