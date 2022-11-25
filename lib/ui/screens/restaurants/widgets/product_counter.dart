import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/quantity_button.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductCounter extends StatefulWidget {
  final double price;

  const ProductCounter({
    Key? key,
    required this.price,
  }) : super(key: key);

  @override
  State<ProductCounter> createState() => ProductCounterState();
}

class ProductCounterState extends State<ProductCounter> {
  @override
  void initState() {
    super.initState();
    ViewProductCtrl.find.finalPrice.value = widget.price;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ViewProductCtrl>(builder: (controller) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 12.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                controller.finalPrice.value.toString(),
                style: const TextStyle(
                  fontSize: 20,
                  color: MyColors.redPrimary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                QuantityButton(
                  icon: Icons.add,
                  onPressed: () {
                    controller.calculateQuantity('add');
                  },
                  color: MyColors.redPrimary,
                ),
                Text(
                  '${controller.quantity.value}',
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                QuantityButton(
                  icon: Icons.remove,
                  onPressed: () {
                    controller.calculateQuantity('remove');
                  },
                  color: controller.quantity.value == 1 ? MyColors.redPrimary.withOpacity(0.60) : MyColors.redPrimary,
                ),
              ],
            )
          ],
        ),
      );
    });
  }
}
