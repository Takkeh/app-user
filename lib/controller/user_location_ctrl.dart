import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/ui/widgets/custom_button.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class UserLocationCtrl extends GetxController {
  static UserLocationCtrl get find => Get.find();

  final permission = Rxn<LocationPermission>();

  final grantedPermissions = [
    LocationPermission.always,
    LocationPermission.whileInUse,
  ];

  final deniedPermissions = [
    LocationPermission.denied,
    LocationPermission.deniedForever,
    LocationPermission.unableToDetermine,
  ];

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final subLocality = ''.obs;
  final street = ''.obs;
  final locality = ''.obs;

  //TODO: delete
  final savedAddresses = [
    'home',
    'work',
  ].obs;

  Future<LocationPermission> getPermission() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();

    if (!serviceEnabled) {
      permission.value = LocationPermission.unableToDetermine;
      return permission.value!;
    }

    permission.value = await Geolocator.checkPermission();

    if (permission.value == LocationPermission.denied) {
      permission.value = await Geolocator.requestPermission();
    }

    if (permission.value == LocationPermission.denied) {
      permission.value = LocationPermission.denied;
      return permission.value!;
    }

    if (permission.value == LocationPermission.deniedForever) {
      permission.value = LocationPermission.deniedForever;
      return permission.value!;
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    getLocation(position.latitude, position.longitude);
    await getAddress(position.latitude, position.longitude);
    if (MyAddressesCtrl.find.myAddresses.isEmpty && MySharedPreferences.accessToken.isNotEmpty) {
      await MyAddressesCtrl.find.fetchData();
    }
    return permission.value!;
  }

  void getLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
    log("location:: lat: ${latitude.value}  lng: ${longitude.value}");
    update();
  }

  Future getAddress(double lat, double lng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng, localeIdentifier: MySharedPreferences.language);
    locality.value = placeMarks[0].locality!;
    subLocality.value = placeMarks[0].subLocality!;
    street.value = placeMarks[0].street!;
    log("address:: ${subLocality.value} -- ${street.value}");
    update();
  }

  Future<bool> checkPermission(BuildContext context) async {
    OverLayLoader.flickrLoading(context);
    await getPermission();
    var isDenied = permission.value == LocationPermission.denied || permission.value == LocationPermission.deniedForever || permission.value == LocationPermission.unableToDetermine;
    if (isDenied) {
      Get.defaultDialog(
        title: TranslationService.getString('location_permission_title_key'),
        contentPadding: const EdgeInsets.all(16.0),
        titlePadding: const EdgeInsets.all(16.0),
        content: Column(
          children: [
            Text(
              TranslationService.getString('location_permission_body_key'),
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: TranslationService.getString('ask_for_permission_key'),
              onPressed: () async {
                Get.back();
                OverLayLoader.flickrLoading(context);
                await getPermission().then((value) {
                  log("value:: $value");
                  if (value == LocationPermission.unableToDetermine) {
                    Fluttertoast.showToast(msg: TranslationService.getString('device_location_service_disabled_key'));
                  }
                  if (value == LocationPermission.deniedForever) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: MyColors.primary,
                        content: Text(TranslationService.getString('permission_denied_edit_setting_key')),
                        action: SnackBarAction(
                          label: TranslationService.getString('edit_key'),
                          onPressed: () {
                            Geolocator.openLocationSettings();
                          },
                        ),
                      ),
                    );
                  }
                  Loader.hide();
                });
              },
            ),
          ],
        ),
      );
      Loader.hide();
      return Future.value(false);
    } else {
      Loader.hide();
      return Future.value(true);
    }
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
