import 'package:get/get.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/network/home/offers.dart';

class OffersController extends GetxController {
  static OffersController get find => Get.find();

  OffersModel? offersModel;
  late Future<OffersModel?> initializeOffersFuture;

  Future<OffersModel?> fetchOffersData() async {
    offersModel = await OffersApi.data();
    return offersModel;
  }

  @override
  void onInit() {
    super.onInit();
    initializeOffersFuture = fetchOffersData();
  }
}
