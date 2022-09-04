import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/base/colors.dart';

class BaseSwitchSlider extends StatelessWidget {
  final String title1;
  final String title2;
  final bool isFirst;
  final Function() onTap1;
  final Function() onTap2;
  final Color color;
  final EdgeInsetsGeometry margin;

  const BaseSwitchSlider({
    Key? key,
    required this.title1,
    required this.title2,
    required this.onTap1,
    required this.onTap2,
    required this.isFirst,
    required this.color,
    required this.margin,
  }) : super(key: key);

  static Widget buildField(String title, Function() onTap) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          color: Colors.transparent,
          alignment: Alignment.center,
          child: Text(
            title,
            style: const TextStyle(
              color: MyColors.black109,
              fontSize: 16,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      margin: margin,
      width: double.infinity,
      height: 70,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(26),
        color: color,
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8.0),
            child: AnimatedAlign(
              alignment: isFirst ? const Alignment(-1, 0) : const Alignment(1, 0),
              duration: const Duration(milliseconds: 750),
              curve: Curves.fastOutSlowIn,
              child: CustomElevatedButton(
                title: "",
                onPressed: () {},
                color: MyColors.primary,
              ),
            ),
          ),
          Row(
            children: [
              buildField(title1, onTap1),
              const SizedBox(width: 20),
              buildField(title2, onTap2),
            ],
          ),
        ],
      ),
    );
  }
}
