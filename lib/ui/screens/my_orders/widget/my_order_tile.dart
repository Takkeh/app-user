import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class MyOrderTile extends StatelessWidget {
  final Function() onTap;
  final String name, id, logo;
  final DateTime date;
  const MyOrderTile({
    Key? key,
    required this.onTap,
    required this.name,
    required this.id,
    required this.date,
    required this.logo,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          color: const Color(0xFFFDFDFE),
        ),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            CustomNetworkImage(
              url: logo,
              radius: 10,
              width: 80,
              height: 80,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "#$id",
                    style: const TextStyle(
                      color: MyColors.text,
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  Text(
                    name,
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
                          DateFormat('a h:mm dd.MM.yyyy').format(date),
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
  }
}
