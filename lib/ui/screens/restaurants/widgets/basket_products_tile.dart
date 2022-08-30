import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/quantity_button.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class BasketProductTile extends StatefulWidget {
  final String imageUrl, title, subTitle, description;
  final double initialPrice;
  final List<Widget> notes;
  final Function() onTap;

  const BasketProductTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.onTap,
    required this.notes,
    required this.initialPrice,
  }) : super(key: key);

  @override
  State<BasketProductTile> createState() => BasketProductTileState();
}

class BasketProductTileState extends State<BasketProductTile> {
  late int counter;
  late double newPrice;

  void toggle(String status, double initialPrice) {
    if (status == 'add') {
      setState(() {
        counter++;
        newPrice = initialPrice * counter;
      });
    } else {
      if (counter == 1) return;
      setState(() {
        counter--;
        newPrice = initialPrice * counter;
      });
    }
  }

  @override
  void initState() {
    newPrice = widget.initialPrice;
    counter = 1;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onTap,
      child: Column(
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
              ),
              const SizedBox(width: 10),
              Expanded(
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.title,
                          style: const TextStyle(
                            color: MyColors.text,
                            fontSize: 18,
                          ),
                        ),
                        ...widget.notes,
                        const SizedBox(
                          height: 10,
                        ),
                        AnimatedSwitcher(
                          duration: const Duration(milliseconds: 300),
                          transitionBuilder: (Widget child, Animation<double> animation) {
                            return ScaleTransition(scale: animation, child: child);
                          },
                          child: Text(
                            "$newPrice $kPCurrency",
                            key: ValueKey(counter),
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.redD4F,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        QuantityButton(
                          icon: Icons.add,
                          onPressed: () {
                            toggle('add', widget.initialPrice);
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
                            toggle('remove', widget.initialPrice);
                          },
                          color: counter == 1 ? MyColors.redD4F.withOpacity(0.60) : MyColors.redD4F,
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
      ),
    );
  }
}
