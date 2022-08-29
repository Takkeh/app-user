import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class ViewProductFABButton extends StatelessWidget {
  const ViewProductFABButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            11,
          ),
        ),
        primary: MyColors.redD4F,
        minimumSize: const Size(double.infinity, 50),
      ),
      onPressed: () {},
      child: const Text(
        "Add to cart",
        style: TextStyle(
          color: Colors.white,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}
