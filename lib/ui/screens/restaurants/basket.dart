import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/confirm_order.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/basket_products_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_suffix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class BasketScreen extends StatefulWidget {
  final int restaurantId;

  const BasketScreen({
    Key? key,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<BasketScreen> createState() => _BasketScreenState();
}

class _BasketScreenState extends State<BasketScreen> {
  final keys = [];
  late TextEditingController noteCtrl;
  // final myKey = GlobalKey<BasketProductTileState>();
  // //     print("value:: ${myKey.currentState!.counter}");

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
                  MakeOrderCtrl.fetchMakeOrderData(
                    context: context,
                    restaurantId: widget.restaurantId,
                    generalNote: noteCtrl.text,
                    route: ConfirmOrderScreen(
                      orderId: MakeOrderCtrl.orderId!,
                    ),
                  );
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
            child: GetBuilder<UserOrderCtrl>(
              builder: (controller) {
                return ListView(
                  padding: const EdgeInsets.only(bottom: 100, top: 10),
                  children: [
                    ...List.generate(
                      MakeOrderCtrl.model!.data!.products!.length,
                      (index) {
                        keys.add(GlobalKey<BasketProductTileState>());
                        final data = MakeOrderCtrl.model!.data!.products![index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 30),
                          child: BasketProductTile(
                            key: keys[index],
                            imageUrl: kFakeImage,
                            title: data.productName!,
                            index: index,
                            subTitle: data.productName!,
                            initialQuantity: data.quantity!,
                            description: data.productName!,
                            initialPrice: data.price!.toDouble(),
                            note: data.note!,
                            size: data.sizeId!,
                            extras: data.extras!.map((element) {
                              return Text('+ ${element.name!}');
                            }).toList(),
                            productId: data.productId!,
                            restaurantId: widget.restaurantId,
                            test: data.extras!,
                          ),
                        );
                      },
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                        controller: noteCtrl,
                        keyboardType: TextInputType.multiline,
                        hintText: "do_you_have_notes_key",
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
                            height: 50,
                            child: ListView.separated(
                              physics: const BouncingScrollPhysics(),
                              padding: const EdgeInsets.symmetric(horizontal: 10),
                              separatorBuilder: (context, index) => const SizedBox(width: 5),
                              scrollDirection: Axis.horizontal,
                              // shrinkWrap: true,
                              itemCount: 10,
                              itemBuilder: (context, index) {
                                return ChoiceChip(
                                  shape: RoundedRectangleBorder(
                                    side: const BorderSide(color: MyColors.grey9F4),
                                    borderRadius: BorderRadius.circular(20),
                                  ),
                                  disabledColor: Colors.transparent,
                                  selectedColor: MyColors.primary,
                                  label: const Text('label'),
                                  selected: false,
                                );
                              },
                            ),
                          ),
                        ),
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30),
                      child: CustomTextField(
                        hintText: TranslationService.getString('enter_coupon_num_key'),
                        minLines: 1,
                        maxLines: 1,
                        prefixIcon: const CustomPrefixIcon(
                          icon: MyIcons.ticketBlack,
                        ),
                        suffixIcon: CustomSuffixIcon(
                          title: TranslationService.getString('send_key'),
                          icon: MyIcons.ticketBlack,
                          onTap: () {},
                        ),
                        //TODO: check later
                        maxSuffixWidth: 100,
                      ),
                    ),
                    const Divider(
                      height: 30,
                      indent: 45,
                      endIndent: 45,
                    ),
                    Padding(
                      padding: const EdgeInsetsDirectional.fromSTEB(30, 10, 0, 20),
                      child: Text(
                        TranslationService.getString('order_details_key'),
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 30.0),
                      child: OrderDetailsWidget(
                        productName: MakeOrderCtrl.model!.data!.products!,
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
