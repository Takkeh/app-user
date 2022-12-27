import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/network/restaurants/most_popular.dart';

class MostPopularProductsCtrl extends GetxController {
  final int restaurantId;

  MostPopularProductsCtrl({required this.restaurantId});

  static MostPopularProductsCtrl get find => Get.find();

  MostPopularProductsModel? model;
  late Future<MostPopularProductsModel?> initialize;
  final isEmpty = false.obs;

  Future<MostPopularProductsModel?> fetchData(int restaurantId) async {
    model = await MostPopularApi.data(restaurantId);
    if (model == null) {
      isEmpty.value = true;
      return null;
    }
    if (model!.code == 200) {
      if (model!.mostPopular!.mostPopularProducts!.isEmpty) {
        isEmpty.value = true;
      }
    } else {
      isEmpty.value = true;
    }
    return model;
  }

  @override
  void onInit() {
    initialize = fetchData(restaurantId);
    super.onInit();
  }
}
