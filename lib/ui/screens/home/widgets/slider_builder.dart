import 'package:flutter/material.dart';
import 'package:takkeh/controller/home/slider.dart';
import 'package:takkeh/model/home/slider_model.dart';
import 'package:takkeh/ui/screens/home/widgets/category_loading.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class SliderBuilder extends StatelessWidget {
  const SliderBuilder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<SliderModel?>(
      future: SliderController.find.initializeSliderFuture,
      builder: (context, snapshot) {
        switch (snapshot.connectionState) {
          case ConnectionState.waiting:
            return const CategoryLoading();
          case ConnectionState.done:
          default:
            if (snapshot.hasData) {
              return AspectRatio(
                aspectRatio: 2.5,
                child: ListView.separated(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  separatorBuilder: (context, index) => const SizedBox(width: 15),
                  itemCount: snapshot.data!.sliders!.length,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) {
                    return AspectRatio(
                      aspectRatio: 2,
                      child: CustomNetworkImage(
                        url: snapshot.data!.sliders![index].image!,
                        radius: 16,
                      ),
                    );
                  },
                ),
              );
            } else if (snapshot.hasError) {
              return const FailedWidget();
            } else {
              return const FailedWidget();
            }
        }
      },
    );
  }
}
