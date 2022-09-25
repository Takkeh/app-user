import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/restaurants_search_model.dart';
import 'package:takkeh/network/restaurants/restaursnts_search.dart';

class RestaurantsSearchCtrl extends GetxController {
  static RestaurantsSearchCtrl get to => Get.find();

  final model = Rxn<RestaurantsSearchModel>();
  // RestaurantsSearchModel? model;
  final isLoading = false.obs;
  final searchQuery = "".obs;
  Timer? _debounce;

  void toggleLoading({required bool status}) {
    isLoading.value = status;
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 500), () {
      if (query.isNotEmpty) {
        searchQuery.value = query;
        fetchSearch(query: query);
      } else {
        searchQuery.value = "";
      }
    });
  }

  Future fetchSearch({required String query}) async {
    toggleLoading(status: true);
    model.value = await RestaurantsSearchApi.data(query: query);
    if (model.value != null) {
      if (model.value!.code == 200) {
        toggleLoading(status: false);
      } else {
        toggleLoading(status: false);
        Fluttertoast.showToast(msg: 'حدث خطأ ما, الرجاء المحاولة لاحقا');
      }
    } else {
      toggleLoading(status: false);
      Fluttertoast.showToast(msg: 'حدث خطأ ما, الرجاء المحاولة لاحقا');
    }
  }
}
