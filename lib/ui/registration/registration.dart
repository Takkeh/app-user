import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/registration//sign_in.dart';
import 'package:takkeh/ui/registration//sign_up.dart';
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
              Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(top: 20, bottom: 40),
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                width: Get.width,
                height: 80,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  color: Colors.teal,
                ),
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    AnimatedAlign(
                      alignment: isSignIn ? const Alignment(-1, 0) : const Alignment(1, 0),
                      duration: const Duration(seconds: 1),
                      curve: Curves.fastOutSlowIn,
                      child: CustomElevatedButton(
                        title: " ".tr,
                        onPressed: () {
                          FocusManager.instance.primaryFocus?.unfocus();
                          pageController.jumpToPage(1);
                        },
                        color: MyColors.primary,
                      ),
                    ),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignIn = true;
                              });
                            },
                            child: const Align(
                              alignment: Alignment(-0.65, 0),
                              child: Text(
                                "Sign In",
                                style: TextStyle(
                                  color: MyColors.black109,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 20),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                isSignIn = false;
                              });
                            },
                            child: Container(
                              color: Colors.red,
                              alignment: const Alignment(0.65, 0),
                              child: const Text(
                                "Sign Up",
                                style: TextStyle(
                                  color: MyColors.black109,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    // Align(
                    //   alignment: const Alignment(0.65, 0),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         isSignIn = true;
                    //       });
                    //     },
                    //     child: const Text(
                    //       "Sign Up",
                    //       style: TextStyle(
                    //         color: MyColors.black109,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                    // Align(
                    //   alignment: const Alignment(-0.65, 0),
                    //   child: GestureDetector(
                    //     onTap: () {
                    //       setState(() {
                    //         isSignIn = false;
                    //       });
                    //     },
                    //     child: const Text(
                    //       "Sign in",
                    //       style: TextStyle(
                    //         color: MyColors.black109,
                    //         fontSize: 16,
                    //         fontWeight: FontWeight.w500,
                    //       ),
                    //     ),
                    //   ),
                    // ),
                  ],
                ),
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
