import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/order_status_screen.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/constants.dart';

class OrderFABButton extends StatelessWidget {
  final FireOrderDetails data;

  const OrderFABButton({
    Key? key,
    required this.data,
  }) : super(key: key);

  static final finished = [
    kCompleted,
    kCanceled,
    kCanceled0,
    kDenied,
  ];

  //hold بانتظار القبول
  //pending جاري التحضير
  // kWayToDropPoint or > جاري التوصيل

  String _getStatus(String status) {
    if (status == kHold) {
      return 'ينتظر القبول';
    } else if (status == kPending) {
      return 'جاري البحث';
    } else if (status == kWayToPickUpPoint) {
      return 'في الطريق';
    } else if (status == kArrivedToPickUpPoint) {
      return 'متواجد';
    } else if (status == kAtPickUpPoint) {
      return 'جاري الإستلام';
    } else if (status == kWayToDropPoint) {
      return 'تم الإستلام';
    } else if (status == kCollectingMoney || status == kArrivedToDropPoint) {
      return 'جاري التوصيل';
    } else if (status == kCompleted) {
      return 'مكتمل';
    } else if (status == kCanceled || status == kCanceled0) {
      return 'تم الإلغاء';
    } else if (status == kDenied) {
      return 'مرفوض';
    }
    return '';
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.to(() => OrderStatusScreen(orderId: data.orderId, route: kBack));
      },
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
        margin: const EdgeInsets.symmetric(horizontal: 20.0),
        decoration: BoxDecoration(
          color: MyColors.text.withOpacity(0.80),
          borderRadius: BorderRadius.circular(17),
        ),
        child: Row(
          children: [
            CircleAvatar(
              radius: 30,
              backgroundColor: MyColors.text,
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Expanded(
                      child: Text(
                        "33",
                        style: TextStyle(fontSize: 24, color: MyColors.white),
                      ),
                    ),
                    FittedBox(
                      child: Text(
                        kMinute,
                        style: const TextStyle(fontSize: 12, color: MyColors.white),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  RichText(
                    text: TextSpan(
                      style: DefaultTextStyle.of(context).style,
                      children: <TextSpan>[
                        TextSpan(
                          text: TranslationService.getString('your_order_from'),
                          style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 18, color: MyColors.white),
                        ),
                        TextSpan(
                          text: ' ${data.pickUpPointName} ',
                          style: const TextStyle(color: MyColors.primary, fontSize: 18),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    _getStatus(data.status),
                    style: const TextStyle(fontSize: 18, color: MyColors.white),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
