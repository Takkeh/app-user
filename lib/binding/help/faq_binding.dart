import 'package:get/get.dart';
import 'package:takkeh/controller/help/faq_list_ctrl.dart';

class FAQsBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => FaqCtrl());
  }
}
