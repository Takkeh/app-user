import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class WalletCard extends StatelessWidget {
  final String name,amount;
  final Function() onTap;

  const WalletCard({
    Key? key,
    required this.name,
    required this.amount,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(23)),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 19, vertical: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 12, 0),
                  height: 70,
                  width: 70,
                  alignment: Alignment.center,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.circular(22),
                  ),
                  child: SvgPicture.asset(MyIcons.wallet),
                ),
                Column(
                  children: [
                    const Text(
                      "Wallet",
                      style: TextStyle(fontSize: 20),
                    ),
                    Text(
                      name,
                      style: const TextStyle(fontSize: 16, color: MyColors.grey070),
                    ),
                  ],
                ),
              ],
            ),
            const SizedBox(height: 18),
            const Text(
              "Account",
              style: TextStyle(fontSize: 20),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  "$amount $kPCurrency",
                  style: const TextStyle(fontSize: 40),
                ),
                GestureDetector(
                  onTap: onTap,
                  child: Container(
                    height: 50,
                    width: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: MyColors.primary,
                      borderRadius: BorderRadius.circular(17),
                    ),
                    child: const Icon(
                      Icons.add,
                      size: 16,
                      color: MyColors.text,
                    ),
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
