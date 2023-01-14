import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/log_out.dart';
import 'package:takkeh/ui/base/drawer/guest_drawer.dart';
import 'package:takkeh/ui/base/drawer/user_drawer.dart';
import 'package:takkeh/ui/base/widgets/drawer_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

enum LanguageEnum { english, arabic }

class BaseDrawer extends StatefulWidget {
  const BaseDrawer({Key? key}) : super(key: key);

  @override
  State<BaseDrawer> createState() => _BaseDrawerState();
}

class _BaseDrawerState extends State<BaseDrawer> {
  @override
  void initState() {
    Get.lazyPut(() => LogOutController());
    super.initState();
  }

  @override
  void dispose() {
    Get.delete<LogOutController>();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    print("isLogIn:: ${MySharedPreferences.isLogIn}");
    return Scaffold(
      backgroundColor: MyColors.primary,
      appBar: const DrawerAppBar(),
      body: MySharedPreferences.isLogIn ? const UserDrawer() : const GuestDrawer(),
    );
  }
}
