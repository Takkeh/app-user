import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/binding/addresses.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/controller/restaurants/add_promo_code_ctrl.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/restaurants/promo_codes_ctrl.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/model/restaurants/promo_codes_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/addresses/add_new_address_screen.dart';
import 'package:takkeh/ui/screens/addresses/widgets/add_address_button.dart';
import 'package:takkeh/ui/screens/addresses/widgets/my_addresses_listview.dart';
import 'package:takkeh/ui/screens/addresses/widgets/no_addresses_widget.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/confirm_order.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/basket_products_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_suffix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/promo_codes_loading.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class BasketScreen extends StatefulWidget {
  final int restaurantId;
  final int orderId;

  const BasketScreen({
    Key? key,
    required this.restaurantId,
    required this.orderId,
  }) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  late TextEditingController noteCtrl;

  void navigate() {
    LocationPermissionHelper.check(
      action: () {
        Get.to(() => ConfirmOrderScreen(orderId: widget.orderId));
      },
    );
  }

  @override
  void initState() {
    super.initState();
    noteCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    noteCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: showFab
            ? CustomFABButton(
                title: TranslationService.getString('confirm_order_key'),
                onPressed: () {
                  if (MyAddressesCtrl.find.myAddresses.isEmpty) {
                    Get.to(
                      () => const AddNewAddressScreen(),
                      binding: CreateAddressBinding(),
                    )!
                        .then((value) {
                      if (MyAddressesCtrl.find.myAddresses.isNotEmpty) {
                        navigate();
                      }
                    });
                    return;
                  }
                  navigate();
                },
              )
            : null,
      ),
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(title: TranslationService.getString('basket_key')),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const GradientColorsBox(height: 136),
          Expanded(
            child: ListView(
              padding: const EdgeInsets.only(bottom: 80, top: 10),
              children: [
                Obx(() {
                  return ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: MakeOrderCtrl.find.orderList.length,
                      itemBuilder: (context, index) {
                        final data = MakeOrderCtrl.find.orderList[index];
                        return BasketProductTile(
                          key: GlobalKey(debugLabel: '${data.id}'),
                          imageUrl: data.productImage!,
                          title: data.productName!,
                          index: index,
                          initialQuantity: data.quantity!,
                          initialPrice: data.price!.toDouble(),
                          note: data.note!,
                          productId: data.productId!,
                          restaurantId: widget.restaurantId,
                          items: data.items!,
                          element: data,
                        );
                      });
                }),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: CustomTextField(
                    controller: noteCtrl,
                    keyboardType: TextInputType.multiline,
                    hintText: TranslationService.getString('do_you_have_notes_key'),
                    minLines: 1,
                    maxLines: 3,
                    prefixIcon: const CustomPrefixIcon(
                      icon: MyIcons.notes,
                    ),
                  ),
                ),
                const Divider(
                  height: 30,
                  indent: 45,
                  endIndent: 45,
                ),
                GetBuilder<PromoCodesCtrl>(builder: (controller) {
                  return FutureBuilder<PromoCodesModel?>(
                    future: controller.initialize,
                    builder: (context, snapshot) {
                      switch (snapshot.connectionState) {
                        case ConnectionState.waiting:
                          return const PromoCodesLoading();
                        case ConnectionState.done:
                        default:
                          if (snapshot.hasData) {
                            return Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsetsDirectional.fromSTEB(30, 0, 10, 0),
                                      child: Text(
                                        TranslationService.getString('coupon_num_key'),
                                      ),
                                    ),
                                    Expanded(
                                      child: SizedBox(
                                        height: 30,
                                        child: ListView.separated(
                                          shrinkWrap: true,
                                          physics: const BouncingScrollPhysics(),
                                          padding: const EdgeInsets.symmetric(horizontal: 10),
                                          separatorBuilder: (context, index) => const SizedBox(width: 5),
                                          scrollDirection: Axis.horizontal,
                                          // shrinkWrap: true,
                                          itemCount: snapshot.data!.data!.length,
                                          itemBuilder: (context, index) {
                                            final data = snapshot.data!.data![index];
                                            return GestureDetector(
                                              onTap: () {
                                                controller.submit(data.id!, data.code!);
                                              },
                                              child: Container(
                                                alignment: Alignment.center,
                                                padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(20),
                                                  border: Border.all(color: controller.selectedPromo.value == data.id ? MyColors.redPrimary : MyColors.grey9F4),
                                                ),
                                                child: Text(
                                                  data.code!,
                                                  style: const TextStyle(color: MyColors.grey070),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(30, 10, 30, 10),
                                  child: CustomTextField(
                                    onChanged: (value) {
                                      if (value.isEmpty) {
                                        controller.selectedPromo.value = null;
                                        controller.update();
                                      }
                                    },
                                    controller: controller.promoCtrl.value,
                                    hintText: TranslationService.getString('enter_coupon_num_key'),
                                    minLines: 1,
                                    maxLines: 1,
                                    prefixIcon: const CustomPrefixIcon(
                                      icon: MyIcons.ticketBlack,
                                    ),
                                    suffixIcon: CustomSuffixIcon(
                                      title: TranslationService.getString('send_key'),
                                      icon: MyIcons.ticketBlack,
                                      onTap: () {
                                        FocusManager.instance.primaryFocus?.unfocus();
                                        AddPromoCodeCtrl.find.fetchData(4, controller.selectedPromo.value!, context);
                                      },
                                    ),
                                    maxSuffixWidth: 100,
                                  ),
                                ),
                              ],
                            );
                          } else {
                            return const FailedWidget();
                          }
                      }
                    },
                  );
                }),
                const Divider(
                  height: 30,
                  indent: 45,
                  endIndent: 45,
                ),
                GetBuilder<MyAddressesCtrl>(builder: (controller) {
                  if (controller.myAddresses.isEmpty) {
                    return const NoAddressesWidget();
                  }
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsetsDirectional.fromSTEB(30, 10, 0, 10),
                        child: Text(
                          TranslationService.getString('select_address_key'),
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      const AddNewAddressButton(
                        padding: EdgeInsets.fromLTRB(30, 10, 30, 30),
                      ),
                      const MyAddressesListViewBuilder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                      ),
                    ],
                  );
                })
                // Padding(
                //   padding: const EdgeInsets.symmetric(horizontal: 30.0),
                //   child: OrderDetailsWidget(
                //     productName: MakeOrderCtrl.model!.data!.products!,
                //   ),
                // ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
