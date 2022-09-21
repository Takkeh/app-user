import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/product_quantity_label.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ProductsListTile extends StatelessWidget {
  final String imageUrl, title, subTitle;
  final int price, index, id;
  final Function() onTap;

  const ProductsListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.onTap,
    required this.price,
    required this.index,
    required this.id,
  }) : super(key: key);

  // static double? quantity;

  // bool getIndex() {
  //    UserOrderCtrl.find.userOrder.any((element) {
  //     if(element['product_id'] == id) {
  //       quantity =  element['quantity'];
  //       return true;
  //     } else {
  //       return false;
  //     }
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Stack(
        alignment: MySharedPreferences.language == 'en' ? Alignment.bottomRight : Alignment.bottomLeft,
        children: [
          Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(17),
              color: const Color(0xFFFAF5E6),
            ),
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                CustomNetworkImage(
                  url: imageUrl,
                  radius: 10,
                  width: 80,
                  height: 80,
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        title,
                        style: const TextStyle(
                          color: MyColors.text,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        subTitle,
                        style: const TextStyle(
                          color: MyColors.greyEB3,
                        ),
                      ),
                      Text(
                        "$price $kPCurrency",
                        style: const TextStyle(
                          color: MyColors.redPrimary,
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          GetBuilder<UserOrderCtrl>(
            builder: (controller) {
              if (controller.getProductQuantity(id) != 0) {
                return ProductQuantityLabel(quantity: controller.getProductQuantity(id));
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ],
      ),
    );
  }
}
