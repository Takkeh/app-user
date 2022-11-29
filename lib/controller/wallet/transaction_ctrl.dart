import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/network/wallet/transaction.dart';
import 'package:takkeh/controller/wallet/wallet_ctrl.dart';
import 'package:takkeh/model/wallet/transaction_model.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';

class MakeTransactionCtrl extends GetxController {
  static MakeTransactionCtrl get find => Get.find();
  TransactionModel? transactionModel;
  int walletId = WalletCtrl.find.walletId.value;

  Future fetchData({
    required int userId,
    required String type,
    required String amount,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    transactionModel = await MakeTransactionApi.data(
      walletId: walletId,
      userId: userId,
      type: type,
      amount: amount,
    );
    if (transactionModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    } else {
      Fluttertoast.showToast(msg: transactionModel!.msg!);
    }
    Loader.hide();
  }
}
