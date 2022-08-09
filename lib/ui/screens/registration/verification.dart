import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/widgets/CustomRichText.dart';
import 'package:takkeh/ui/widgets/custom_app_bar.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';

class VerificationScreen extends StatelessWidget {
  const VerificationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const CustomAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            Image.asset(
              MyImages.logo,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20),
              child: CustomRichText(
                underLineNum: 0,
                texts: [
                  "Verification".tr,
                  " Code".tr,
                ],
              ),
            ),
            Text(
              "Please enter the 4-digit verification code that was sent to the phone number:".tr,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 35, 35, 20),
              child: VerificationTextField(
                initialValue: "+962791595029",
                prefixIcon: SvgPicture.asset(
                  MyIcons.pencil,
                  height: 20,
                ),
              ),
            ),
            Row(
              children: List.generate(
                4,
                (index) {
                  return const Expanded(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 5.0),
                      child: VerificationTextField(),
                    ),
                  );
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 40.0, bottom: 50),
              child: RichText(
                text: const TextSpan(
                  children: <TextSpan>[
                    TextSpan(
                      text: 'Resend ',
                      style: TextStyle(
                        color: MyColors.text,
                      ),
                    ),
                    TextSpan(
                      text: 'After 59 seconds',
                      style: TextStyle(
                        color: MyColors.redD4F,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            CustomElevatedButton(
              title: "Confirm",
              onPressed: () {},
            ),
          ],
        ),
      ),
    );
  }
}

class VerificationTextField extends StatelessWidget {
  final String? initialValue;
  final Widget? prefixIcon;

  const VerificationTextField({
    Key? key,
    this.initialValue,
    this.prefixIcon,
  }) : super(key: key);

  static const _border = 19.0;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: initialValue,
      decoration: InputDecoration(
        filled: true,
        fillColor: MyColors.grey4F9,
        prefixIcon: prefixIcon,
        prefixIconConstraints: const BoxConstraints(
          maxHeight: 80,
          minWidth: 70,
          maxWidth: 70,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        disabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(_border),
          borderSide: BorderSide.none,
        ),
        errorStyle: const TextStyle(color: Color(0xFFD74545)),
      ),
    );
  }
}
