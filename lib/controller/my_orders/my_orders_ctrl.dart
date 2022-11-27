import 'package:get/get.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:takkeh/model/my_orders/my_orders_model.dart';
import 'package:takkeh/network/my_orders/my_orders.dart';

class MyOrdersCtrl extends GetxController {
  static MyOrdersCtrl get find => Get.find();

  late PagingController<int, OrdersList> pagingController;

  Future<void> fetchPage(int pageKey) async {
    try {
      final model = await MyOrdersApi.data(pageKey: pageKey);
      final newItems = model!.data;
      if (newItems!.isEmpty) {
        pagingController.appendLastPage(newItems);
      } else {
        pagingController.appendPage(newItems, pageKey + 1);
      }
    } catch (e) {
      pagingController.error = e;
    }
  }

  @override
  void onInit() {
    pagingController = PagingController(firstPageKey: 1)
      ..addPageRequestListener((pageKey) {
        fetchPage(pageKey);
      });
    super.onInit();
  }
}
