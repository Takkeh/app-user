import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/restaurants/update_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/confirm_order_map_bubble.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_suffix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/order_details_box.dart';
import 'package:takkeh/ui/widgets/order_item.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class ConfirmOrderScreen extends StatelessWidget {
  final int orderId;

  const ConfirmOrderScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      extendBodyBehindAppBar: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: showFab
            ? CustomFABButton(
                title: TranslationService.getString('confirm_order_key'),
                onPressed: () {
                  UpdateOrderCtrl().fetchUpdateOrderData(orderId: orderId, context: context);
                },
              )
            : null,
      ),
      appBar: TransparentAppBar(
        title: TranslationService.getString('confirm_order_key'),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientColorsBox(height: 120),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.fromLTRB(30, 10, 30, 80),
              children: [
                const ConfirmOrderMapBubble(),
                // const MapBubbleBuilder(route: kAddress),
                const SizedBox(height: 20),
                CustomTextField(
                  hintText: '30 - 40 min',
                  minLines: 1,
                  maxLines: 1,
                  prefixIcon: const CustomPrefixIcon(
                    icon: MyIcons.scooter,
                  ),
                  minSuffixWidth: 120,
                  maxSuffixWidth: 122,
                  readOnly: true,
                  suffixIcon: CustomSuffixIcon(
                    title: TranslationService.getString('pre_order_key'),
                    icon: MyIcons.scooter,
                    onTap: () {
                      Fluttertoast.showToast(msg: "Coming Soon!", backgroundColor: MyColors.grey070);
                    },
                  ),
                ),
                const Divider(
                  thickness: 1.2,
                  height: 30,
                  indent: 18,
                  endIndent: 18,
                ),
                Text(
                  TranslationService.getString('pay_by_key'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                ListTile(
                  horizontalTitleGap: 0,
                  contentPadding: EdgeInsets.zero,
                  title: Text(TranslationService.getString("cash_only_key")),
                  leading: Transform.scale(
                    scale: 1.2,
                    child: SizedBox(
                      height: 24,
                      width: 24,
                      child: Checkbox(
                        fillColor: MaterialStateProperty.all(MyColors.redPrimary),
                        side: const BorderSide(color: MyColors.redPrimary),
                        materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                        shape: const CircleBorder(),
                        value: true,
                        onChanged: null,
                      ),
                    ),
                  ),
                ),
                const Divider(
                  thickness: 1.2,
                  indent: 18,
                  endIndent: 18,
                ),
                const SizedBox(height: 20),
                Text(
                  TranslationService.getString('order_details_key'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                GetX<MakeOrderCtrl>(
                  builder: (controller) {
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: controller.orderList.length,
                      shrinkWrap: true,
                      itemBuilder: (context, index) {
                        final data = controller.orderList[index];
                        return OrderItem(
                          count: data.quantity!,
                          price: data.price!,
                          title: data.productName!,
                        );
                      },
                    );
                  },
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(vertical: 9, horizontal: 18),
                  child: Divider(thickness: 1.2),
                ),
                const FullOrderDetailsBox(
                  tax: 5.0,
                  total: 99.0,
                  paymentMethod: 'cash',
                  orderValue: 55.01,
                  discount: 44.0,
                  deliveryFee: 33.0,
                ),
                // OrderDetailsWidget(
                //   productName: MakeOrderCtrl.model!.data!.products!,
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
