import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';

class FilterBubble extends StatelessWidget {
  final String title, imageUrl;
  final VoidCallback onTap;
  final bool isSelected;

  const FilterBubble({
    Key? key,
    required this.title,
    required this.imageUrl,
    required this.onTap,
    required this.isSelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: Alignment.center,
        width: 80,
        padding: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
          color: MyColors.redB3A,
          borderRadius: BorderRadius.circular(27),
          border: isSelected ? Border.all(color: MyColors.redF98) : null,
        ),
        child: SingleChildScrollView(
          physics: const NeverScrollableScrollPhysics(),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomNetworkImage(
                url: imageUrl,
                radius: 0,
                height: 50,
              ),
              const SizedBox(height: 5),
              AutoSizeText(
                title,
                textAlign: TextAlign.center,
                minFontSize: 7,
                maxLines: 2,
                style: const TextStyle(color: MyColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
