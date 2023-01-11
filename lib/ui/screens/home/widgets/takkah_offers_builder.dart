import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/binding/restaurants/view_product.dart';
import 'package:takkeh/controller/home/offers.dart';
import 'package:takkeh/model/home/offers_model.dart';
import 'package:takkeh/model/restaurants/groups_model.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/home/widgets/offers_loading.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant_product.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class TakkehOffersBuilder extends StatelessWidget {
  const TakkehOffersBuilder({Key? key}) : super(key: key);

  void toggleRoute(Offers element) {
    if (element.route == null) return;
    final id = element.restaurant!.id!;
    final title = element.restaurant!.name!;
    final cost = element.restaurant!.cost!;
    final time = element.restaurant!.time!;
    final phone = element.restaurant!.phone!;
    final reviewIcon = element.restaurant!.reviewIcon!;
    final cover = element.restaurant!.cover!;
    final logo = element.restaurant!.logo!;
    final review = element.restaurant!.review!;
    final isBusy = element.restaurant!.isBusy!;
    if (element.route == kRestaurant) {
      if (isBusy == 1) {
        Get.snackbar(
          '',
          titleText: const Text("", style: TextStyle(fontSize: 0)),
          TranslationService.getString('restaurant_busy_key'),
          colorText: Colors.white,
          margin: const EdgeInsets.all(10.0),
          backgroundColor: MyColors.redPrimary,
        );
        return;
      }
      Get.to(
        () => ViewRestaurantScreen(
          restaurantId: id,
          title: title,
          cost: cost,
          time: time,
          reviewIcon: reviewIcon,
          cover: cover,
          logo: logo,
          review: review,
          phone: phone,
        ),
        binding: ProductBinding(id: id),
      );
    } else if (element.route == kRestaurantProduct) {
      final productId = element.product!.id!;
      final title = element.product!.name!;
      final isAvailable = element.product!.isAvailable!;
      final description = element.product!.description!;
      final price = element.product!.price!;
      final groups = element.product!.groups!;
      if (isAvailable == 0) {
        Get.snackbar(
          '',
          titleText: const Text("", style: TextStyle(fontSize: 0)),
          TranslationService.getString('product_not_available_key'),
          colorText: Colors.white,
          margin: const EdgeInsets.all(10.0),
          backgroundColor: MyColors.redPrimary,
        );
        return;
      }
      Get.to(
        () => ViewRestaurantScreen(
          restaurantId: id,
          title: title,
          cost: cost,
          time: time,
          reviewIcon: reviewIcon,
          cover: cover,
          logo: logo,
          review: review,
          phone: '+96298775785',
        ),
        binding: ProductBinding(id: id),
      );
      Get.to(
        () => ViewRestaurantProductScreen(
          restaurantId: 5,
          productId: productId,
          title: title,
          description: description,
          price: price,
          cover: cover,
          groups: groups,
        ),
        binding: ViewProductBinding(),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<OffersModel?>(
      future: OffersController.find.initializeOffersFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const OffersLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return Padding(
                padding: const EdgeInsets.only(top: 15.0, bottom: 50),
                child: CarouselSlider(
                  options: CarouselOptions(
                    height: 370.0,
                    viewportFraction: 0.70,
                    enlargeCenterPage: true,
                  ),
                  items: snapshot.data!.offers!.map((element) {
                    final index = snapshot.data!.offers!.indexOf(element);
                    return Builder(
                      builder: (BuildContext context) {
                        return GestureDetector(
                          onTap: () {
                            toggleRoute(element);
                          },
                          child: CustomNetworkImage(
                            url: snapshot.data!.offers![index].image!,
                            radius: 23,
                            width: Get.width,
                          ),
                        );
                      },
                    );
                  }).toList(),
                ),
              );
            } else if (snapshot.hasError) {
              return const FailedWidget();
            } else {
              return const FailedWidget();
            }
        }
      },
    );
  }
}
