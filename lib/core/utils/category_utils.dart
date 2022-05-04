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

  static String getCategoryImagePath(CategoryEnum categoryEnum) {
    switch (categoryEnum) {
      case CategoryEnum.starterDish:
        return "lib/app/assets/entrada.png";
      case CategoryEnum.fish:
        return "lib/app/assets/pescados.png";
      case CategoryEnum.soups:
        return "lib/app/assets/sopas.png";
      case CategoryEnum.drinks:
        return "lib/app/assets/bebidas.png";
      case CategoryEnum.desserts:
        return "lib/app/assets/postres.png";
      default:
        return "";
    }
  }
}
