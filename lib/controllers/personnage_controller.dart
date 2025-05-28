import '../models/personnage.dart';
import '../services/mongo_service.dart';

class PersonnageController {
  Future<List<Personnage>> fetchPersonnagesFromMongo() async {
    await MongoService.connect();
    final personnages = await MongoService.getAllPersonnages();
    await MongoService.close();
    return personnages;
  }
}
