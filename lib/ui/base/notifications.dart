import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/base/widgets/notifications_box.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';

class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({Key? key}) : super(key: key);

  static const isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.bottomCenter,
      children: [
        Container(
          alignment: Alignment.bottomCenter,
          color: MyColors.blue6FA,
          height: Get.height,
          child: Image.asset(
            MyImages.handUpTransparent,
            height: 300,
          ),
        ),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: const TransparentAppBar(
            title: "Notifications",
          ),
          body: isEmpty
              ? Padding(
                  padding: const EdgeInsets.all(35),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(MyImages.notifications),
                      const Padding(
                        padding: EdgeInsets.only(top: 50.0, bottom: 10),
                        child: Text(
                          "You have no notifications for now",
                          style: TextStyle(fontSize: 20, fontWeight: FontWeight.w700),
                        ),
                      ),
                      const Text(
                        "Notifications will appear here when you receive them",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                )
              : ListView.separated(
                  separatorBuilder: (context, index) => const SizedBox(height: 30),
                  padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                  itemCount: 3,
                  itemBuilder: (context, index) {
                    return NotificationsBox(
                      day: "Yesterday",
                      itemCount: 5,
                      onTap: () {},
                      icon: MyIcons.handUp,
                      title: "title",
                      description: "description",
                      subTitle: "subTitle",
                      time: "time",
                    );
                  },
                ),
        ),
      ],
    );
  }
}
