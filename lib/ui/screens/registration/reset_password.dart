import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/registration/widgets/phone_suffix_icon.dart';
import 'package:takkeh/ui/widgets/custom_app_bar.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_rich_text.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';

enum Menu { itemOne, itemTwo, itemThree, itemFour }

class ResetPasswordScreen extends StatefulWidget {
  const ResetPasswordScreen({Key? key}) : super(key: key);

  @override
  State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  late TextEditingController phoneCtrl, countryCtrl;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  String _selectedMenu = '';

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
      appBar: const CustomAppBar(),
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
                  label: "Country".tr,
                  textDirection: TextDirection.ltr,
                  readOnly: true,
                  onTap: () {},
                  keyboardType: TextInputType.phone,
                  //TODO: do it later
                  prefixIcon: const CustomPrefixIcon(
                    icon: MyIcons.circlePhone,
                  ),
                  suffixIcon: PopupMenuButton<Menu>(
                    icon: const Icon(Icons.keyboard_arrow_down),
                    onSelected: (Menu item) {
                      setState(() {
                        _selectedMenu = item.name;
                      });
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<Menu>>[
                      const PopupMenuItem<Menu>(
                        value: Menu.itemOne,
                        child: Text('Item 1'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.itemTwo,
                        child: Text('Item 2'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.itemThree,
                        child: Text('Item 3'),
                      ),
                      const PopupMenuItem<Menu>(
                        value: Menu.itemFour,
                        child: Text('Item 4'),
                      ),
                    ],
                  ),
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Enter your phone number".tr;
                    }
                    return null;
                  },
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 15.0, bottom: 30),
                  child: CustomTextField(
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
                ),
                const SizedBox(height: 20),
                Center(
                  child: CustomElevatedButton(
                    title: "Send".tr,
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        FocusManager.instance.primaryFocus?.unfocus();
                        // controller.resetPassword(email: emailCtrl.text.trim(), context: context);
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
