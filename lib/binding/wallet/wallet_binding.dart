import 'package:takkeh/controller/wallet/transaction_ctrl.dart';
import 'package:takkeh/controller/wallet/wallet_ctrl.dart';
import 'package:get/get.dart';

class WalletBinding extends Bindings{
  @override
  void dependencies() {
    Get.lazyPut(() => WalletCtrl());
    Get.lazyPut(() => MakeTransactionCtrl());
  }
}