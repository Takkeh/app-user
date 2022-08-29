import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/code_timer_controller.dart';
import 'package:takkeh/controller/registration/send_otp.dart';
import 'package:takkeh/ui/screens/registration//widgets/verification_text_field.dart';
import 'package:takkeh/ui/screens/registration/widgets/otp_counter_widget.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_rich_text.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';

class VerificationScreen extends StatefulWidget {
  final String phoneNum, name, email, token;
  const VerificationScreen({
    Key? key,
    required this.phoneNum,
    required this.name,
    required this.email,
    required this.token,
  }) : super(key: key);

  @override
  State<VerificationScreen> createState() => _VerificationScreenState();
}

class _VerificationScreenState extends State<VerificationScreen> {
  List<CodeField> codeFields = [
    CodeField(focusNode: FocusNode(), controller: TextEditingController()),
    CodeField(focusNode: FocusNode(), controller: TextEditingController()),
    CodeField(focusNode: FocusNode(), controller: TextEditingController()),
    CodeField(focusNode: FocusNode(), controller: TextEditingController()),
  ];

  @override
  void initState() {
    CodeTimerController.find.startTimer(context, widget.phoneNum);
    super.initState();
  }

  @override
  void dispose() {
    for (var element in codeFields) {
      element.controller.dispose();
      element.focusNode.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const TransparentAppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(35),
        child: Column(
          children: [
            Image.asset(
              MyImages.logo,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 50.0, bottom: 20),
              child: CustomRichText(
                underLineNum: 0,
                texts: [
                  "Verification".tr,
                  " Code".tr,
                ],
              ),
            ),
            Text(
              "Please enter the 4-digit verification code that was sent to the phone number:".tr,
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(35, 35, 35, 20),
              child: VerificationTextField(
                initialValue: "+962${widget.phoneNum}",
                prefixIcon: SvgPicture.asset(
                  MyIcons.pencil,
                  height: 20,
                ),
              ),
            ),
            Row(
              textDirection: TextDirection.ltr,
              children: codeFields.map((element) {
                return Expanded(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    child: Directionality(
                      textDirection: TextDirection.ltr,
                      child: VerificationTextField(
                        inputFormatters: [
                          LengthLimitingTextInputFormatter(1),
                        ],
                        style: const TextStyle(fontSize: 18),
                        textAlign: TextAlign.center,
                        keyboardType: TextInputType.number,
                        focusNode: element.focusNode,
                        controller: element.controller,
                        onChanged: (value) {
                          if (value.length == 1) {
                            element.focusNode.nextFocus();
                          }
                        },
                      ),
                    ),
                  ),
                );
              }).toList(),
            ),
            OtpCounterWidget(phone: widget.phoneNum),
            CustomElevatedButton(
              title: "Confirm".tr,
              onPressed: () {
                for (var element in codeFields) {
                  if (element.controller.text.isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        backgroundColor: MyColors.redD4F,
                        content: Text(
                          "Please enter the 4-digit verification code".tr,
                        ),
                      ),
                    );
                    return;
                  }
                }
                FocusManager.instance.primaryFocus?.unfocus();
                SendOtpController.fetchOtpData(
                  code: '${codeFields[0].controller.text}${codeFields[1].controller.text}${codeFields[2].controller.text}${codeFields[3].controller.text}'.trim(),
                  phone: widget.phoneNum,
                  context: context,
                  name: widget.name,
                  token: widget.token,
                  email: widget.email,
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class CodeField {
  final TextEditingController controller;
  final FocusNode focusNode;

  CodeField({
    required this.focusNode,
    required this.controller,
  });
}
