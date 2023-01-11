import 'package:flutter/material.dart';
import 'package:takkeh/utils/base/colors.dart';

class ChooseCardList extends StatelessWidget {
  const ChooseCardList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15.0),
      child: ListBody(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 35, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.greyEB3),
                    ),
                    child: const Icon(
                      Icons.circle,
                      size: 22,
                      color: MyColors.primary,
                    ),
                  ),
                  const VerticalDivider(width: 30),
                  Expanded(
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
                ],
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.symmetric(vertical: 5),
            padding: const EdgeInsetsDirectional.fromSTEB(16, 20, 35, 20),
            width: double.infinity,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(26),
            ),
            child: IntrinsicHeight(
              child: Row(
                children: [
                  Container(
                    height: 25,
                    width: 25,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      shape: BoxShape.circle,
                      border: Border.all(color: MyColors.greyEB3),
                    ),
                    child: const Icon(
                      Icons.circle,
                      size: 22,
                      color: MyColors.primary,
                    ),
                  ),
                  const VerticalDivider(width: 30),
                  Expanded(
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
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
