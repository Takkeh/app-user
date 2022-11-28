import 'dart:io';
import 'package:get/get.dart';
import 'package:takkeh/model/profile/update_profile_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:takkeh/network/profile/update_profile.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ChangeInfoCtrl extends GetxController {
  static ChangeInfoCtrl get find => Get.find();

  UpdateProfileModel? updateProfileModel;
  Future fetchUpdateProfileData({
    required String email,
    required String name,
    required File? image,
    required BuildContext context,
  }) async {
    OverLayLoader.showLoading(context);
    updateProfileModel = await UpdateProfileApi.dataWithImage(
      name: name,
      email: email,
      image: image,
    );
    if (updateProfileModel == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (updateProfileModel!.code == 200) {
      MySharedPreferences.name = updateProfileModel!.user!.name!;
      MySharedPreferences.image = updateProfileModel!.user!.image!;
      Get.back();
      Fluttertoast.showToast(msg: 'Profile Updated successfully');
    } else {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
    }
    Loader.hide();
  }
}
