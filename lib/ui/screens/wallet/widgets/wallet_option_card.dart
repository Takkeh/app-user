import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class WalletOptionCard extends StatelessWidget {
  final Function() onTap;
  final String title, icon;

  const WalletOptionCard({
    Key? key,
    required this.onTap,
    required this.title,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(26)),
      child: Material(
        color: Colors.transparent,
        borderRadius: BorderRadius.circular(26),
        child: InkWell(
          borderRadius: BorderRadius.circular(26),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  SvgPicture.asset(icon),
                  const VerticalDivider(
                    indent: 0,
                    endIndent: 0,
                    width: 30,
                  ),
                  Text(title),
                  const Spacer(),
                  const Icon(Icons.navigate_next),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
