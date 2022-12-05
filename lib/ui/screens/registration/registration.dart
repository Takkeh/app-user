import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/sign_in.dart';
import 'package:takkeh/ui/screens/registration//sign_in.dart';
import 'package:takkeh/ui/screens/registration//sign_up.dart';
import 'package:takkeh/ui/widgets/base_switch_slider.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:takkeh/utils/strings.dart';

class RegistrationScreen extends StatefulWidget {
  final String route;

  const RegistrationScreen({Key? key, this.route = kHome}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late PageController pageController;
  bool isSignIn = true;

  @override
  void initState() {
    pageController = PageController();
    Get.put(SignInController());
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isKeyboardVisible = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
          child: Column(
            children: [
              Image.asset(
                MyImages.logo,
                height: 150,
              ),
              BaseSwitchSlider(
                margin: const EdgeInsets.only(top: 20, bottom: 40, left: 20, right: 20),
                color: MyColors.grey5FA,
                title1: MyStrings.signInKey,
                title2: MyStrings.signUpKey,
                onTap1: () {
                  setState(() {
                    FocusManager.instance.primaryFocus?.unfocus();
                    isSignIn = true;
                    pageController.animateToPage(
                      0,
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastOutSlowIn,
                    );
                  });
                },
                onTap2: () {
                  FocusManager.instance.primaryFocus?.unfocus();
                  setState(() {
                    isSignIn = false;
                    pageController.animateToPage(
                      1,
                      duration: const Duration(milliseconds: 750),
                      curve: Curves.fastOutSlowIn,
                    );
                  });
                },
                isFirst: MySharedPreferences.language == 'en' ? isSignIn : !isSignIn,
              ),
              Expanded(
                child: PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: pageController,
                  children: [
                    SignInScreen(isKeyboardVisible: isKeyboardVisible, route: widget.route),
                    SignUpScreen(route: widget.route),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
