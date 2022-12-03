import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/custom_clip_path.dart';

class CustomBubbleImage extends StatelessWidget {
  final String imageUrl;

  const CustomBubbleImage({
    Key? key,
    required this.imageUrl,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: CustomClipPath(),
      child: CustomNetworkImage(
        url: imageUrl,
        radius: 0,
        height: 240,
      ),
    );
  }
}
