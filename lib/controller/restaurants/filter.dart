import 'package:takkeh/model/restaurants/filter_model.dart';
import 'package:takkeh/network/restaurants/filter.dart';

class FilterController {
  static FilterModel? filterModel;
  static late Future<FilterModel?> filterData;

  static Future<FilterModel?> fetchCategoriesData() async {
    filterModel = await FilterApi.data();
    return filterModel;
  }
}
