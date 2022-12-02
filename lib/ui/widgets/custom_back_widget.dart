import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class CustomBackWidget extends StatelessWidget {
  const CustomBackWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Card(
        color: MyColors.grey4F9.withOpacity(0.70),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
        margin: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: const Icon(
          Icons.navigate_before,
          color: Colors.white,
        ),
      ),
    );
  }
}
