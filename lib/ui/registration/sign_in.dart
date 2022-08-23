import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/translation/translation_service/service.dart';
import 'package:takkeh/ui/registration//widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/registration/reset_password/step1.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_social_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/phone_field_helper.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({Key? key}) : super(key: key);

  @override
  SignInScreenState createState() => SignInScreenState();
}

class SignInScreenState extends State<SignInScreen> {
  late TextEditingController phoneCtrl;
  late TextEditingController passwordCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    phoneCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    phoneCtrl.dispose();
    passwordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            CustomTextField(
              textAlign: TextAlign.left,
              controller: phoneCtrl,
              inputFormatters: [LengthLimitingTextInputFormatter(9)],
              label: TranslationService.getString('phone number key'),
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              prefixIcon: PhoneFieldHelper.togglePrefixIcon(),
              suffixIcon: PhoneFieldHelper.toggleSuffixIcon(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your phone number".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            GetBuilder<SignInController>(
              init: SignInController(),
              builder: (controller) {
                return CustomTextField(
                  textDirection: TextDirection.ltr,
                  controller: passwordCtrl,
                  label: "Password".tr,
                  obscureText: controller.isObscure.value,
                  suffixIcon: IconButton(
                    onPressed: () {
                      controller.changeObscure();
                    },
                    icon: SvgPicture.asset(
                      //TODO: ask for the other icon
                      MyIcons.eyeCrossed,
                    ),
                  ),
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your password".tr;
                    }
                    return null;
                  },
                );
              },
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => const ResetPassStep1Screen());
                  },
                  child: Text(
                    "Forgot Password ?".tr,
                    style: const TextStyle(
                      color: MyColors.text,
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                const Spacer(),
              ],
            ),
            const Divider(
              height: 30,
              indent: 30,
              endIndent: 30,
            ),
            Text(
              "Or sign in with".tr,
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomSocialButton(
                  isGoogle: true,
                  color: Colors.white,
                  onTap: () {},
                ),
                CustomSocialButton(
                  icon: FontAwesomeIcons.facebookF,
                  color: MyColors.facebook,
                  onTap: () {},
                ),
                if (Platform.isIOS)
                  CustomSocialButton(
                    icon: FontAwesomeIcons.apple,
                    color: Colors.black,
                    onTap: () {},
                  ),
              ],
            ),
            const SizedBox(height: 40.0),
            CustomElevatedButton(
              title: "Sign in".tr,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();
                  SignInController.find.fetchSignInData(
                    email: phoneCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                    context: context,
                  );
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
