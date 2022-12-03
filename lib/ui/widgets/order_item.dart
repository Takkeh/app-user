import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderItem extends StatelessWidget {
  const OrderItem({
    Key? key,
    required this.title,
    required this.price,
    required this.count,
  }) : super(key: key);

  final String title;
  final String price;
  final int count;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 10),
      child: Row(
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
                color: MyColors.grey,
              ),
            ),
          ),
          const Spacer(),
          Text('$price ${'JOD'.tr}')
        ],
      ),
    );
  }
}
