import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class BackLeadingWidget extends StatelessWidget {
  final IconData icon;

  const BackLeadingWidget({
    Key? key,
    this.icon = Icons.navigate_before,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        height: 40,
        width: 40,
        margin: const EdgeInsetsDirectional.fromSTEB(5, 5, 5, 5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color: MyColors.grey4F9.withOpacity(0.70),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Icon(
          icon,
          color: MyColors.greyEB3,
        ),
      ),
    );
  }
}
