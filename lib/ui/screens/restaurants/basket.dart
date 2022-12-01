import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/restaurants/add_promo_code_ctrl.dart';
import 'package:takkeh/controller/restaurants/make_order.dart';
import 'package:takkeh/controller/restaurants/promo_codes_ctrl.dart';
import 'package:takkeh/model/restaurants/promo_codes_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
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

  final myList = [
    {
      "id": 18,
      "product_id": 18,
      "product_name": "بيج تيستي",
      "product_image": "img/products/BigTasty-Classic.jpg",
      "quantity": 1,
      "items": [
        {"id": 653, "group_name": "Size", "group_type": "required", "item_name": "smaill", "price": "10.00"}
      ],
      "note": "",
      "area": null,
      "price": "15.00"
    },
    {
      "id": 17,
      "product_id": 17,
      "product_name": "ماك تشكن سبايسي",
      "product_image": "img/products/mcd2.jpg",
      "quantity": 2,
      "items": [
        {"id": 654, "group_name": "Size", "group_type": "required", "item_name": "big", "price": "20.00"}
      ],
      "note": "",
      "area": null,
      "price": "50.00"
    },
    {
      "id": 16,
      "product_id": 16,
      "product_name": "kfc",
      "product_image": "img/products/mcd2.jpg",
      "quantity": 2,
      "items": [
        {"id": 654, "group_name": "Size", "group_type": "required", "item_name": "big", "price": "20.00"}
      ],
      "note": "",
      "area": null,
      "price": "50.00"
    },
    {
      "id": 15,
      "product_id": 15,
      "product_name": "kfc",
      "product_image": "img/products/mcd2.jpg",
      "quantity": 2,
      "items": [
        {"id": 654, "group_name": "Size", "group_type": "required", "item_name": "big", "price": "20.00"}
      ],
      "note": "",
      "area": null,
      "price": "50.00"
    }
  ];

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
                  print('status:: ${MakeOrderCtrl.find.orderList.length}');
                  // MakeOrderCtrl.find.orderList.removeAt(0);
                  // Get.to(() => ConfirmOrderScreen(orderId: widget.orderId));
                  // MakeOrderCtrl.find.fetchData(
                  //   context: context,
                  //   restaurantId: widget.restaurantId,
                  //   generalNote: noteCtrl.text,
                  //   // route: ConfirmOrderScreen(
                  //   //   orderId: MakeOrderCtrl.orderId!,
                  //   // ),
                  // );
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
              padding: const EdgeInsets.only(bottom: 100, top: 10),
              children: [
                // ListView.builder(
                //     shrinkWrap: true,
                //     itemCount: myList.length,
                //     itemBuilder: (context, index) {
                //       final data = myList[index];
                //       return GestureDetector(
                //         onTap: () {
                //           setState(() {
                //             myList.remove(data);
                //           });
                //           print("test:: $myList");
                //         },
                //         child: Container(
                //           height: 100,
                //           margin: const EdgeInsets.all(10),
                //           color: Colors.orange,
                //           child: Column(
                //             mainAxisAlignment: MainAxisAlignment.center,
                //             children: [
                //               Text("$index"),
                //               Text("${data['product_id']}"),
                //               Text("${data['quantity']}"),
                //               Text("${data['product_name']}"),
                //             ],
                //           ),
                //         ),
                //       );
                //     }),
                // ...myList.map((element) {
                //   final index = myList.indexOf(element);
                //   return GestureDetector(
                //     onTap: () {
                //       setState(() {
                //         // print("test:: ${myList.elementAt(index)}");
                //         myList.removeWhere((value) => value["product_id"] == element["product_id"]);
                //       });
                //     },
                //     child: Container(
                //       height: 100,
                //       margin: const EdgeInsets.all(10),
                //       color: Colors.orange,
                //       child: Column(
                //         mainAxisAlignment: MainAxisAlignment.center,
                //         children: [
                //           Text("$index"),
                //           Text("${element['product_id']}"),
                //           Text("${element['quantity']}"),
                //           Text("${element['product_name']}"),
                //         ],
                //       ),
                //     ),
                //   );
                // }).toList(),
                Obx(() {
                  return ListView.builder(
                      shrinkWrap: true,
                      itemCount: MakeOrderCtrl.find.orderList.length,
                      itemBuilder: (context, index) {
                        final data = MakeOrderCtrl.find.orderList[index];
                        print("test:: $index -- ${data.id}");
                        return GestureDetector(
                            onTap: () {
                              // print("element:: ${MakeOrderCtrl.find.orderList[0].id} ${MakeOrderCtrl.find.orderList[1].id}");
                              MakeOrderCtrl.find.orderList.removeAt(index);
                              // print("index:: ${MakeOrderCtrl.find.orderList[0].id} ${MakeOrderCtrl.find.orderList[0].productName}");
                            },
                            child: Container(
                              margin: const EdgeInsets.all(10),
                              height: 100,
                              color: Colors.orange,
                              child: Column(
                                children: [
                                  Text("$index"),
                                  Text("${data.productId}"),
                                  Text("${data.productName}"),
                                  Text("${data.quantity}"),
                                ],
                              ),
                            ));
                      });
                }),
                //TODO: fix dialog bug
                // ...MakeOrderCtrl.find.orderList.map((element) {
                //   final index = MakeOrderCtrl.find.orderList.indexOf(element);
                //   return Padding(
                //     padding: const EdgeInsets.symmetric(horizontal: 25),
                //     child: GestureDetector(
                //       onTap: () {
                //         print("index:: $index");
                //       },
                //       child: BasketProductTile(
                //         imageUrl: element.productImage!,
                //         title: element.productName!,
                //         index: index,
                //         subTitle: element.productName!,
                //         initialQuantity: element.quantity!,
                //         description: element.productName!,
                //         initialPrice: element.price!.toDouble(),
                //         note: element.note!,
                //         productId: element.productId!,
                //         restaurantId: widget.restaurantId,
                //         items: element.items!,
                //         element: element,
                //       ),
                //     ),
                //   );
                // }).toList(),
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
                                            return ChoiceChip(
                                              onSelected: null,
                                              shape: RoundedRectangleBorder(
                                                side: const BorderSide(color: MyColors.grey9F4),
                                                borderRadius: BorderRadius.circular(20),
                                              ),
                                              disabledColor: Colors.transparent,
                                              selectedColor: MyColors.redPrimary,
                                              label: Text(
                                                data.code!,
                                              ),
                                              selected: false,
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
                                    //TODO: check later
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

// BasketProductTile(
// imageUrl: data.productImage!,
// title: data.productName!,
// index: index,
// subTitle: data.productName!,
// initialQuantity: data.quantity!,
// description: data.productName!,
// initialPrice: data.price!.toDouble(),
// note: data.note!,
// productId: data.productId!,
// restaurantId: widget.restaurantId,
// items: data.items!,
// element: data,
// ),
