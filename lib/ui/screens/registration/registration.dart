import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/registration//sign_in.dart';
import 'package:takkeh/ui/screens/registration//sign_up.dart';
import 'package:takkeh/ui/widgets/base_switch_slider.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';
import 'package:takkeh/utils/strings.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late PageController pageController;
  bool isSignIn = true;

  @override
  void initState() {
    pageController = PageController();
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
          child: Column(
            children: [
              Image.asset(
                MyImages.logo,
                height: 150,
              ),
              BaseSwitchSlider(
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
                  children: const [
                    SignInScreen(),
                    SignUpScreen(),
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
