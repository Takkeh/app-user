import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/create_address_ctrl.dart';

class CreateAddressBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => CreateAddressCtrl());
  }
}
