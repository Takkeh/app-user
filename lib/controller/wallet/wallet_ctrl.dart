import 'package:takkeh/model/wallet/wallet_view_model.dart';
import 'package:takkeh/network/wallet/wallet.dart';
import 'package:get/get.dart';

class WalletCtrl extends GetxController {
  static WalletCtrl get find => Get.find();

  WalletViewModel? walletViewModel;
  late Future<WalletViewModel?> initialize;
  RxInt walletId = 0.obs;

  Future<WalletViewModel?> fetchData() async {
    walletViewModel = await WalletApi.data();
    return walletViewModel;
  }

  @override
  void onInit() {
    initialize = fetchData().then(
      (walletModel) {
        if (walletModel!.myWallet != null) {
          walletId.value = walletModel.myWallet!.id!;
          update();
        }
        return walletModel;
      },
    );
    super.onInit();
  }
}
