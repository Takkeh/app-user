import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/notification/notification_ctrl.dart';
import 'package:takkeh/ui/base/widgets/notifications_box.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
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
                          style: TextStyle(
                              fontSize: 20, fontWeight: FontWeight.w700),
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
              : FutureBuilder(
                  future: NotificationCtrl.find.getData(),
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const Center(
                          child: CircularProgressIndicator(),
                        );
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                                const SizedBox(height: 30),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 30, vertical: 30),
                            itemCount: 3,
                            itemBuilder: (context, index) {
                              return NotificationsBox(
                                day: NotificationCtrl.find.filter[index],
                                itemCount: snapshot.data![index].length,
                                onTap: () {},
                                notifications: snapshot.data![index],
                              );
                            },
                          );
                        } else {
                          return const FailedWidget();
                        }
                    }
                  },
                ),
        ),
      ],
    );
  }
}
