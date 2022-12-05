import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/create_account.dart';
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

class SendOtpScreen extends StatefulWidget {
  final String? email, password, name, route;

  const SendOtpScreen({
    Key? key,
    this.email,
    this.password,
    this.name,
    this.route,
  }) : super(key: key);

  @override
  State<SendOtpScreen> createState() => _SendOtpScreenState();
}

class _SendOtpScreenState extends State<SendOtpScreen> {
  late TextEditingController phoneCtrl, countryCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  void showDialog() {
    Get.defaultDialog(
      title: "Countries",
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
                CustomTextField(
                  label: "Country".tr,
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
                    label: "Phone number".tr,
                    textDirection: TextDirection.ltr,
                    keyboardType: TextInputType.phone,
                    prefixIcon: PhoneFieldHelper.togglePrefixIcon(),
                    suffixIcon: PhoneFieldHelper.toggleSuffixIcon(),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter your phone number".tr;
                      } else if (value.length < 9) {
                        return '';
                      }
                      return null;
                    },
                  ),
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
                    title: "Send".tr,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        CreateAccountController.fetchSignUpData(
                          email: widget.email!,
                          password: widget.password!,
                          name: widget.name!,
                          context: context,
                          phone: phoneCtrl.text,
                          route: widget.route!,
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
