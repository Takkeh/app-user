import 'package:get/get.dart';
import 'package:takkeh/model/home/slider_model.dart';
import 'package:takkeh/network/home/slider.dart';

class SliderController extends GetxController {
  static SliderController get find => Get.find();

  SliderModel? sliderModel;
  late Future<SliderModel?> initializeSliderFuture;

  Future<SliderModel?> fetchSliderData() async {
    sliderModel = await SliderApi.data();
    return sliderModel;
  }

  @override
  void onInit() {
    super.onInit();
    initializeSliderFuture = fetchSliderData();
  }
}
