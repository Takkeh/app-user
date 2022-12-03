import 'package:flutter/material.dart';
import 'package:takkeh/utils/app_constants.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.title,
    required this.price,
    required this.count,
  }) : super(key: key);

  final String title;
  final double price;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          'X$count',
          style: const TextStyle(
            fontSize: 14,
          ),
          textDirection: TextDirection.ltr,
        ),
        Padding(
          padding: const EdgeInsetsDirectional.only(start: 8.0),
          child: Text(
            title,
            style: const TextStyle(
              fontSize: 14,
            ),
          ),
        ),
        const Spacer(),
        Text('$price $kPCurrency')
      ],
    );
  }
}
