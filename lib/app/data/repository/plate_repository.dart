import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/providers/plate_provider.dart';

class PlateRepository {
  final PlateProvider _plateProvider = PlateProvider();

  Future<String> registerPlate(PlateModel plate) async {
    return _plateProvider.registerPlate(plate);
  }

  Future<void> updatePlate(String key, PlateModel plate) async {
    await _plateProvider.updatePlate(key, plate);
  }

  void deletePlate(String key) async {
    _plateProvider.deletePlate(key);
  }

  List<PlateModel> getPlates() {
    return _plateProvider.getPlates();
  }
}
