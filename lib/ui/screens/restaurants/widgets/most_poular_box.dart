import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class MostPopularBox extends StatelessWidget {
  final String title, imageUrl;
  final double price;
  final VoidCallback onTap;
  final int productId;

  const MostPopularBox({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.price,
    required this.onTap,
    required this.productId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserOrderCtrl>(builder: (controller) {
      int itemQuantity = 0;
      var value = controller.orderList.where((element) => element['product_id'] == productId);
      for (var element in value) {
        itemQuantity = itemQuantity + element['quantity'] as int;
      }
      return GestureDetector(
        onTap: onTap,
        child: Stack(
          alignment: AlignmentDirectional.topEnd,
          children: [
            Container(
              width: 120,
              padding: const EdgeInsets.only(bottom: 3),
              decoration: BoxDecoration(
                color: MyColors.grey9F4,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                children: [
                  Expanded(
                    child: CustomNetworkImage(
                      radius: 12,
                      url: imageUrl,
                      width: double.infinity,
                      margin: const EdgeInsets.only(bottom: 3),
                    ),
                  ),
                  FittedBox(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 3.0),
                      child: Text(
                        title,
                        style: const TextStyle(
                          fontSize: 15,
                        ),
                        maxLines: 1,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  Text(
                    price.toString(),
                    style: const TextStyle(
                      fontSize: 15,
                      color: MyColors.redPrimary,
                    ),
                  ),
                ],
              ),
            ),
            if (itemQuantity != 0)
              Container(
                height: 30,
                width: 30,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: MyColors.redPrimary,
                  borderRadius: BorderRadius.circular(12.0),
                ),
                child: Text(
                  "X$itemQuantity",
                  style: const TextStyle(color: Colors.white),
                ),
              ),
          ],
        ),
      );
    });
  }
}
