import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/restaurants/products.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/restaurants_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/view_restaurant.dart';

class NewBasketDialog {
  static Future<void> show(
    BuildContext context, {
    required RestaurantList data,
  }) async {
    return showDialog<void>(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(TranslationService.getString('start_new_basket_key')),
          content: Text(TranslationService.getString('new_order_will_clear_basket_key')),
          actions: <Widget>[
            TextButton(
              child: Text(TranslationService.getString('cancel_key')),
              onPressed: () {
                Get.back();
              },
            ),
            ElevatedButton(
              child: Text(TranslationService.getString('start_key')),
              onPressed: () {
                Get.delete<UserOrderCtrl>(force: true);
                Get.put(UserOrderCtrl(), permanent: true);
                UserOrderCtrl.find.restaurantId = data.id!;
                Get.back();
                Get.to(
                  () => ViewRestaurantScreen(
                    title: data.name!,
                    cover: data.cover!,
                    restaurantId: data.id!,
                    logo: data.logo!,
                    time: data.time!,
                    cost: data.cost!,
                    review: data.review!,
                    reviewIcon: data.reviewIcon!,
                  ),
                  binding: ProductBinding(id: data.id!),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
