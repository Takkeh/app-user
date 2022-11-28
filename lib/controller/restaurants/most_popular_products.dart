import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/network/restaurants/most_popular.dart';

class MostPopularProductsCtrl extends GetxController {
  final int restaurantId;

  MostPopularProductsCtrl({required this.restaurantId});

  static MostPopularProductsCtrl get find => Get.find();

  MostPopularProductsModel? model;
  late Future<MostPopularProductsModel?> initialize;

  Future<MostPopularProductsModel?> fetchData(int restaurantId) async {
    model = await MostPopularApi.data(restaurantId);
    return model;
  }

  @override
  void onInit() {
    initialize = fetchData(restaurantId);
    super.onInit();
  }
}
