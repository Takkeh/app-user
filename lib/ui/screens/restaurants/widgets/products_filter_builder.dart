import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class ProductsFilterBuilder extends StatefulWidget {
  const ProductsFilterBuilder({Key? key}) : super(key: key);

  @override
  State<ProductsFilterBuilder> createState() => _ProductsFilterBuilderState();
}

class _ProductsFilterBuilderState extends State<ProductsFilterBuilder> {
  //TODO: very important, controller or not ???!!!
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 50,
      child: ListView.separated(
        padding: const EdgeInsets.all(8),
        separatorBuilder: (context, index) => const SizedBox(width: 5),
        scrollDirection: Axis.horizontal,
        itemCount: 15,
        itemBuilder: (context, index) {
          return ElevatedButton(
            style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(9),
              ),
              primary: currentIndex == index ? MyColors.redD4F : Colors.transparent,
              elevation: 0,
            ),
            onPressed: () {
              setState(() {
                currentIndex = index;
              });
            },
            child: Text(
              "Menu $index",
              style: TextStyle(
                color: currentIndex == index ? Colors.white : MyColors.text,
                fontSize: 16,
                fontWeight: FontWeight.w500,
              ),
            ),
          );
        },
      ),
    );
  }
}
