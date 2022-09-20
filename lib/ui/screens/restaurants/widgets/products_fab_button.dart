import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsFABButton extends StatelessWidget {
  final int restaurantId;

  const ProductsFABButton({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20.0),
      child: ElevatedButton(
        onPressed: () {
          print("details:: ${UserOrderCtrl.find.userOrder} -- ${jsonEncode(UserOrderCtrl.find.userOrder)}");
          UserOrderCtrl.find.fetchMakeOrderData(
            context: context,
            restaurantId: restaurantId,
          );
        },
        style: ElevatedButton.styleFrom(
          primary: MyColors.redF98,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(11)),
          fixedSize: const Size(double.infinity, 50),
          minimumSize: const Size(double.infinity, 50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              height: 35,
              width: 35,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: MyColors.redPrimary,
                borderRadius: BorderRadius.circular(11),
              ),
              child: GetBuilder<UserOrderCtrl>(
                builder: (controller) {
                  return Text(
                    controller.userOrder.length.toString(),
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ),
            Text(
              TranslationService.getString('review_basket_key'),
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
            GetBuilder<UserOrderCtrl>(builder: (controller) {
              return Text(
                "${controller.total.value} $kPCurrency",
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
