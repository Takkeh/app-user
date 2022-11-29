import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurant_info_model.dart';
import 'package:takkeh/network/restaurants/restaurant_info.dart';

class RestaurantInfoCtrl extends GetxController {
  static RestaurantInfoCtrl get find => Get.find();

  RestaurantInfoModel? model;

  Future<RestaurantInfoModel?> fetchInfoData({required int restaurantId}
      ) async {
    model = await RestaurantInfoApi.data(id: restaurantId);
    return model;
  }

}

