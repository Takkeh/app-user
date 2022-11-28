import 'dart:io';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:takkeh/controller/profile/change_info.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:get/get.dart';

class ProfileInfoScreen extends StatefulWidget {
  final XFile? imageXFile;
  const ProfileInfoScreen({Key? key,this.imageXFile}) : super(key: key);

  @override
  State<ProfileInfoScreen> createState() => _ProfileInfoScreenState();
}

class _ProfileInfoScreenState extends State<ProfileInfoScreen> {
  late TextEditingController nameCtrl, emailCtrl;
  final emailRegExp = RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    Get.lazyPut(()=>ChangeInfoCtrl());
    nameCtrl = TextEditingController(text: MySharedPreferences.name);
    emailCtrl = TextEditingController(text: MySharedPreferences.email);
  }

  @override
  void dispose() {
    super.dispose();
    nameCtrl.dispose();
    emailCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.symmetric(horizontal: 50.0, vertical: 30),
        children: [
          CustomTextField(
            filled: true,
            fillColor: Colors.white,
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
          Padding(
            padding: const EdgeInsets.only(top: 20.0, bottom: 50),
            child: CustomTextField(
              readOnly: true,
              filled: true,
              fillColor: Colors.white,
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
          ),
          Center(
            child: CustomElevatedButton(
              title: TranslationService.getString('save_key'),
              onPressed: () {
                if (_formKey.currentState!.validate()){
                  FocusManager.instance.primaryFocus?.unfocus();
                  bool check = nameCtrl.text != MySharedPreferences.name ||
                      widget.imageXFile != null;
                  if (check) {
                    ChangeInfoCtrl.find.fetchUpdateProfileData(
                        email: emailCtrl.text,
                        name: nameCtrl.text,
                        image:
                            widget.imageXFile == null ? null : File(widget.imageXFile!.path),
                        context: context);
                  } else {
                    Fluttertoast.showToast(msg: 'Nothing has changed');
                  }
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
