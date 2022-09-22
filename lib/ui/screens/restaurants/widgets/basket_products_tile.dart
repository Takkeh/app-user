import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/quantity_button.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class BasketProductTile extends StatefulWidget {
  final String imageUrl, title, subTitle, description;
  final double initialPrice;
  final String note, size;
  final int index;
  final List<Widget> extras;
  final int initialQuantity;

  const BasketProductTile({
    Key? key,
    required this.imageUrl,
    required this.title,
    required this.subTitle,
    required this.description,
    required this.extras,
    required this.initialPrice,
    required this.initialQuantity,
    required this.note,
    required this.index,
    required this.size,
  }) : super(key: key);

  @override
  State<BasketProductTile> createState() => BasketProductTileState();
}

class BasketProductTileState extends State<BasketProductTile> {
  late int newQuantity;
  late double newPrice;

  void toggle(String status, double initialPrice) {
    if (status == 'add') {
      setState(() {
        newQuantity++;
        newPrice = initialPrice * newQuantity;
      });
    } else {
      if (newQuantity == 1) return;
      setState(() {
        newQuantity--;
        newPrice = initialPrice * newQuantity;
      });
    }
  }

  @override
  void initState() {
    newPrice = widget.initialPrice;
    newQuantity = widget.initialQuantity;
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
                      Text(widget.size),
                      ...widget.extras,
                      const SizedBox(height: 12),
                      Row(
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
                          key: ValueKey(newQuantity),
                          style: const TextStyle(
                            fontSize: 16,
                            color: MyColors.redPrimary,
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
                          UserOrderCtrl.find.userOrder[widget.index]['price'] = newPrice;
                          UserOrderCtrl.find.userOrder[widget.index]['quantity'] = newQuantity;
                          print("newOrder:: ${UserOrderCtrl.find.userOrder}");
                        },
                        color: MyColors.redPrimary,
                      ),
                      Text(
                        newQuantity.toString(),
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                      ),
                      QuantityButton(
                        icon: Icons.remove,
                        onPressed: () {
                          toggle('remove', widget.initialPrice);
                        },
                        color: newQuantity == 1 ? MyColors.redPrimary.withOpacity(0.60) : MyColors.redPrimary,
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
