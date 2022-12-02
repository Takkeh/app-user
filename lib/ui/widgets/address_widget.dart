import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/utils/base/icons.dart';

class AddressWidget extends StatelessWidget {
  const AddressWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesCtrl>(
      builder: (controller) {
        if (controller.locality.value.isEmpty && controller.subLocality.value.isEmpty) {
          return const SizedBox.shrink();
        }
        return Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.ideographic,
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(MyIcons.marker),
            const SizedBox(width: 5),
            Text(
              "${controller.locality.value}, ${controller.subLocality.value}",
            ),
          ],
        );
      },
    );
  }
}
