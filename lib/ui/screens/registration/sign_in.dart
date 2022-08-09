import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/ui/screens/registration/reset_password.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/registration/widgets/phone_suffix_icon.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_social_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

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
              controller: phoneCtrl,
              label: "Phone number".tr,
              textDirection: TextDirection.ltr,
              keyboardType: TextInputType.phone,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.circlePhone),
              suffixIcon: const PhoneSuffixIcon(),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your phone number".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            CustomTextField(
              textDirection: TextDirection.ltr,
              controller: passwordCtrl,
              label: "Password".tr,
              obscureText: true,
              suffixIcon: IconButton(
                onPressed: () {},
                icon: SvgPicture.asset(
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
            ),
            Row(
              children: [
                TextButton(
                  onPressed: () {
                    Get.to(() => const ResetPasswordScreen());
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
                  SignInController.fetchSignInData(
                    // email: emailCtrl.text.trim(),
                    //TODO: change later
                    email: "testing123@gmail.com",
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
