import 'package:flutter/material.dart';

class FlexibleSpaceBarHeader extends StatelessWidget {
  const FlexibleSpaceBarHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      expandedHeight: 250.0,
      flexibleSpace: FlexibleSpaceBar(
        collapseMode: CollapseMode.pin,
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            Positioned.fill(
              child: Image.network(
                'https://images.unsplash.com/photo-1512621776951-a57141f2eefd?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxleHBsb3JlLWZlZWR8MTB8fHxlbnwwfHx8fA%3D%3D&w=1000&q=80',
                fit: BoxFit.cover,
              ),
            ),
            const Positioned(
              right: 10,
              top: 20,
              child: Icon(
                Icons.favorite,
                size: 30,
              ),
            ),
            const Positioned(
              left: 10,
              top: 20,
              child: Icon(
                Icons.arrow_back,
                size: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
