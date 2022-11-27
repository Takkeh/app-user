import 'package:get/get.dart';
import 'package:takkeh/model/help/faq_list_model.dart';
import 'package:takkeh/network/help/faqs.dart';

class FaqCtrl extends GetxController{
  static FaqCtrl get find => Get.find();

  FaqModel? faqModel;
  late Future<FaqModel?> initialize;

  Future<FaqModel?> fetchData() async {
    faqModel = await FAQsApi.data();
    return faqModel;
  }

  @override
  void onInit() {
    initialize = fetchData();
    super.onInit();
  }
}