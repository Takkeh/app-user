import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/model/addresses/create_address_model.dart';
import 'package:takkeh/model/addresses/my_addresses_model.dart';
import 'package:takkeh/network/addresses/create_address_api.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class CreateAddressCtrl extends GetxController {
  static CreateAddressCtrl get find => Get.find();

  CreateAddressModel? model;

  Future fetchData({
    required String phone,
    required String name,
    required String region,
    required String street,
    required String buildingNum,
    required String additionalTips,
    required String floor,
    required String apartmentNum,
    required String city,
    required BuildContext context,
  }) async {
    OverLayLoader.flickrLoading(context);
    model = await CreateAddressApi().data(
      phone: phone,
      name: name,
      region: region,
      street: street,
      buildingNum: buildingNum,
      additionalTips: additionalTips,
      floor: floor,
      apartmentNum: apartmentNum,
      city: city,
      lat: MapController.find.mapLat!,
      lng: MapController.find.mapLng!,
    );
    if (model == null) {
      Fluttertoast.showToast(msg: AppConstants.failedMessage);
      Loader.hide();
      return;
    }
    if (model!.code == 200) {
      MyAddressesCtrl.find.addAddress(
        MyAddresses(
          region: region,
          street: street,
          userId: MySharedPreferences.userId,
          long: MapController.find.mapLng!,
          lat: MapController.find.mapLat!,
          floorNumber: floor,
          city: city,
          buildingNumber: buildingNum,
          apartmentNumber: apartmentNum,
          additionalTips: additionalTips,
          name: name,
          id: model!.data!.id!,
          phone: phone,
        ),
        model!.data!.id!,
      );
      Get.back();
      Fluttertoast.showToast(msg: TranslationService.getString('address_added_successfully_key'));
    } else {
      Fluttertoast.showToast(msg: model!.msg!);
    }
    Loader.hide();
  }
}
