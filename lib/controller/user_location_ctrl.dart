import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/custom_button.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class UserLocationCtrl extends GetxController {
  static UserLocationCtrl get find => Get.find();

  late LocationPermission permission;

  final latitude = Rxn<double>();
  final longitude = Rxn<double>();

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
      permission = LocationPermission.unableToDetermine;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      return permission;
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.bestForNavigation);
    getLocation(position.latitude, position.longitude);
    getAddress(position.latitude, position.longitude);

    return permission;
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

  Future<bool> checkPermission(BuildContext context) {
    var isDenied = permission == LocationPermission.denied || permission == LocationPermission.deniedForever || permission == LocationPermission.unableToDetermine;
    if (isDenied) {
      Get.defaultDialog(
        title: "Location Permission".tr,
        contentPadding: const EdgeInsets.all(16.0),
        titlePadding: const EdgeInsets.all(16.0),
        content: Column(
          children: [
            Text(
              "allow location permission to be able to use our service".tr,
            ),
            const SizedBox(height: 20),
            CustomButton(
              title: "Ask for permission".tr,
              onPressed: () async {
                Get.back();
                await getPermission().then((value) {
                  if (value == LocationPermission.unableToDetermine) {
                    Fluttertoast.showToast(msg: "Device location services are not enabled".tr);
                  }
                  if (value == LocationPermission.deniedForever) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: MyColors.primary,
                        content: Text("Permission is denied. to enable it, edit your device settings".tr),
                        action: SnackBarAction(
                          label: "Edit".tr,
                          onPressed: () {
                            Geolocator.openLocationSettings();
                          },
                        ),
                      ),
                    );
                  }
                });
              },
            ),
          ],
        ),
      );
      return Future.value(false);
    } else {
      return Future.value(true);
    }
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
