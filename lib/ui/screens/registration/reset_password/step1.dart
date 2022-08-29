import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/reset_pass/step1.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/countries_dialog.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_rich_text.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/phone_field_helper.dart';

class ResetPassStep1Screen extends StatefulWidget {
  const ResetPassStep1Screen({
    Key? key,
  }) : super(key: key);

  @override
  State<ResetPassStep1Screen> createState() => _ResetPassStep1ScreenState();
}

class _ResetPassStep1ScreenState extends State<ResetPassStep1Screen> {
  late TextEditingController phoneCtrl, countryCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showDialog() {
    Get.defaultDialog(
      title: TranslationService.getString('Countries_key'),
      titlePadding: const EdgeInsets.only(top: 35),
      radius: 56,
      titleStyle: const TextStyle(color: MyColors.primary),
      contentPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 0),
      content: CountriesDialog(chosenCountry: countryCtrl.text),
    );
  }

  @override
  void initState() {
    countryCtrl = TextEditingController();
    phoneCtrl = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    countryCtrl.dispose();
    phoneCtrl.dispose();
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
                    "Reset ".tr,
                    "Your".tr,
                    " Password".tr,
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Please enter the phone number associated with the account to reset your password".tr,
                  ),
                ),
                CustomTextField(
                  label: TranslationService.getString('country_key'),
                  textDirection: TextDirection.ltr,
                  readOnly: true,
                  onTap: () {
                    showDialog();
                  },
                  prefixIcon: const CustomPrefixIcon(
                    icon: MyIcons.circlePhone,
                  ),
                  suffixIcon: const Icon(Icons.keyboard_arrow_down),
                  validator: (value) {
                    // if (value!.isEmpty) {
                    //   return "Enter your phone number".tr;
                    // }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30),
                  child: CustomTextField(
                    inputFormatters: [LengthLimitingTextInputFormatter(9)],
                    controller: phoneCtrl,
                    label: TranslationService.getString('phone_num_key'),
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.phone,
                    prefixIcon: PhoneFieldHelper.togglePrefixIcon(),
                    suffixIcon: PhoneFieldHelper.toggleSuffixIcon(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return TranslationService.getString('enter_phone_key');
                      } else if (value.length < 9) {
                        return TranslationService.getString('invalid_phone_key');
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
                    title: TranslationService.getString('send_key'),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        ResetPassStep1Controller.fetchOtpData(
                          context: context,
                          phone: phoneCtrl.text,
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
