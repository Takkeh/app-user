import 'package:takkeh/model/home/categories_model.dart';
import 'package:takkeh/network/home/categories.dart';

class CategoriesController {
  static CategoriesModel? categoriesModel;
  static late Future<CategoriesModel?> categoriesData;

  static Future<CategoriesModel?> fetchCategoriesData() async {
    categoriesModel = await CategoriesApi.data();
    return categoriesModel;
  }
}
