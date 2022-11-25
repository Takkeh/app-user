import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/profile/change_password.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/icons.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({Key? key}) : super(key: key);

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  late TextEditingController currentPassCtrl, newPassCtrl, confirmNewPassCtrl;
  final emailRegExp = RegExp(
      r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final passwordRegExp =
      RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@=#\$&*~]).{8,}$');
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    currentPassCtrl = TextEditingController();
    newPassCtrl = TextEditingController();
    confirmNewPassCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    currentPassCtrl.dispose();
    newPassCtrl.dispose();
    confirmNewPassCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
        children: [
          GetBuilder<ChangePassCtrl>(
            init: ChangePassCtrl(),
            builder: (controller) {
              return CustomTextField(
                filled: true,
                fillColor: Colors.white,
                controller: currentPassCtrl,
                label: TranslationService.getString('password_key'),
                obscureText: controller.isCurrentPasswordObscure.value,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.changeCurrentPasswordObscure();
                  },
                  child: SvgPicture.asset(
                    controller.isCurrentPasswordObscure.value
                        ? MyIcons.eyeCrossed
                        : MyIcons.eye,
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
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20.0),
            child: GetBuilder<ChangePassCtrl>(
              init: ChangePassCtrl(),
              builder: (controller) {
                return CustomTextField(
                  filled: true,
                  fillColor: Colors.white,
                  controller: newPassCtrl,
                  label: TranslationService.getString('password_key'),
                  obscureText: controller.isNewPasswordObscure.value,
                  prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                  suffixIcon: GestureDetector(
                    onTap: () {
                      controller.changeNewPasswordObscure();
                    },
                    child: SvgPicture.asset(
                      controller.isNewPasswordObscure.value
                          ? MyIcons.eyeCrossed
                          : MyIcons.eye,
                    ),
                  ),
                  textDirection: TextDirection.ltr,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TranslationService.getString('enter_password_key');
                    } else if (!passwordRegExp.hasMatch(value)) {
                      return TranslationService.getString(
                          'invalid_password_key');
                    }
                    return null;
                  },
                );
              },
            ),
          ),
          GetBuilder<ChangePassCtrl>(
            init: ChangePassCtrl(),
            builder: (controller) {
              return CustomTextField(
                filled: true,
                fillColor: Colors.white,
                controller: confirmNewPassCtrl,
                label: TranslationService.getString('confirm_password_key'),
                obscureText: controller.isConfirmNewPasswordObscure.value,
                prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldCheck),
                suffixIcon: GestureDetector(
                  onTap: () {
                    controller.changeConfirmNewPasswordObscure();
                  },
                  child: SvgPicture.asset(
                    controller.isConfirmNewPasswordObscure.value
                        ? MyIcons.eyeCrossed
                        : MyIcons.eye,
                  ),
                ),
                textDirection: TextDirection.ltr,
                validator: (value) {
                  if (value!.isEmpty) {
                    return TranslationService.getString('confirm_password_key');
                  } else if (value != newPassCtrl.text) {
                    return TranslationService.getString(
                        'password_does_not_match_key');
                  }
                  return null;
                },
              );
            },
          ),
          const SizedBox(height: 50),
          Center(
            child: CustomElevatedButton(
              title: TranslationService.getString('save_key'),
              onPressed: () {
                ChangePassCtrl.find.updatePassword(
                    oldPassword: currentPassCtrl.text,
                    newPassword: newPassCtrl.text,
                    newPasswordConfirm: confirmNewPassCtrl.text,
                    context: context);
                if (_formKey.currentState!.validate()) {
                  FocusManager.instance.primaryFocus?.unfocus();

                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
