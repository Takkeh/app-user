import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_up.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/registration//widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/registration//widgets/terms_check_box.dart';
import 'package:takkeh/ui/registration/send_otp.dart';
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
              label: TranslationService.getString('name_key'),
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.smileBeam),
              validator: (value) {
                if (value!.isEmpty) {
                  return TranslationService.getString('enter_name_key');
                }
                return null;
              },
            ),
            const SizedBox(height: 20),
            CustomTextField(
              horizontalPadding: 12,
              controller: emailCtrl,
              label: TranslationService.getString('email_key'),
              keyboardType: TextInputType.emailAddress,
              textDirection: TextDirection.ltr,
              prefixIcon: const CustomPrefixIcon(icon: MyIcons.atSymbol),
              validator: (value) {
                if (value!.isEmpty) {
                  return TranslationService.getString('enter_email_key');
                } else if (!emailRegExp.hasMatch(value)) {
                  return TranslationService.getString('invalid_email_key');
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
                    label: TranslationService.getString('password_key'),
                    obscureText: controller.isPasswordObscure.value,
                    prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                    suffixIcon: GestureDetector(
                      onTap: () {
                        controller.changePasswordObscure();
                      },
                      child: SvgPicture.asset(
                        controller.isPasswordObscure.value ? MyIcons.eyeCrossed : MyIcons.eye,
                      ),
                    ),
                    textDirection: TextDirection.ltr,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return TranslationService.getString('enter_password_key');
                      } else if (!passwordRegExp.hasMatch(value)) {
                        return TranslationService.getString('invalid_password_key');
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
                  label: TranslationService.getString('confirm_password_key'),
                  obscureText: controller.isConfirmPasswordObscure.value,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldCheck),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.changeConfirmPasswordObscure();
                    },
                    child: SvgPicture.asset(
                      controller.isConfirmPasswordObscure.value ? MyIcons.eyeCrossed : MyIcons.eye,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TranslationService.getString('confirm_password_key');
                    } else if (value != passwordCtrl.text) {
                      return TranslationService.getString('password_does_not_match_key');
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
              title: TranslationService.getString('sign_up_key'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  if (!isChecked) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          TranslationService.getString('must_agree_to_terms_key'),
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
