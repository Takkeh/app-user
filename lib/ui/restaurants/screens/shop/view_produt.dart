import 'package:flutter/material.dart';
import 'package:takkeh/ui/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/restaurants/screens/shop/widgets/custom_check_box.dart';
import 'package:takkeh/ui/restaurants/screens/shop/widgets/quantity_button.dart';
import 'package:takkeh/ui/widgets/back_leading_widget.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

import '../../../widgets/custom_text_field.dart';

class ViewProductScreen extends StatelessWidget {
  const ViewProductScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final bool showFab = MediaQuery.of(context).viewInsets.bottom == 0.0;
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: Padding(
        padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
        child: showFab
            ? ElevatedButton(
                style: ElevatedButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(
                      11,
                    ),
                  ),
                  primary: MyColors.redD4F,
                  minimumSize: const Size(double.infinity, 50),
                ),
                onPressed: () {},
                child: const Text("Add to cart"),
              )
            : null,
      ),
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 240,
            collapsedHeight: kToolbarHeight,
            leadingWidth: 70,
            elevation: 0,
            pinned: true,
            floating: true,
            leading: const BackLeadingWidget(icon: Icons.close),
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                "https://media-cdn.tripadvisor.com/media/photo-s/1a/5a/21/7c/burget-detail.jpg",
                fit: BoxFit.cover,
              ),
            ),
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
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          "22.5",
                          style: TextStyle(
                            fontSize: 20,
                            color: MyColors.redD4F,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        Row(
                          children: [
                            QuantityButton(
                              icon: Icons.add,
                              onPressed: () {},
                              color: MyColors.redD4F,
                            ),
                            const Text(
                              "1",
                              style: TextStyle(
                                fontSize: 17,
                              ),
                            ),
                            QuantityButton(
                              icon: Icons.remove,
                              onPressed: () {},
                              color: MyColors.redD4F.withOpacity(0.60),
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                  const Divider(),
                  const Text(
                    "Choose",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ...List.generate(3, (index) {
                    return CustomCheckBox(
                      title: "Food",
                      price: "99.2",
                      shape: const CircleBorder(),
                      onChanged: (value) {},
                      value: true,
                    );
                  }),
                  const SizedBox(height: 20),
                  const Text(
                    "Extra",
                    style: TextStyle(
                      fontSize: 18,
                    ),
                  ),
                  ...List.generate(3, (index) {
                    return CustomCheckBox(
                      title: "Sause",
                      price: "80.0",
                      shape: null,
                      onChanged: (value) {},
                      value: true,
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
      ),
    );
  }
}
