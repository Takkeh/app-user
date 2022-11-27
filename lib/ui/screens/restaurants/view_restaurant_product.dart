import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/controller/view_product_ctrl.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/optional_check_box_2.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/product_counter.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/required_check_box_2.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/view_product_app_bar.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class ViewRestaurantProductScreen extends StatefulWidget {
  final String title, subTitle;
  final double price;
  final String cover;
  final int productId;
  final int restaurantId;
  final List<Groups> groups;

  const ViewRestaurantProductScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.cover,
    required this.productId,
    required this.restaurantId,
    required this.groups,
  }) : super(key: key);

  @override
  State<ViewRestaurantProductScreen> createState() => _ViewRestaurantProductScreenState();
}

class _ViewRestaurantProductScreenState extends State<ViewRestaurantProductScreen> {
  late TextEditingController noteCtrl;

  bool isAlreadyExist(List<Map<String, dynamic>> groups) {
    var data =
        UserOrderCtrl.find.orderList.where((element) => element['product_id'] == widget.productId && element["note"] == noteCtrl.text.trim() && element["groups"].toString() == groups.toString());
    if (data.isEmpty) return false;
    data.first.update('price', (value) => value + ViewProductCtrl.find.finalPrice.value);
    data.first.update('quantity', (value) => value + ViewProductCtrl.find.quantity.value);
    log('userOrder:: ${UserOrderCtrl.find.orderList}');
    return true;
  }

  void addItem() {
    var groupsList = [
      ...List<Map<String, dynamic>>.from(ViewProductCtrl.find.requiredGroupList.map((element) => jsonDecode(element)).toList()),
      ...List<Map<String, dynamic>>.from(ViewProductCtrl.find.optionalGroupList.map((element) => jsonDecode(element)).toList()),
    ];
    if (isAlreadyExist(groupsList)) return;
    UserOrderCtrl.find.orderList.add({
      "product_id": widget.productId,
      "quantity": ViewProductCtrl.find.quantity.value,
      "note": noteCtrl.text.trim(),
      "area": "",
      "price": ViewProductCtrl.find.finalPrice.value,
      "groups": groupsList,
    });
    log('userOrder:: ${UserOrderCtrl.find.orderList}');
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
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
        child: showFab
            ? CustomFABButton(
                title: TranslationService.getString('add_to_cart_key'),
                onPressed: () {
                  if (ViewProductCtrl.find.requiredGroupList.isEmpty) {
                    if (Get.isSnackbarOpen) {
                      Get.closeCurrentSnackbar();
                    }
                    //TODO: specify the required field and scroll to it for next version
                    Get.snackbar(
                      TranslationService.getString('required_field_key'),
                      TranslationService.getString('check_required_field_key'),
                      colorText: Colors.white,
                      margin: const EdgeInsets.all(10.0),
                      backgroundColor: MyColors.redPrimary,
                    );
                    return;
                  }
                  UserOrderCtrl.find.calculateTotalPrice(ViewProductCtrl.find.finalPrice.value, status: 'add');
                  UserOrderCtrl.find.calculateTotalQuantity(ViewProductCtrl.find.quantity.value, status: 'add');
                  addItem();
                  Get.back(closeOverlays: true);
                },
              )
            : null,
      ),
      body: CustomScrollView(
        slivers: [
          ViewProductAppBar(
            imageUrl: widget.cover,
          ),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
            sliver: SliverList(
              delegate: SliverChildListDelegate(
                [
                  Text(
                    widget.title,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  Text(
                    widget.subTitle,
                    style: const TextStyle(
                      fontSize: 16,
                      color: MyColors.grey070,
                    ),
                  ),
                  ProductCounter(price: widget.price),
                  const Divider(),
                  ListView.separated(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    separatorBuilder: (context, index) => const SizedBox(height: 18),
                    itemCount: widget.groups.length,
                    itemBuilder: (context, index) {
                      final data = widget.groups[index];
                      return GetBuilder<ViewProductCtrl>(
                        builder: (controller) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                data.name!,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                              if (data.type == 'required')
                                RequiredCheckBox2(
                                  items: data.items!,
                                  groupId: data.id!,
                                ),
                              //TODO: ask if it's opp
                              if (data.type == 'opp' || data.type == 'remove')
                                OptionalCheckBox2(
                                  items: data.items!,
                                  groupId: data.id!,
                                ),
                            ],
                          );
                        },
                      );
                    },
                  ),
                  // Text(
                  //   TranslationService.getString('chose_from_key'),
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // //TODO: sizes and extras, some has price some don't. handle with alaa
                  // ...List.generate(
                  //   widget.sizes.length,
                  //   (index) {
                  //     return CustomCheckBox(
                  //       title: widget.sizes[index].name!,
                  //       price: widget.sizes[index].price!.toDouble(),
                  //       shape: const CircleBorder(),
                  //       trailing: index == 0 ? Text('${widget.sizes[index].price!.toDouble()}') : Text('+ ${widget.sizes[index].price!.toDouble()} $kPCurrency'),
                  //       onChanged: (value) {
                  //         var id = widget.sizes[index].restaurantId;
                  //         setState(() {
                  //           if (sizeId == id) {
                  //             sizeId = null;
                  //             counterKey.currentState!.price = counterKey.currentState!.price - widget.sizes[index].price!.toDouble();
                  //             return;
                  //           }
                  //           sizeId = id;
                  //           counterKey.currentState!.price = counterKey.currentState!.price + widget.sizes[index].price!.toDouble();
                  //         });
                  //       },
                  //       value: sizeId == widget.sizes[index].restaurantId ? true : false,
                  //     );
                  //   },
                  // ),
                  // const SizedBox(height: 20),
                  // Text(
                  //   TranslationService.getString('extras_key'),
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //     fontWeight: FontWeight.w500,
                  //   ),
                  // ),
                  // ...List.generate(
                  //   widget.extras.length,
                  //   (index) {
                  //     return CustomCheckBox(
                  //       title: widget.extras[index].name!,
                  //       price: 80.0,
                  //       shape: null,
                  //       trailing: index == 0 ? Text('${widget.extras[index].price!.toDouble()}') : Text('+ ${widget.extras[index].price!.toDouble()} $kPCurrency'),
                  //       onChanged: (value) {
                  //         var id = widget.extras[index].restaurantId!;
                  //         setState(() {
                  //           if (extrasTest.contains(id)) {
                  //             extrasTest.remove(id);
                  //           } else {
                  //             extrasTest.add(id);
                  //           }
                  //         });
                  //         print("extras:: $extrasTest");
                  //       },
                  //       value: extrasTest.contains(widget.extras[index].restaurantId!),
                  //       // value: true,
                  //     );
                  //   },
                  // ),
                  Padding(
                    padding: const EdgeInsets.only(top: 20.0),
                    child: CustomTextField(
                      controller: noteCtrl,
                      keyboardType: TextInputType.multiline,
                      hintText: "Do you have any Notes ?",
                      minLines: 1,
                      maxLines: 3,
                      prefixIcon: const CustomPrefixIcon(
                        icon: MyIcons.notes,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
