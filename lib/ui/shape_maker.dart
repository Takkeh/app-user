import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:takkeh/ui/screens/home/home.dart';
import 'package:takkeh/utils/base/icons.dart';

class ShapeMaker extends StatelessWidget {
  const ShapeMaker({Key? key}) : super(key: key);

  static Widget getWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        SvgPicture.asset(MyIcons.clock),
        const SizedBox(height: 5),
        const Text("30 - 40 minutes"),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipPath(
              clipper: CustomClipPath(),
              child: Container(
                width: double.infinity,
                height: 300,
                alignment: Alignment.center,
                decoration: const BoxDecoration(
                  image: DecorationImage(
                    image: NetworkImage('https://cdn.pixabay.com/photo/2015/04/23/22/00/tree-736885__480.jpg'),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
            CustomPaint(
              size: Size(Get.width, (Get.width * 0.41925988225399496).toDouble()), //You can Replace [WIDTH] with your desired width for Custom Paint and height will be calculated automatically
              painter: RPSCustomPainter(),
              child: Container(
                color: Colors.red,
              ),
            ),
            const SizedBox(
              height: 100,
            ),
            Center(
              child: ListBody(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      getWidget(),
                      Stack(
                        alignment: Alignment.bottomCenter,
                        children: [
                          const CircleAvatar(
                            radius: 60,
                            backgroundImage: NetworkImage(
                              'https://images.unsplash.com/photo-1453728013993-6d66e9c9123a?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8bGVuc3xlbnwwfHwwfHw%3D&w=1000&q=80',
                            ),
                          ),
                          Stack(
                            alignment: Alignment.center,
                            children: [
                              SvgPicture.asset(
                                MyIcons.halfCircle,
                                width: 103,
                              ),
                              const Text(
                                "information",
                                style: TextStyle(fontSize: 12),
                              ),
                            ],
                          ),
                        ],
                      ),
                      getWidget(),
                    ],
                  ),
                  const SizedBox(height: 10),
                  getWidget(),
                  // Center(
                  //   child: CustomPaint(
                  //     painter: MyPainter(),
                  //     size: const Size(120, 120),
                  //   ),
                  // ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

//Copy this CustomPainter code to the Bottom of the File
class RPSCustomPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Path path_0 = Path();
    path_0.moveTo(size.width * 0.05025231, 0);
    path_0.lineTo(size.width * 0.9501682, 0);
    path_0.cubicTo(size.width * 0.9501682, 0, size.width * 1.062237, size.height * 0.8084253, size.width * 0.9501682, size.height * 0.9679037);
    path_0.cubicTo(size.width * 0.8380992, size.height * 1.127382, size.width * 0.7266611, size.height * 0.6384152, size.width * 0.5016821, size.height * 0.6384152);
    path_0.cubicTo(size.width * 0.2767031, size.height * 0.6384152, size.width * 0.1629521, size.height * 1.127382, size.width * 0.05025231, size.height * 0.9679037);
    path_0.cubicTo(size.width * -0.06244743, size.height * 0.8084253, size.width * 0.05025231, 0, size.width * 0.05025231, 0);
    path_0.close();

    Paint paint_0_fill = Paint()..style = PaintingStyle.fill;
    paint_0_fill.color = Color(0xff000000).withOpacity(1.0);
    canvas.drawPath(path_0, paint_0_fill);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
