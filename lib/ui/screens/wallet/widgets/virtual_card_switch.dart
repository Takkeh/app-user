import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/base/colors.dart';

class VirtualCardSwitch extends StatelessWidget {
  const VirtualCardSwitch({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(26),
      ),
      color: Colors.white,
      margin: const EdgeInsets.symmetric(horizontal: 45),
      child: Padding(
        padding: const EdgeInsetsDirectional.fromSTEB(37, 10, 20, 10),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(TranslationService.getString('virtual_payment_card_key')),
            Switch.adaptive(
              // This bool value toggles the switch.
              value: true,
              inactiveThumbColor: Colors.white,
              inactiveTrackColor: MyColors.grey070,
              activeTrackColor: MyColors.primary.withOpacity(0.50),
              activeColor: MyColors.primary,
              onChanged: (bool value) {
                // This is called when the user toggles the switch.
                // setState(() {
                //   light = value;
                // });
              },
            ),
          ],
        ),
      ),
    );
  }
}
