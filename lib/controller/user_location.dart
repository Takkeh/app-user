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

  final latitude = Rxn<double>();
  final longitude = Rxn<double>();
  final subLocality = Rxn<String>();
  final street = Rxn<String>();
  final locality = Rxn<String>();
  late LocationPermission permission;

  final savedAddresses = [
    'home',
    'work',
  ].obs;

  Future<String?> determinePosition() async {
    bool serviceEnabled;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return "No Service";
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return "Denied";
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return "Denied Forever";
    }

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high);

    updateLocation(position.latitude, position.longitude);
    await getAddressDetails(position.latitude, position.longitude);

    log("location:: lat: ${position.latitude}  lng: ${position.longitude}");
    return null;
  }

  void updateLocation(double lat, double lng) {
    latitude.value = lat;
    longitude.value = lng;
    update();
  }

  Future getAddressDetails(double lat, double lng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng, localeIdentifier: MySharedPreferences.language);

    locality.value = placeMarks[1].locality!.isEmpty ? "Unknown" : placeMarks[1].locality;
    subLocality.value = placeMarks[1].subLocality!.isEmpty ? "Unknown" : placeMarks[1].subLocality;
    street.value = placeMarks[1].street!.isEmpty ? "Unknown" : placeMarks[1].street;

    log("placeMarkers:: $placeMarks");
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
                await determinePosition().then((value) {
                  if (value == "No service") {
                    Fluttertoast.showToast(msg: "Device location services are not enabled".tr);
                    return;
                  }
                  if (value == "Denied Forever") {
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
    determinePosition();
    super.onInit();
  }
}
