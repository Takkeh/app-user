import 'dart:developer';

import 'package:get/get.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/model/addresses/my_addresses_model.dart';
import 'package:takkeh/network/addresses/my_addresses_api.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class MyAddressesCtrl extends GetxController {
  static MyAddressesCtrl get find => Get.find();

  final myAddresses = <MyAddresses>[].obs;
  final selectedAddressId = 0.obs;
  final selectedLat = 0.0.obs;
  final selectedLng = 0.0.obs;
  final subLocality = ''.obs;
  final street = ''.obs;
  final locality = ''.obs;

  MyAddressesModel? model;

  void selectAddress(int id) {
    selectedAddressId.value = id;
    MySharedPreferences.addressId = id;
    update();
  }

  void addAddress(MyAddresses newAddress, int addressId) {
    myAddresses.insert(0, newAddress);
    selectedAddressId.value = addressId;
    MySharedPreferences.addressId = addressId;
    update();
  }

  Future<MyAddressesModel?> fetchData() async {
    model = await MyAddressesApi().data();
    if (model!.code == 200) {
      myAddresses.value = model!.myAddresses!;
      if (model!.myAddresses!.isNotEmpty) {
        late MyAddresses data;
        var isExist = model!.myAddresses!.where((element) => element.id == MySharedPreferences.addressId).isNotEmpty;
        log("isExist:: $isExist");
        if (isExist) {
          data = model!.myAddresses!.where((element) => element.id == MySharedPreferences.addressId).first;
        } else {
          data = model!.myAddresses![0];
        }
        selectedAddressId.value = data.id!;
        selectedLat.value = data.lat!;
        selectedLng.value = data.long!;
        locality.value = data.city!;
        subLocality.value = data.region!;
        street.value = data.street!;
      } else {
        selectedLat.value = UserLocationCtrl.find.latitude.value;
        selectedLng.value = UserLocationCtrl.find.longitude.value;
        locality.value = UserLocationCtrl.find.locality.value;
        subLocality.value = UserLocationCtrl.find.subLocality.value;
        street.value = UserLocationCtrl.find.street.value;
      }
      update();
    }
    return model;
  }
}
