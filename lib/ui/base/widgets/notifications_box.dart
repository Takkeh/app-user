import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class NotificationsBox extends StatelessWidget {
  final String day, icon, title, description, subTitle, time;
  final int itemCount;
  final Function() onTap;

  const NotificationsBox({
    Key? key,
    required this.day,
    required this.itemCount,
    required this.onTap,
    required this.icon,
    required this.title,
    required this.description,
    required this.subTitle,
    required this.time,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          day,
          style: const TextStyle(
            fontSize: 20,
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
                  color: const Color(0xFFFAF5E6),
                ),
                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      width: 80,
                      height: 80,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        //TODO: ask for color
                        color: MyColors.redD4F.withOpacity(0.50),
                        borderRadius: BorderRadius.circular(9.0),
                      ),
                      child: SvgPicture.asset(icon),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            title,
                            style: const TextStyle(
                              color: MyColors.text,
                              fontSize: 18,
                            ),
                          ),
                          Text(
                            subTitle,
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
                                  time,
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
