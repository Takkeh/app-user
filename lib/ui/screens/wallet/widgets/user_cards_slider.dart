import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class UserCardsSlider extends StatefulWidget {
  const UserCardsSlider({Key? key}) : super(key: key);

  @override
  State<UserCardsSlider> createState() => _UserCardsSliderState();
}

class _UserCardsSliderState extends State<UserCardsSlider> {
  int currentIndex = 0;
  final myList = [1, 2, 3, 4, 5];

  @override
  Widget build(BuildContext context) {
    return CarouselSlider(
      options: CarouselOptions(
        height: 220.0,
        viewportFraction: 0.80,
        enableInfiniteScroll: false,
        onPageChanged: (index, value) {
          setState(() {
            currentIndex = index;
          });
        },
      ),
      items: myList.map((element) {
        final index = myList.indexOf(element);
        return Builder(
          builder: (BuildContext context) {
            return AnimatedContainer(
              margin: const EdgeInsets.symmetric(horizontal: 5),
              duration: const Duration(milliseconds: 300),
              decoration: BoxDecoration(
                color: currentIndex == index ? MyColors.primary : MyColors.grey9F4,
                borderRadius: BorderRadius.circular(48),
              ),
              child: Padding(
                padding: const EdgeInsetsDirectional.fromSTEB(30, 50, 50, 15),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    SvgPicture.asset(MyIcons.cardWhite),
                    Padding(
                      padding: const EdgeInsets.only(top: 44.0, bottom: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: List.generate(
                          4,
                          (index) {
                            return index == 3 ? const Text("1234", style: TextStyle(fontSize: 18)) : const Text("****", style: TextStyle(fontSize: 18));
                          },
                        ),
                      ),
                    ),
                    const Text("Khaled Awad", style: TextStyle(fontSize: 18)),
                  ],
                ),
              ),
            );
          },
        );
      }).toList(),
    );
  }
}
