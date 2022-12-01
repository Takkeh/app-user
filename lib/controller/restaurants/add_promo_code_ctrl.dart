import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
import 'package:takkeh/model/restaurants/add_promo_code_model.dart';
import 'package:takkeh/network/restaurants/add_promo_code_api.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class AddPromoCodeCtrl extends GetxController {
  static AddPromoCodeCtrl get find => Get.find();

  AddPromoCodeModel? addPromoCodeModel;

  Future fetchData(int orderId, int promoId, BuildContext context) async {
    Loader.show(
      context,
      progressIndicator: Center(
        child: LoadingAnimationWidget.flickr(
          leftDotColor: MyColors.text,
          rightDotColor: MyColors.redPrimary,
          size: 50,
        ),
      ),
    );
    addPromoCodeModel = await AddPromoCodeApi().data(orderId: orderId, promoId: promoId);
    if (addPromoCodeModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (addPromoCodeModel!.code == 200) {
      Fluttertoast.showToast(msg: TranslationService.getString('promo_added_successfully_key'));
    } else if (addPromoCodeModel!.code == 500) {
      Fluttertoast.showToast(msg: addPromoCodeModel!.msg!);
    }
    Loader.hide();
  }
}
