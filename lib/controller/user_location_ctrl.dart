import 'dart:async';
import 'dart:developer';

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class UserLocationCtrl extends GetxController {
  static UserLocationCtrl get find => Get.find();

  final permission = Rxn<LocationPermission>();

  final latitude = 0.0.obs;
  final longitude = 0.0.obs;
  final subLocality = ''.obs;
  final street = ''.obs;
  final locality = ''.obs;

  final deniedPermissions = [
    LocationPermission.denied,
    LocationPermission.deniedForever,
    LocationPermission.unableToDetermine,
  ];

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

    final position = await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.best);
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
    locality.value = placeMarks[1].locality!;
    subLocality.value = placeMarks[1].subLocality!;
    street.value = placeMarks[1].street!;
    log("placeMarks:: $placeMarks");
    log("address:: ${subLocality.value} -- ${street.value}");
    update();
  }

  @override
  void onInit() {
    getPermission();
    super.onInit();
  }
}
