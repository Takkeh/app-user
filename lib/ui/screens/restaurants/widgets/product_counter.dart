import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/view_product.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/quantity_button.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductCounter extends StatelessWidget {
  const ProductCounter({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12.0),
      child: GetBuilder<ViewProductCtrl>(builder: (controller) {
        return Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (Widget child, Animation<double> animation) {
                return ScaleTransition(scale: animation, child: child);
              },
              child: Text(
                key: ValueKey(controller.counter.value),
                controller.getPrice(22.5),
                style: const TextStyle(
                  fontSize: 20,
                  color: MyColors.redD4F,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Row(
              children: [
                QuantityButton(
                  icon: Icons.add,
                  onPressed: () {
                    controller.toggle('add');
                  },
                  color: MyColors.redD4F,
                ),
                Text(
                  controller.counter.value.toString(),
                  style: const TextStyle(
                    fontSize: 17,
                  ),
                ),
                QuantityButton(
                  icon: Icons.remove,
                  onPressed: () {
                    controller.toggle('remove');
                  },
                  color: controller.counter.value == 1 ? MyColors.redD4F.withOpacity(0.60) : MyColors.redD4F,
                ),
              ],
            )
          ],
        );
      }),
    );
  }
}
