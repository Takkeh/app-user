import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/most_popular_model.dart';
import 'package:takkeh/network/restaurants/most_popular.dart';

class MostPopularProductsCtrl extends GetxController {
  static MostPopularProductsCtrl get find => Get.find();

  MostPopularProductsModel? model;
  late Future<MostPopularProductsModel?> initialize;

  Future<MostPopularProductsModel?> fetchData() async {
    model = await MostPopularApi.data();
    return model;
  }

  @override
  void onInit() {
    initialize = fetchData();
    super.onInit();
  }
}
