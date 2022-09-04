import 'package:flutter/material.dart';
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
  int counter = 1;
  late double price;

  void toggle(String status) {
    if (status == 'add') {
      setState(() {
        counter++;
        price = widget.price * counter;
      });
    } else {
      if (counter == 1) return;
      setState(() {
        counter--;
        price = widget.price * counter;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    price = widget.price;
  }

  @override
  Widget build(BuildContext context) {
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
              key: ValueKey(counter),
              price.toString(),
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
                  toggle('add');
                },
                color: MyColors.redD4F,
              ),
              Text(
                counter.toString(),
                style: const TextStyle(
                  fontSize: 17,
                ),
              ),
              QuantityButton(
                icon: Icons.remove,
                onPressed: () {
                  toggle('remove');
                },
                color: counter == 1 ? MyColors.redD4F.withOpacity(0.60) : MyColors.redD4F,
              ),
            ],
          )
        ],
      ),
    );
  }
}
