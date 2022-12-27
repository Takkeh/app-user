import 'dart:async';

import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/network/restaurants/restaursnts_search.dart';

class RestaurantsSearchCtrl extends GetxController {
  static RestaurantsSearchCtrl get find => Get.find();

  final model = Rxn<RestaurantsModel>();
  final searchQuery = "".obs;
  Timer? _debounce;

  late PagingController<int, RestaurantList> pagingController;

  Future<void> fetchPage(int pageKey, String query) async {
    try {
      final model = await RestaurantsSearchApi.data(query: query, pageKey: pageKey);
      final newItems = model!.data;
      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (error) {
      pagingController.error = error;
    }
  }

  void onSearchChanged(String query) {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 300), () {
      if (query.isNotEmpty) {
        searchQuery.value = query;
        pagingController.refresh();
      } else {
        searchQuery.value = "";
      }
    });
  }

  Future fetchSearch({
    required String query,
    required int pageKey,
  }) async {
    model.value = await RestaurantsSearchApi.data(query: query, pageKey: pageKey);
    if (model.value != null) {
      if (model.value!.code == 200) {
      } else {
        Fluttertoast.showToast(msg: 'حدث خطأ ما, الرجاء المحاولة لاحقا');
      }
    } else {
      Fluttertoast.showToast(msg: 'حدث خطأ ما, الرجاء المحاولة لاحقا');
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey, searchQuery.value);
      });
    super.onInit();
  }

  @override
  void onClose() {
    pagingController.dispose();
    super.onClose();
  }
}
