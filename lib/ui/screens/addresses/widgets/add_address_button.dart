import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/addresses.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/add_new_address_screen.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class AddNewAddressButton extends StatelessWidget {
  final EdgeInsetsGeometry? padding;

  const AddNewAddressButton({
    Key? key,
    this.padding,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding ?? EdgeInsets.zero,
      child: OutlinedButton.icon(
        style: OutlinedButton.styleFrom(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
          fixedSize: Size(Get.width, 60),
        ),
        onPressed: () async {
          var isGranted = await UserLocationCtrl.find.checkPermission(context);
          if (isGranted) {
            Get.to(() => const AddNewAddressScreen(), binding: CreateAddressBinding());
          }
        },
        label: Text(
          TranslationService.getString('add_new_address_key'),
          style: const TextStyle(fontSize: 18, color: MyColors.text),
        ),
        icon: SvgPicture.asset(
          MyIcons.marker,
          color: MyColors.primary,
        ),
      ),
    );
  }
}
