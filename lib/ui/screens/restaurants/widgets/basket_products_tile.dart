import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/make_order_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/quantity_button.dart';
import 'package:takkeh/ui/widgets/components/base_dialog.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class BasketProductTile extends StatefulWidget {
  final String imageUrl, title, note;
  final double initialPrice;
  final int index;
  final int initialQuantity, productId, restaurantId;
  final List<ProductItems> items;
  final UserProducts element;

  const BasketProductTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.initialPrice,
    required this.initialQuantity,
    required this.note,
    required this.index,
    required this.productId,
    required this.restaurantId,
    required this.items,
    required this.element,
  }) : super(key: key);

  @override
  State<BasketProductTile> createState() => BasketProductTileState();
}

class BasketProductTileState extends State<BasketProductTile> {
  late double originalPrice;
  late int quantity;
  late double newPrice;

  void _showDialog() {
    BaseDialog().show(
      title: TranslationService.getString('delete_item_key'),
      body: TranslationService.getString('delete_item_from_basket_key'),
      onPressed: () {
        MakeOrderCtrl.find.orderList.removeAt(widget.index);
        UserOrderCtrl.find.orderList.removeAt(widget.index);
        UserOrderCtrl.find.calculateTotalPrice(originalPrice, status: 'remove');
        UserOrderCtrl.find.calculateTotalQuantity(1, status: 'remove');
        Get.back();
        if (UserOrderCtrl.find.orderList.isEmpty) {
          Get.back();
        }
      },
    );
  }

  void toggleProduct() {
    UserOrderCtrl.find.orderList[widget.index]['price'] = newPrice;
    MakeOrderCtrl.find.orderList[widget.index].price = newPrice;
    UserOrderCtrl.find.orderList[widget.index]['quantity'] = quantity;
    MakeOrderCtrl.find.orderList[widget.index].quantity = quantity;
    log("userOrder:: ${UserOrderCtrl.find.orderList}");
  }

  void toggle(String status) {
    if (status == 'add') {
      setState(() {
        quantity++;
        newPrice = originalPrice * quantity;
      });
      UserOrderCtrl.find.calculateTotalPrice(originalPrice, status: 'add');
      UserOrderCtrl.find.calculateTotalQuantity(1, status: 'add');
      toggleProduct();
    } else {
      if (quantity == 1) {
        _showDialog();
      } else {
        setState(() {
          quantity--;
          newPrice = originalPrice * quantity;
        });
        UserOrderCtrl.find.calculateTotalPrice(originalPrice, status: 'remove');
        UserOrderCtrl.find.calculateTotalQuantity(1, status: 'remove');
        toggleProduct();
      }
    }
  }

  @override
  void initState() {
    originalPrice = widget.initialPrice / widget.initialQuantity;
    newPrice = widget.initialPrice;
    quantity = widget.initialQuantity;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              url: widget.imageUrl,
              radius: 10,
              width: 80,
              height: 80,
              margin: const EdgeInsetsDirectional.only(start: 10, end: 10),
            ),
            Expanded(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: MyColors.text,
                            fontSize: 17,
                          ),
                        ),
                        const SizedBox(height: 5),
                        ...widget.items.map((element) {
                          if (element.groupType == kOptional) {
                            return Text("+ ${element.itemName}");
                          } else if (element.groupType == kRemove) {
                            return Text("- ${element.itemName}");
                          } else {
                            return Text("${element.itemName}");
                          }
                        }).toList(),
                        const SizedBox(height: 12),
                        widget.note.isEmpty
                            ? const SizedBox.shrink()
                            : Row(
                                children: [
                                  SvgPicture.asset(MyIcons.notes, height: 14),
                                  Padding(
                                    padding: const EdgeInsetsDirectional.fromSTEB(3, 3, 0, 0),
                                    child: Text(
                                      widget.note,
                                    ),
                                  ),
                                ],
                              ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Text(
                            "$newPrice $kPCurrency",
                            key: ValueKey(quantity),
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.redPrimary,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      QuantityButton(
                        icon: Icons.add,
                        onPressed: () {
                          toggle('add');
                        },
                        color: MyColors.redPrimary,
                      ),
                      Text(
                        quantity.toString(),
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          toggle('remove');
                        },
                        color: quantity == 1 ? MyColors.redPrimary.withOpacity(0.60) : MyColors.redPrimary,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          height: 20,
          indent: 20,
          endIndent: 20,
        ),
        const SizedBox(height: 15),
      ],
    );
  }
}
