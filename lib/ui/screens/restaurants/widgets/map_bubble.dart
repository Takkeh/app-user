import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/binding/restaurants/map.dart';
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/ui/screens/restaurants/map.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/delivery_info_box.dart';
import 'package:takkeh/ui/widgets/custom_marker.dart';
import 'package:takkeh/utils/base/colors.dart';

class MapBubbleBuilder extends StatefulWidget {
  const MapBubbleBuilder({Key? key}) : super(key: key);

  @override
  State<MapBubbleBuilder> createState() => _MapBubbleBuilderState();
}

class _MapBubbleBuilderState extends State<MapBubbleBuilder> {
  late GoogleMapController mapController;

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserLocationCtrl>(builder: (controller) {
      return SizedBox(
        height: 220,
        child: Column(
          children: [
            Stack(
              alignment: Alignment.center,
              children: [
                SizedBox(
                  height: 156,
                  child: GoogleMap(
                    zoomControlsEnabled: false,
                    onMapCreated: (mapCtrl) {
                      mapController = mapCtrl;
                    },
                    onTap: (value) {
                      Get.to(
                        () => MapScreen(mapController: mapController),
                        binding: MapBinding(),
                      )!
                          .then((value) {
                        //   setState(() {
                        //     _regionController.text =
                        //     UserLocationController.find.region.value!;
                        //     _streetController.text =
                        //     UserLocationController.find.street.value!;
                        //   });
                      });
                    },
                    // markers: {
                    //   Marker(
                    //     markerId: const MarkerId("556"),
                    //     position: LatLng(controller.latitude.value!, controller.longitude.value!),
                    //   ),
                    // },
                    initialCameraPosition: CameraPosition(
                      target: LatLng(controller.latitude.value!, controller.longitude.value!),
                      zoom: 15,
                    ),
                  ),
                ),
                const CustomMarker(color: MyColors.redPrimary),
              ],
            ),
            DeliveryInfoBox(
              address: "${controller.subLocality.value!}, ${controller.street.value!}",
            ),
          ],
        ),
      );
    });
  }
}
