import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration//widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/registration/reset_password/step1.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
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
    Get.lazyPut(() => SignInController());
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
    var show = MediaQuery.of(context).viewInsets.bottom == 0.0;
    print("show:: $show");
    return Stack(
      children: [
        SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(35, 20, 35, 35),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                CustomTextField(
                  textAlign: TextAlign.left,
                  controller: phoneCtrl,
                  inputFormatters: [LengthLimitingTextInputFormatter(9)],
                  label: TranslationService.getString('phone_number_key'),
                  textDirection: TextDirection.ltr,
                  keyboardType: TextInputType.phone,
                  prefixIcon: PhoneFieldHelper.togglePrefixIcon(),
                  suffixIcon: PhoneFieldHelper.toggleSuffixIcon(),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return TranslationService.getString('enter_phone_number_key');
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
                      label: TranslationService.getString('password_key'),
                      obscureText: controller.isObscure.value,
                      suffixIcon: IconButton(
                        onPressed: () {
                          controller.changeObscure();
                        },
                        icon: SvgPicture.asset(
                          controller.isObscure.value ? MyIcons.eyeCrossed : MyIcons.eye,
                        ),
                      ),
                      prefixIcon: const CustomPrefixIcon(icon: MyIcons.shieldPlus),
                      validator: (value) {
                        if (value!.isEmpty) {
                          return TranslationService.getString('enter_password_key');
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
                        TranslationService.getString('forgot_password_key'),
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
                //TODO: for 2nd version
                // const Divider(
                //   height: 30,
                //   indent: 30,
                //   endIndent: 30,
                // ),
                // Text(
                //   TranslationService.getString('or_sign_in_with_key'),
                //   style: const TextStyle(
                //     fontSize: 16,
                //   ),
                // ),
                // const SizedBox(height: 20),
                // Row(
                //   mainAxisAlignment: MainAxisAlignment.center,
                //   children: [
                //     CustomSocialButton(
                //       isGoogle: true,
                //       color: Colors.white,
                //       onTap: () {},
                //     ),
                //     CustomSocialButton(
                //       icon: FontAwesomeIcons.facebookF,
                //       color: MyColors.facebook,
                //       onTap: () {},
                //     ),
                //     if (Platform.isIOS)
                //       CustomSocialButton(
                //         icon: FontAwesomeIcons.apple,
                //         color: Colors.black,
                //         onTap: () {},
                //       ),
                //   ],
                // ),
                const SizedBox(height: 40.0),
                CustomElevatedButton(
                  title: TranslationService.getString('sign_in_key'),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      FocusManager.instance.primaryFocus?.unfocus();
                      SignInController.find.fetchSignInData(
                        phone: phoneCtrl.text.trim(),
                        password: passwordCtrl.text.trim(),
                        context: context,
                      );
                    }
                  },
                ),
              ],
            ),
          ),
        ),
        //TODO: refactor and add functionality
        Visibility(
          visible: false,
          child: Align(
            alignment: const AlignmentDirectional(1, 1),
            child: Stack(
              alignment: const AlignmentDirectional(0.5, 0.3),
              children: [
                //TODO: another picture for english
                Image.asset(
                  MyImages.semiCircle,
                  height: 110,
                ),
                Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(
                      Icons.arrow_forward_ios,
                      color: Colors.white,
                      size: 30,
                    ),
                    const SizedBox(height: 5),
                    Text(
                      TranslationService.getString("skip_key"),
                      style: const TextStyle(color: Colors.white),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
