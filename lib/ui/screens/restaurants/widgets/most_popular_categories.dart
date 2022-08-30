import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class MostPopularCategoriesBuilder extends StatelessWidget {
  const MostPopularCategoriesBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      height: 165,
      child: ListView.separated(
        padding: const EdgeInsets.symmetric(horizontal: 28),
        separatorBuilder: (context, index) => const SizedBox(width: 10),
        itemCount: 5,
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Container(
            width: 115,
            padding: const EdgeInsets.only(bottom: 3),
            decoration: BoxDecoration(
              color: MyColors.grey9F4,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    margin: const EdgeInsets.only(bottom: 3),
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                      image: const DecorationImage(
                        image: NetworkImage("https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg"),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                const Text(
                  "Spicy Chiken",
                  style: TextStyle(
                    fontSize: 15,
                  ),
                ),
                const Text(
                  "18.3",
                  style: TextStyle(
                    fontSize: 15,
                    color: MyColors.redD4F,
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
