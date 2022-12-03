import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/utils/app_constants.dart';

class FullOrderDetailsBox extends StatelessWidget {
  final String paymentMethod;
  final double total, tax, deliveryFee, discount, orderValue;

  const FullOrderDetailsBox({
    Key? key,
    required this.total,
    required this.tax,
    required this.deliveryFee,
    required this.paymentMethod,
    required this.discount,
    required this.orderValue,
  }) : super(key: key);

  static Widget _getText(
    String text,
    String value, {
    bool withCurrency = true,
  }) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 3.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            TranslationService.getString(text),
            style: const TextStyle(fontSize: 14),
          ),
          withCurrency
              ? Text(
                  '$value $kPCurrency',
                )
              : Text(
                  value,
                )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _getText('total_key', total.toString()),
        _getText('tax_key', tax.toString()),
        _getText('delivery_fee_key', deliveryFee.toString()),
        _getText('payment_method_key', paymentMethod.toString(), withCurrency: false),
        _getText('discount_key', discount.toString()),
        _getText('order_value_key', orderValue.toString()),
      ],
    );
  }
}
