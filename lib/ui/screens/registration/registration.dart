import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/screens/registration/sign_in.dart';
import 'package:takkeh/ui/screens/registration/sign_up.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({Key? key}) : super(key: key);

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  late PageController pageController;
  int currentIndex = 0;

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
              Container(
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                width: double.infinity,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: MyColors.grey5FA,
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Sign in".tr,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          pageController.jumpToPage(0);
                        },
                        color: currentIndex == 0 ? MyColors.primary : Colors.transparent,
                      ),
                    ),
                    const SizedBox(width: 15),
                    Expanded(
                      child: CustomElevatedButton(
                        title: "Sign Up".tr,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          pageController.jumpToPage(1);
                        },
                        color: currentIndex == 1 ? MyColors.primary : Colors.transparent,
                      ),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: PageView(
                  onPageChanged: (value) {
                    setState(() {
                      currentIndex = value;
                    });
                  },
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
