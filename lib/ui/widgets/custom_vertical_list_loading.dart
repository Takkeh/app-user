import 'package:flutter/material.dart';
import 'package:takkeh/ui/widgets/custom_shimmer_loading.dart';

class CustomVerticalListLoading extends StatelessWidget {
  final EdgeInsetsGeometry padding;
  final bool shrinkWrap;

  const CustomVerticalListLoading({
    Key? key,
    required this.padding,
    this.shrinkWrap = false,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      separatorBuilder: (context, index) => const SizedBox(height: 15),
      shrinkWrap: shrinkWrap,
      padding: padding,
      itemCount: 12,
      itemBuilder: (context, index) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(17),
            color: const Color(0xFFFAF5E6).withOpacity(0.20),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 13),
          child: Row(
            children: [
              const CustomShimmerLoading(
                radius: 17,
                width: 80,
                height: 80,
                margin: EdgeInsetsDirectional.only(end: 10),
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: 130,
                      margin: EdgeInsetsDirectional.only(bottom: 10),
                    ),
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: 200,
                      margin: EdgeInsetsDirectional.only(bottom: 15),
                    ),
                    CustomShimmerLoading(
                      radius: 17,
                      height: 10,
                      width: double.infinity,
                      margin: EdgeInsetsDirectional.only(end: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
