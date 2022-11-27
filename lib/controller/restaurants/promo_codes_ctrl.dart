import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/promo_codes_model.dart';
import 'package:takkeh/network/restaurants/promo_codes_api.dart';

class PromoCodesCtrl extends GetxController {
  static PromoCodesCtrl get find => Get.find();

  final selectedPromo = Rxn<int>();
  final promoCtrl = TextEditingController().obs;

  void submit(int id, String code) {
    if (selectedPromo.value == id) {
      selectedPromo.value = null;
      promoCtrl.value.clear();
    } else {
      selectedPromo.value = id;
      promoCtrl.value.text = code;
    }
    update();
  }

  PromoCodesModel? model;
  late Future<PromoCodesModel?> initialize;

  Future<PromoCodesModel?> fetchOffersData() async {
    model = await PromoCodesApi().data();
    return model;
  }

  @override
  void onInit() {
    super.onInit();
    initialize = fetchOffersData();
  }
}
