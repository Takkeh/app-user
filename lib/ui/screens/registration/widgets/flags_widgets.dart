import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';

class FlagsWidget extends StatelessWidget {
  final String title, url;
  final Function() onTap;

  const FlagsWidget({
    Key? key,
    required this.title,
    required this.url,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Material(
        borderRadius: BorderRadius.circular(15),
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(15),
          onTap: onTap,
          child: Row(
            children: [
              CustomNetworkImage(
                url: url,
                radius: 15,
                width: 50,
                height: 50,
              ),
              const SizedBox(width: 20),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 20,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
