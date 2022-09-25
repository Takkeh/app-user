import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderStatusAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final int orderId;

  const OrderStatusAppBar({
    super.key,
    this.title,
    required this.orderId,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      elevation: 0,
      leadingWidth: 73,
      centerTitle: true,
      title: Text(
        '#$orderId',
        style: const TextStyle(
          color: MyColors.text,
          fontSize: 20,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(AppBar().preferredSize.height);
}
