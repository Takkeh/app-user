import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_up.dart';
import 'package:takkeh/ui/registration//widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/registration//widgets/terms_check_box.dart';
import 'package:takkeh/ui/registration/send_otp.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/strings.dart';

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
  final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@=#\$&*~]).{8,}$');

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
              label: 'email_key',
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.smileBeam),
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourNameKey;
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              horizontalPadding: 12,
              controller: emailCtrl,
              label: MyStrings.emailKey,
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.atSymbol),
              validator: (value) {
                if (value!.isEmpty) {
                  return MyStrings.enterYourEmailKey;
                } else if (!emailRegExp.hasMatch(value)) {
                  return MyStrings.invalidEmailKey;
                }
                return null;
              },
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 20.0),
              child: GetBuilder<SignUpController>(
                init: SignUpController(),
                builder: (controller) {
                  return CustomTextField(
                    controller: passwordCtrl,
                    label: MyStrings.passwordKey,
                    obscureText: controller.isPasswordObscure.value,
                    prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.changePasswordObscure();
                      },
                      child: SvgPicture.asset(
                        MyIcons.eyeCrossed,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return MyStrings.enterYourPasswordKey;
                      } else if (!passwordRegExp.hasMatch(value)) {
                        return MyStrings.invalidPasswordKey;
                      }
                      return null;
                    },
                  );
                },
              ),
            ),
            GetBuilder<SignUpController>(
              init: SignUpController(),
              builder: (controller) {
                return CustomTextField(
                  controller: confirmPasswordCtrl,
                  label: MyStrings.confirmPassword,
                  obscureText: controller.isConfirmPasswordObscure.value,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldCheck),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.changeConfirmPasswordObscure();
                    },
                    child: SvgPicture.asset(
                      MyIcons.eyeCrossed,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return MyStrings.confirmPassword;
                    } else if (value != passwordCtrl.text) {
                      return MyStrings.passwordDoesNotMatchKey;
                    }
                    return null;
                  },
                );
              },
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30, top: 20),
              child: TermsCheckBox(
                isChecked: isChecked,
                onPressed: () {},
                onChanged: (value) {
                  setState(() {
                    isChecked = !isChecked;
                  });
                },
              ),
            ),
            CustomElevatedButton(
              title: MyStrings.signUpKey,
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          MyStrings.mustAgreeToTermsKey,
                        ),
                      ),
                    );
                    return;
                  }
                  FocusManager.instance.primaryFocus?.unfocus();
                  Get.to(
                    () => SendOtpScreen(
                      email: emailCtrl.text.trim(),
                      password: passwordCtrl.text.trim(),
                      name: nameCtrl.text.trim(),
                    ),
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
