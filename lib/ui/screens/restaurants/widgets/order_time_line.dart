import 'package:flutter/material.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class OrderTimeLine extends StatefulWidget {
  final String status;

  const OrderTimeLine({
    Key? key,
    required this.status,
  }) : super(key: key);

  @override
  State<OrderTimeLine> createState() => _OrderTimeLineState();
}

class _OrderTimeLineState extends State<OrderTimeLine> with TickerProviderStateMixin {
  late AnimationController _controller;
  late final Animation<double> _animation;

  final step1 = [kHold, kPending];
  final step2 = [kWayToPickUpPoint, kArrivedToPickUpPoint, kAtPickUpPoint];
  final step3 = [kWayToDropPoint, kArrivedToDropPoint, kCollectingMoney];

  @override
  void initState() {
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(reverse: true);
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.easeIn,
    );
    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: Stack(
            alignment: Alignment.center,
            children: [
              Divider(
                color: step1.contains(widget.status) ? MyColors.greyEB3 : MyColors.redPrimary,
                thickness: 3,
              ),
              if (step1.contains(widget.status))
                FadeTransition(
                  opacity: _animation,
                  child: const Divider(
                    color: MyColors.redPrimary,
                    thickness: 3,
                  ),
                ),
            ],
          ),
        ),
        Expanded(
          flex: 2,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10.0),
            child: Stack(
              children: [
                Divider(
                  thickness: 3,
                  color: step2.contains(widget.status) ? MyColors.greyEB3 : MyColors.redPrimary,
                ),
                if (step2.contains(widget.status))
                  FadeTransition(
                    opacity: _animation,
                    child: const Divider(
                      color: MyColors.redPrimary,
                      thickness: 3,
                    ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: Stack(
            children: [
              Divider(
                color: step3.contains(widget.status) ? MyColors.greyEB3 : MyColors.redPrimary,
                thickness: 3,
              ),
              if (step3.contains(widget.status))
                FadeTransition(
                  opacity: _animation,
                  child: const Divider(
                    color: MyColors.redPrimary,
                    thickness: 3,
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }
}
