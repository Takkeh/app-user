import 'package:get/get.dart';
import 'package:takkeh/model/home/categories_model.dart';
import 'package:takkeh/network/home/categories.dart';

class CategoriesController extends GetxController {
  static CategoriesController get find => Get.find();

  CategoriesModel? categoriesModel;
  late Future<CategoriesModel?> initialize;

  Future<CategoriesModel?> fetchCategoriesData() async {
    categoriesModel = await CategoriesApi.data();
    return categoriesModel;
  }

  @override
  void onInit() {
    initialize = fetchCategoriesData();
    super.onInit();
  }
}
