import 'package:flutter/material.dart';
import 'package:takkeh/controller/restaurants/view_product.dart';
import 'package:takkeh/model/restaurants/view_product_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_check_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/product_counter.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/view_product_app_bar.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class ViewProductScreen extends StatefulWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  State<ViewProductScreen> createState() => _ViewProductScreenState();
}

class _ViewProductScreenState extends State<ViewProductScreen> {
  //TODO: transfer to controller later
  List<bool> choose = [false, false, false];
  List<bool> extra = [false, false, false];

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
                onPressed: () {},
              )
            : null,
      ),
      body: FutureBuilder<ViewProductModel?>(
        future: ViewProductCtrl.find.initialize,
        builder: (context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator(color: MyColors.redD4F));
            case ConnectionState.done:
            default:
              if (snapshot.hasData) {
                return CustomScrollView(
                  slivers: [
                    ViewProductAppBar(
                      imageUrl: snapshot.data!.data![0].cover!,
                    ),
                    SliverPadding(
                      padding: const EdgeInsets.fromLTRB(20, 20, 20, 100),
                      sliver: SliverList(
                        delegate: SliverChildListDelegate(
                          [
                            const Text(
                              "Mac Chicken",
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const Text(
                              "Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken Mac Chicken",
                              style: TextStyle(
                                fontSize: 16,
                                color: MyColors.grey070,
                              ),
                            ),
                            const ProductCounter(),
                            const Divider(),
                            const Text(
                              "Choose",
                              style: TextStyle(
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
                                  setState(() {
                                    for (var element in choose) {
                                      final index = choose.indexOf(element);
                                      choose[index] = false;
                                    }
                                    choose[index] = value!;
                                  });
                                },
                                value: choose[index],
                              );
                            }),
                            const SizedBox(height: 20),
                            const Text(
                              "Extra",
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                            ...List.generate(3, (index) {
                              return CustomCheckBox(
                                title: "Sause",
                                price: "80.0",
                                shape: null,
                                onChanged: (value) {
                                  setState(() {
                                    extra[index] = value!;
                                  });
                                },
                                value: extra[index],
                              );
                            }),
                            const Padding(
                              padding: EdgeInsets.only(top: 20.0),
                              child: CustomTextField(
                                keyboardType: TextInputType.multiline,
                                hintText: "Do you have any Notes ?",
                                minLines: 1,
                                maxLines: 3,
                                prefixIcon: CustomPrefixIcon(
                                  icon: MyIcons.notes,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              } else if (snapshot.hasError) {
                return const FailedWidget();
              } else {
                return const FailedWidget();
              }
          }
        },
      ),
    );
  }
}
