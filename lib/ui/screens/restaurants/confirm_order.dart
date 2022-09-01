import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/order_status.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_check_box.dart';
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
  const ConfirmOrderScreen({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderScreen> createState() => _ConfirmOrderScreenState();
}

class _ConfirmOrderScreenState extends State<ConfirmOrderScreen> {
  //TODO: transfer to controller later
  List<bool> choose = [false, false, false];

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
                  Get.to(() => const OrderStatusScreen());
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
                const MapBubbleBuilder(),
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
                ...List.generate(3, (index) {
                  return CustomCheckBox(
                    title: "Food",
                    price: "99.2",
                    shape: const CircleBorder(),
                    onChanged: (value) {
                      // setState(() {
                      //   for (var element in choose) {
                      //     final index = choose.indexOf(element);
                      //     choose[index] = false;
                      //   }
                      //   choose[index] = value!;
                      // });
                    },
                    value: choose[index],
                  );
                }),
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
