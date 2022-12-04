import 'package:flutter/material.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/categories_builder.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_app_bar.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/restaurants_builder.dart';

class RestaurantsHomeScreen extends StatefulWidget {
  const RestaurantsHomeScreen({Key? key}) : super(key: key);

  @override
  State<RestaurantsHomeScreen> createState() => _RestaurantsHomeScreenState();
}

class _RestaurantsHomeScreenState extends State<RestaurantsHomeScreen> {
  late TextEditingController controller;

  @override
  void initState() {
    controller = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: const RestaurantsAppBar(),
      body: Column(
        children: [
          Stack(
            clipBehavior: Clip.none,
            alignment: Alignment.bottomCenter,
            children: const [
              Positioned(
                bottom: -5,
                child: GradientColorsBox(height: 136),
              ),
              RestaurantCategoriesBuilder(),
            ],
          ),
          const SizedBox(height: 20),
          const RestaurantsBuilder(),
        ],
      ),
    );
  }
}
