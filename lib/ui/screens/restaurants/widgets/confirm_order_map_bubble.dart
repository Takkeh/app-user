import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/ui/screens/addresses/my_addresses_screen.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/delivery_info_box.dart';
import 'package:takkeh/ui/widgets/custom_marker.dart';
import 'package:takkeh/utils/base/colors.dart';

class ConfirmOrderMapBubble extends StatefulWidget {
  const ConfirmOrderMapBubble({Key? key}) : super(key: key);

  @override
  State<ConfirmOrderMapBubble> createState() => _ConfirmOrderMapBubbleState();
}

class _ConfirmOrderMapBubbleState extends State<ConfirmOrderMapBubble> {
  late GoogleMapController mapController;

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MyAddressesCtrl>(
      builder: (controller) {
        return ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: SizedBox(
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
                        onTap: (value) async {
                          LocationPermissionHelper.check(
                            action: () {
                              Get.to(() => const MyAddressesScreen())!.then((value) async {
                                CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(controller.selectedLat.value, controller.selectedLng.value), zoom: 15));
                                await mapController.animateCamera(update);
                              });
                            },
                          );
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.selectedLat.value, controller.selectedLng.value),
                          zoom: 15,
                        ),
                      ),
                    ),
                    const CustomMarker(color: MyColors.redPrimary),
                  ],
                ),
                DeliveryInfoBox(
                  address: "${controller.locality.value}, ${controller.subLocality.value}",
                  isVisible: true,
                  onPressed: () {
                    LocationPermissionHelper.check(
                      action: () {
                        Get.to(() => const MyAddressesScreen())!.then((value) async {
                          CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(controller.selectedLat.value, controller.selectedLng.value), zoom: 15));
                          await mapController.animateCamera(update);
                        });
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
