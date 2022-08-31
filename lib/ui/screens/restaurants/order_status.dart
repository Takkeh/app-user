import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/captain_widget.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_address_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_status_text.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/order_time_line.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/images.dart';

class OrderStatusScreen extends StatelessWidget {
  const OrderStatusScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(
        title: TranslationService.getString('#1856841'),
      ),
      body: Column(
        children: [
          const GradientColorsBox(height: 136),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                Image.asset(MyImages.driver),
                const SizedBox(height: 20),
                const OrderStatusText(),
                const OrderTimeLine(),
                const Divider(
                  height: 30,
                  indent: 15,
                  endIndent: 15,
                ),
                const OrderAddressTile(),
                const Divider(
                  height: 30,
                  indent: 15,
                  endIndent: 15,
                ),
                const CaptainWidget(),
                const Divider(
                  height: 30,
                  indent: 15,
                  endIndent: 15,
                ),
                Text(
                  TranslationService.getString('order_details_key'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                Column(
                  children: [
                    Row(
                      children: const [
                        Text("x1", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                        SizedBox(width: 16),
                        Text("max chicken", style: TextStyle(fontSize: 16)),
                        Spacer(),
                        Text("22 $kPCurrency", style: TextStyle(fontSize: 16)),
                      ],
                    ),
                    const Divider(
                      height: 30,
                      indent: 10,
                      endIndent: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: const [
                        Text("total", style: TextStyle(fontSize: 16)),
                        Text("22 $kPCurrency", style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
