import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class DeliveryInfoBox extends StatelessWidget {
  final String address;

  const DeliveryInfoBox({
    Key? key,
    required this.address,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 8),
      decoration: const BoxDecoration(
        color: MyColors.blue6FB,
        borderRadius: BorderRadius.vertical(bottom: Radius.circular(20)),
      ),
      width: double.infinity,
      alignment: Alignment.center,
      child: Row(
        children: [
          SvgPicture.asset(MyIcons.pinClassic),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              address,
              style: const TextStyle(
                color: MyColors.grey070,
                fontSize: 14,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          // Expanded(
          //   child: SizedBox(
          //     width: 200,
          //     height: 35,
          //     child: Text(
          //       address,
          //       style: const TextStyle(
          //         color: MyColors.grey070,
          //         fontSize: 14,
          //       ),
          //       maxLines: 2,
          //       overflow: TextOverflow.ellipsis,
          //     ),
          //   ),
          // ),
          // TextButton(
          //   onPressed: () {
          //     Get.defaultDialog(
          //       title: "",
          //       titleStyle: const TextStyle(fontSize: 0),
          //       contentPadding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          //       titlePadding: EdgeInsets.zero,
          //       content: const PickAddressDialog(),
          //     );
          //   },
          //   style: TextButton.styleFrom(
          //     textStyle: const TextStyle(color: MyColors.redPrimary),
          //   ),
          //   child: Text(
          //     TranslationService.getString('change_key'),
          //     style: const TextStyle(color: MyColors.redPrimary),
          //   ),
          // ),
        ],
      ),
    );
  }
}
