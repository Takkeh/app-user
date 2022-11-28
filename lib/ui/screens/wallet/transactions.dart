import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/base/widgets/notifications_box.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';

class TransactionsScreen extends StatelessWidget {
  const TransactionsScreen({Key? key}) : super(key: key);

  //TODO: image when is empty
  static const isEmpty = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      appBar: TransparentAppBar(
        title: TranslationService.getString('transactions_key'),
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
                /// TODO: fix later
                // return NotificationsBox(
                //   day: "Yesterday",
                //   itemCount: 5,
                //   onTap: () {},
                //   icon: MyIcons.handUp,
                //   title: "title",
                //   description: "description",
                //   subTitle: "subTitle",
                //   time: "time",
                // );
                return SizedBox();
              },
            ),
    );
  }
}
