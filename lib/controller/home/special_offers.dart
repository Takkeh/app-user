import 'package:get/get.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/network/home/spcial_offers.dart';

class SpecialOffersController extends GetxController {
  static SpecialOffersController get find => Get.find();

  OffersModel? specialOffersModel;
  late Future<OffersModel?> initializeSpecialOffersFuture;

  Future<OffersModel?> fetchSpecialOffersData() async {
    specialOffersModel = await SpecialOffersApi.data();
    return specialOffersModel;
  }

  @override
  void onInit() {
    super.onInit();
    initializeSpecialOffersFuture = fetchSpecialOffersData();
  }
}
