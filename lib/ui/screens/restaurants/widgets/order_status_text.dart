import 'package:flutter/material.dart';
import 'package:takkeh/model/restaurants/order_details_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderStatusText extends StatelessWidget {
  final FireOrderDetails data;
  const OrderStatusText({Key? key, required this.data}) : super(key: key);

  static String _toggleText(FireOrderDetails data) {
    switch (data.status) {
      case kHold:
        return TranslationService.getString('order_status_text_1_key');
      case kPending:
        return TranslationService.getString('order_status_text_2_key');
      case kWayToPickUpPoint:
      case kArrivedToPickUpPoint:
      case kAtPickUpPoint:
        return TranslationService.getString('order_status_text_3_key');
      case kWayToDropPoint:
      case kArrivedToDropPoint:
      case kCollectingMoney:
        return TranslationService.getString('order_status_text_4_key');
      case kCompleted:
        return TranslationService.getString('order_status_text_5_key');
      case kCanceled:
      case kCanceled0:
        return TranslationService.getString('order_status_text_6_key');
      case kDenied:
        return TranslationService.getString('order_status_text_7_key');
      default:
        {
          return '';
        }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: AnimatedSwitcher(
        duration: const Duration(seconds: 1),
        transitionBuilder: (Widget child, Animation<double> animation) {
          return FadeTransition(opacity: animation, child: child);
        },
        child: Text(
          _toggleText(data),
          style: const TextStyle(fontSize: 18),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
