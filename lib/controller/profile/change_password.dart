import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/model/profile/update_password_model.dart';
import 'package:takkeh/network/profile/update_password.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';

class ChangePassCtrl extends GetxController {
  static ChangePassCtrl get find => Get.find();

  final isCurrentPasswordObscure = true.obs;
  final isNewPasswordObscure = true.obs;
  final isConfirmNewPasswordObscure = true.obs;

  void changeCurrentPasswordObscure() {
    isCurrentPasswordObscure.value = !isCurrentPasswordObscure.value;
    update();
  }

  void changeNewPasswordObscure() {
    isNewPasswordObscure.value = !isNewPasswordObscure.value;
    update();
  }

  void changeConfirmNewPasswordObscure() {
    isConfirmNewPasswordObscure.value = !isConfirmNewPasswordObscure.value;
    update();
  }

  UpdatePasswordModel? updatePasswordModel;
  Future updatePassword({
    required String oldPassword,
    required String newPassword,
    required String newPasswordConfirm,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    updatePasswordModel = await UpdatePasswordApi.data(
        oldPassword: oldPassword,
        newPassword: newPassword,
        newPasswordConfirm: newPasswordConfirm);
    if (updatePasswordModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (updatePasswordModel!.code == 200) {
      Fluttertoast.showToast(msg: updatePasswordModel!.msg!);
    } else if (updatePasswordModel!.code == 500) {
      Fluttertoast.showToast(msg: TranslationService.getString('incorrect_password_key'));
    } else {
      Fluttertoast.showToast(msg: updatePasswordModel!.msg!);
    }
    Loader.hide();
  }
}
