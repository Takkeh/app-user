import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/model/notification/notification_model.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class NotificationsBox extends StatelessWidget {
  final List<NotificationModel> notifications;
  final String day;
  final int itemCount;
  final Function() onTap;

  const NotificationsBox(
      {Key? key,
      required this.notifications,
      required this.itemCount,
      required this.onTap,
      required this.day})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w500,
          ),
        ),
        ListView.separated(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          separatorBuilder: (context, index) => const SizedBox(height: 10),
          itemCount: itemCount,
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: onTap,
              child: Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(17),
                  color: const Color(0xFFFDFDFE),
                ),
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: MyColors.primary.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: SvgPicture.asset(
                        notifications[index].type == 'promo'
                            ? MyIcons.ticket
                            : MyIcons.handUp,
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            notifications[index].title,
                            style: const TextStyle(
                              color: MyColors.text,
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                          Text(
                            notifications[index].content,
                            style: const TextStyle(
                              fontSize: 16,
                              color: MyColors.grey070,
                            ),
                          ),
                          const SizedBox(height: 7),
                          Row(
                            children: [
                              SvgPicture.asset(MyIcons.clockWhite),
                              const SizedBox(width: 5),
                              Padding(
                                padding: const EdgeInsets.only(top: 2.5),
                                child: Text(
                                  '${notifications[index].createdAt.toDate().day}',
                                  style: const TextStyle(
                                    color: MyColors.greyEB3,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    const Icon(
                      Icons.navigate_next,
                      color: MyColors.text,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
