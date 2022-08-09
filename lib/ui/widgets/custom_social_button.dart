import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/icons.dart';

class CustomSocialButton extends StatelessWidget {
  final Color color;
  final bool isGoogle;
  final IconData? icon;
  final Function() onTap;

  const CustomSocialButton({
    Key? key,
    required this.color,
    this.isGoogle = false,
    this.icon,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final border10 = BorderRadius.circular(10);
    return Card(
      color: color,
      shape: RoundedRectangleBorder(borderRadius: border10),
      child: Material(
        borderRadius: border10,
        color: Colors.transparent,
        child: InkWell(
          borderRadius: border10,
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: isGoogle
                ? SvgPicture.asset(
                    MyIcons.google,
                    height: 35,
                  )
                : Icon(icon, color: Colors.white, size: 35),
          ),
        ),
      ),
    );
  }
}
