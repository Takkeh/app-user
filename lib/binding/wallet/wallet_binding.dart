import 'package:takkeh/controller/wallet/wallet_ctrl.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WalletCtrl());
  }
}