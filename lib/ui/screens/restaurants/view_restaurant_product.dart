import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_order_ctrl.dart';
import 'package:takkeh/model/restaurants/view_restaurant.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_check_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/product_counter.dart';
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
  //TODO: change type later
  final List<Extra> sizes;
  final List<Extra> extra;

  const ViewRestaurantProductScreen({
    Key? key,
    required this.title,
    required this.subTitle,
    required this.price,
    required this.sizes,
    required this.extra,
    required this.cover,
    required this.productId,
    required this.restaurantId,
  }) : super(key: key);

  @override
  State<ViewRestaurantProductScreen> createState() => _ViewRestaurantProductScreenState();
}

class _ViewRestaurantProductScreenState extends State<ViewRestaurantProductScreen> {
  int? sizeId;
  List<int> extrasTest = [];
  late TextEditingController noteCtrl;
  final counterKey = GlobalKey<ProductCounterState>();

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
                  Get.closeCurrentSnackbar();
                  if (sizeId == null) {
                    Get.snackbar(
                      "Choose",
                      "message",
                      colorText: Colors.white,
                      backgroundColor: MyColors.redPrimary,
                    );
                    return;
                  }
                  UserOrderCtrl.find.calculateTotal(counterKey.currentState!.price);
                  UserOrderCtrl.find.addProduct(
                    restaurantId: widget.restaurantId,
                    productId: widget.productId,
                    quantity: counterKey.currentState!.counter,
                    size: sizeId!,
                    extras: List.generate(extrasTest.length, (index) => {'extra_id': extrasTest[index]}),
                    note: noteCtrl.text,
                    price: counterKey.currentState!.price,
                    extraId: 1,
                  );
                  UserOrderCtrl.find.getProductQuantity(widget.productId);
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
                  ProductCounter(price: widget.price, key: counterKey),
                  const Divider(),
                  Text(
                    TranslationService.getString('chose_from_key'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ...List.generate(
                    widget.sizes.length,
                    (index) {
                      return CustomCheckBox(
                        title: widget.sizes[index].name!,
                        price: widget.sizes[index].price!.toDouble(),
                        shape: const CircleBorder(),
                        onChanged: (value) {
                          var id = widget.sizes[index].id;
                          setState(() {
                            if (sizeId == id) {
                              sizeId = null;
                              return;
                            }
                            sizeId = id;
                          });
                        },
                        value: sizeId == widget.sizes[index].id ? true : false,
                      );
                    },
                  ),
                  const SizedBox(height: 20),
                  Text(
                    TranslationService.getString('extras_key'),
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                  ...List.generate(
                    widget.extra.length,
                    (index) {
                      return CustomCheckBox(
                        title: "Sause",
                        price: 80.0,
                        shape: null,
                        onChanged: (value) {
                          var id = widget.extra[index].id!;
                          setState(() {
                            if (extrasTest.contains(id)) {
                              extrasTest.remove(id);
                            } else {
                              extrasTest.add(id);
                            }
                          });
                          print("extras:: $extrasTest");
                        },
                        value: extrasTest.contains(widget.extra[index].id!),
                        // value: true,
                      );
                    },
                  ),
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
