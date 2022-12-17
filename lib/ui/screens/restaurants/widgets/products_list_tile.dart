import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/product_quantity_label.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class ProductsListTile extends StatelessWidget {
  final String imageUrl, title, description;
  final int id, isAvailable;
  final double price;
  final Function() onTap;

  const ProductsListTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.description,
    required this.onTap,
    required this.price,
    required this.id,
    required this.isAvailable,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserOrderCtrl>(
      builder: (controller) {
        int itemQuantity = 0;
        var value = controller.orderList.where((element) => element['product_id'] == id);
        for (var element in value) {
          itemQuantity = itemQuantity + element['quantity'] as int;
        }
        return GestureDetector(
          onTap: isAvailable == 0 ? onTap : null,
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
                      colorFilter: isAvailable == 1 ? ColorFilter.mode(MyColors.grey070.withOpacity(0.50), BlendMode.dstATop) : null,
                      child: isAvailable == 1
                          ? Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 8.0),
                              child: FittedBox(
                                child: Text(
                                  TranslationService.getString('available_key'),
                                  textAlign: TextAlign.center,
                                  style: const TextStyle(color: Colors.white),
                                ),
                              ),
                            )
                          : null,
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
                          const SizedBox(height: 3),
                          Text(
                            description,
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
              if (itemQuantity != 0) ProductQuantityLabel(quantity: itemQuantity),
            ],
          ),
        );
      },
    );
  }
}
