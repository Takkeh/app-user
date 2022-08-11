import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_up.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/registration/widgets/terms_check_box.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/icons.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  SignUpScreenState createState() => SignUpScreenState();
}

class SignUpScreenState extends State<SignUpScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  bool isChecked = false;
  late TextEditingController nameCtrl, emailCtrl, passwordCtrl, confirmPasswordCtrl;

  final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordRegExp = RegExp(r'^[a-zA-Z0-9_\-=@,\.;]+$');

  @override
  void initState() {
    nameCtrl = TextEditingController();
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    nameCtrl.dispose();
    emailCtrl.dispose();
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
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
              controller: nameCtrl,
              label: "Full name".tr,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.smileBeam),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your name".tr;
                }
                return null;
              },
            ),
            const SizedBox(height: 15),
            CustomTextField(
              controller: emailCtrl,
              label: "Email".tr,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.atSymbol),
              validator: (value) {
                if (value!.isEmpty) {
                  return "Enter your email".tr;
                } else if (!emailRegExp.hasMatch(value)) {
                  return "invalid email".tr;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              child: CustomTextField(
                controller: passwordCtrl,
                label: "Password".tr,
                obscureText: true,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                suffixIcon: SvgPicture.asset(MyIcons.eyeCrossed),
                textDirection: TextDirection.ltr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return "Enter your password".tr;
                  } else if (value.length < 6) {
                    return "password must be more than 5 characters".tr;
                  } else if (!passwordRegExp.hasMatch(value)) {
                    return "invalid password".tr;
                  }
                  return null;
                },
              ),
            ),
            CustomTextField(
              controller: confirmPasswordCtrl,
              label: "Confirm password".tr,
              obscureText: true,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldCheck),
              suffixIcon: SvgPicture.asset(MyIcons.eyeCrossed),
              textDirection: TextDirection.ltr,
              validator: (value) {
                if (value!.isEmpty) {
                  return "Confirm your password".tr;
                } else if (value != passwordCtrl.text) {
                  return "password does not match".tr;
                }
                return null;
              },
            ),
            TermsCheckBox(
              isChecked: isChecked,
              onPressed: () {},
              onChanged: (value) {
                setState(() {
                  isChecked = !isChecked;
                });
              },
            ),
            const SizedBox(height: 30),
            CustomElevatedButton(
              title: "Sign up",
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "You must agree to the terms and conditions".tr,
                        ),
                      ),
                    );
                    return;
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  SignUpController.fetchSignUpData(
                    email: emailCtrl.text.trim(),
                    password: passwordCtrl.text.trim(),
                    name: nameCtrl.text.trim(),
                    context: context,
                  );
                  // controller.resetPassword(email: emailCtrl.text.trim(), context: context);
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
