import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class OrderAddressTile extends StatelessWidget {
  final String address;

  const OrderAddressTile({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      minLeadingWidth: 0,
      leading: SvgPicture.asset(
        MyIcons.marker,
        color: MyColors.redPrimary,
      ),
      title: Text(
        TranslationService.getString(
          'order_address_key',
        ),
        style: const TextStyle(
          fontSize: 18,
        ),
      ),
      subtitle: Text(
        address,
        style: const TextStyle(
          fontSize: 14,
          color: MyColors.grey070,
        ),
      ),
    );
  }
}
