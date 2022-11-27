import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/controller/restaurants/update_order_ctrl.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_suffix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/map_bubble.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class ConfirmOrderScreen extends StatefulWidget {
  final int orderId;

  const ConfirmOrderScreen({
    Key? key,
    required this.orderId,
  }) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  late GoogleMapController mapController;

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

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
                  UpdateOrderCtrl().fetchUpdateOrderData(orderId: widget.orderId, context: context);
                  // UpdateOrderCtrl.fetchUpdateOrderData(orderId: widget.orderId, context: context);
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
          const GradientColorsBox(height: 136),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              children: [
                const MapBubbleBuilder(visible: true),
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
                  height: 30,
                  indent: 15,
                  endIndent: 15,
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
                  indent: 15,
                  endIndent: 15,
                ),
                const SizedBox(height: 15),
                Text(
                  TranslationService.getString('order_details_key'),
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w500,
                  ),
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

class OrderDetailsWidget extends StatelessWidget {
  final List productName;

  const OrderDetailsWidget({
    Key? key,
    required this.productName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserOrderCtrl>(builder: (controller) {
      return Column(
        children: [
          ...controller.orderList.map((element) {
            final index = controller.orderList.indexOf(element);
            return Row(
              children: [
                Text("x${element['quantity']}", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
                const SizedBox(width: 16),
                Text(productName[index].productName, style: const TextStyle(fontSize: 16)),
                const Spacer(),
                Text("${element['price']} $kPCurrency", style: const TextStyle(fontSize: 16)),
              ],
            );
          }).toList(),
          const Divider(
            height: 30,
            indent: 10,
            endIndent: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text("total", style: TextStyle(fontSize: 16)),
              Text("${controller.totalPrice.value} $kPCurrency", style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500)),
            ],
          ),
        ],
      );
    });
  }
}
