import 'package:segundo_muelle/app/data/models/plate_model.dart';
import 'package:segundo_muelle/app/data/providers/plate_provider.dart';

class PlateRepository {
  final PlateProvider _plateProvider = PlateProvider();

  List<PlateModel> getPlates() {
    return _plateProvider.getPlates();
  }
}
