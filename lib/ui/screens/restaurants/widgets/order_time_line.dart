import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderTimeLine extends StatelessWidget {
  const OrderTimeLine({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: const [
        Expanded(
          child: Divider(
            color: MyColors.redD4F,
            thickness: 3,
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 10.0),
            child: Divider(
              thickness: 3,
              color: MyColors.redD4F,
            ),
          ),
        ),
        Expanded(
          child: Divider(
            color: MyColors.redD4F,
            thickness: 3,
          ),
        ),
      ],
    );
  }
}
