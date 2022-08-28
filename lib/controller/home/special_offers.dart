import 'package:get/get.dart';
import 'package:takkeh/model/home/special_offers_model.dart';
import 'package:takkeh/network/home/spcial_offers.dart';

class SpecialOffersController extends GetxController {
  static SpecialOffersController get find => Get.find();

  SpecialOffersModel? specialOffersModel;
  late Future<SpecialOffersModel?> initializeSpecialOffersFuture;

  Future<SpecialOffersModel?> fetchSpecialOffersData() async {
    specialOffersModel = await SpecialOffersApi.data();
    return specialOffersModel;
  }

  @override
  void onInit() {
    super.onInit();
    initializeSpecialOffersFuture = fetchSpecialOffersData();
  }
}
