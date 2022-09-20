import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/utils/base/colors.dart';

class TermsCheckBox extends StatelessWidget {
  const TermsCheckBox({
    Key? key,
    required this.isChecked,
    required this.onChanged,
    required this.onPressed,
  }) : super(key: key);

  final bool isChecked;
  final Function(bool?) onChanged;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Checkbox(
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
          activeColor: MyColors.primary,
          value: isChecked,
          onChanged: onChanged,
        ),
        Padding(
          padding: const EdgeInsets.only(top: 5.0),
          child: Row(
            children: [
              Text("I agree to the".tr),
              TextButton(
                onPressed: onPressed,
                style: TextButton.styleFrom(
                  padding: const EdgeInsets.symmetric(horizontal: 3),
                ),
                child: Text(
                  "terms and conditions".tr,
                  style: const TextStyle(color: MyColors.redPrimary),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
