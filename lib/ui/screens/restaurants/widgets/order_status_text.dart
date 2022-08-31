import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderStatusText extends StatelessWidget {
  const OrderStatusText({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 10),
      child: FittedBox(
        child: RichText(
          text: const TextSpan(
            children: <TextSpan>[
              TextSpan(text: 'your order on the way, ', style: TextStyle(fontSize: 18, color: MyColors.text)),
              TextSpan(text: 'takkeh', style: TextStyle(fontSize: 18, color: MyColors.redD4F)),
              TextSpan(text: ' and it will be there', style: TextStyle(fontSize: 18, color: MyColors.text)),
            ],
          ),
        ),
      ),
    );
  }
}
