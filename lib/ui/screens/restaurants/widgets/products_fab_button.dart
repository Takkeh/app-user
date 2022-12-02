import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/helper/guest_user_helper.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
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
      child: GetBuilder<UserOrderCtrl>(builder: (controller) {
        return ElevatedButton(
          onPressed: () {
            if (GuestUserHelper.check()) {
              LocationPermissionHelper.check(
                action: () {
                  if (controller.orderList.isEmpty) {
                    Get.closeCurrentSnackbar();
                    Get.snackbar(
                      '',
                      TranslationService.getString('your_basket_is_empty_key'),
                      titleText: const SizedBox.shrink(),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10.0),
                      backgroundColor: MyColors.redPrimary,
                    );
                    return;
                  }
                  MakeOrderCtrl.find.fetchData(
                    context: context,
                    restaurantId: restaurantId,
                    generalNote: '',
                    // route: BasketScreen(
                    //   restaurantId: restaurantId,
                    // ),
                  );
                },
              );
            }
          },
          style: ElevatedButton.styleFrom(
            primary: controller.orderList.isEmpty ? MyColors.redF98 : MyColors.redPrimary,
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
                  color: controller.orderList.isEmpty ? MyColors.redPrimary : MyColors.redF98,
                  borderRadius: BorderRadius.circular(11),
                ),
                child: GetBuilder<UserOrderCtrl>(
                  builder: (controller) {
                    return Text(
                      controller.totalQuantity.value.toString(),
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
              GetBuilder<UserOrderCtrl>(
                builder: (controller) {
                  return Text(
                    "${controller.totalPrice.value} $kPCurrency",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  );
                },
              ),
            ],
          ),
        );
      }),
    );
  }
}
