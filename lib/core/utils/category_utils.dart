import 'package:segundo_muelle/app/data/enums/category_enum.dart';

class CategoryUtils {
  static String getCategoryTypeString(CategoryEnum categoryEnum) {
    switch (categoryEnum) {
      case CategoryEnum.starterDish:
        return "Entrada";
      case CategoryEnum.fish:
        return "Pescados";
      case CategoryEnum.soups:
        return "Sopas";
      case CategoryEnum.drinks:
        return "Bebidas";
      case CategoryEnum.desserts:
        return "Postres";
      default:
        return "";
    }
  }
}
