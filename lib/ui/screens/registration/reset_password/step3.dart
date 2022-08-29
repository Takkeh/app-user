import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/reset_pass/step3.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_rich_text.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/strings.dart';

class ResetPassStep3Screen extends StatefulWidget {
  final String phone;

  const ResetPassStep3Screen({
    Key? key,
    required this.phone,
  }) : super(key: key);

  @override
  State<ResetPassStep3Screen> createState() => _ResetPassStep3ScreenState();
}

class _ResetPassStep3ScreenState extends State<ResetPassStep3Screen> {
  late TextEditingController passwordCtrl, confirmPasswordCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final passwordRegExp = RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@=#\$&*~]).{8,}$');

  bool isPassObscure = true;
  bool isConfirmPassObscure = true;

  @override
  void initState() {
    passwordCtrl = TextEditingController();
    confirmPasswordCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    passwordCtrl.dispose();
    confirmPasswordCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: SafeArea(
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            padding: const EdgeInsets.fromLTRB(35, 0, 35, 35),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image.asset(
                  MyImages.logo,
                  height: 150,
                ),
                CustomRichText(
                  underLineNum: 1,
                  texts: [
                    "Confirm ".tr,
                    "Phone".tr,
                    " Number".tr,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Please enter the phone number".tr,
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: GetBuilder<ResetPassStep3Controller>(
                    init: ResetPassStep3Controller(),
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
                            controller.isPasswordObscure.value ? MyIcons.eyeCrossed : MyIcons.eye,
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
                GetBuilder<ResetPassStep3Controller>(
                  init: ResetPassStep3Controller(),
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
                          controller.isConfirmPasswordObscure.value ? MyIcons.eyeCrossed : MyIcons.eye,
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
                const SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
                    title: "Send".tr,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ResetPassStep3Controller.fetchResetPassStep3Data(
                          context: context,
                          phone: widget.phone,
                          password: passwordCtrl.text.trim(),
                        );
                      }
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
