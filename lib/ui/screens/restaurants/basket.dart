import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/registration/widgets/custom_prefix_icon.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/basket_products_tile.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/icons.dart';

class BasketScreen extends StatelessWidget {
  const BasketScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(title: TranslationService.getString('basket_key')),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const GradientColorsBox(height: 136),
            ...List.generate(
              2,
              (index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30.0),
                  child: ListBody(
                    children: [
                      BasketProductTile(
                        imageUrl: 'https://img.freepik.com/free-photo/top-view-pepperoni-pizza-with-mushroom-sausages-bell-pepper-olive-corn-black-wooden_141793-2158.jpg?w=2000',
                        title: 'title',
                        subTitle: 'subTitle',
                        description: 'description',
                        onTap: () {},
                        notes: List.generate(
                          4,
                          (index) {
                            return index == 3
                                ? Row(
                                    children: [
                                      SvgPicture.asset(MyIcons.notes, height: 14),
                                      const SizedBox(width: 3),
                                      const Text("extra mayo"),
                                    ],
                                  )
                                : const Text("+ souce");
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20.0),
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
    );
  }
}
