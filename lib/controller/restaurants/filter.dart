import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/restaurants.dart';
import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/network/restaurants/filter.dart';

class RestaurantsFilterController extends GetxController {
  static RestaurantsFilterController get find => Get.find();

  final isFilterActive = false.obs;
  final selectedTagId = 0.obs;

  void toggle() {
    isFilterActive.value = !isFilterActive.value;
    update();
  }

  void changeSelected(int tagId) {
    if (selectedTagId.value == tagId) {
      selectedTagId.value = 0;
    } else {
      selectedTagId.value = tagId;
    }
    RestaurantsCtrl.find.pagingController.refresh();
    update();
  }

  FilterModel? filterModel;
  late Future<FilterModel?> initialize;

  Future<FilterModel?> fetchCategoriesData() async {
    filterModel = await FilterApi.data();
    return filterModel;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchCategoriesData();
  }
}
