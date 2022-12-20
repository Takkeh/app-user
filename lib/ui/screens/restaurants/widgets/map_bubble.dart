import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/helper/location_permission_helper.dart';
import 'package:takkeh/ui/screens/addresses/my_addresses_screen.dart';
import 'package:takkeh/ui/screens/restaurants/map.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/delivery_info_box.dart';
import 'package:takkeh/ui/widgets/custom_marker.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';

class MapBubbleBuilder extends StatefulWidget {
  final String route;
  const MapBubbleBuilder({Key? key, required this.route}) : super(key: key);

  @override
  State<MapBubbleBuilder> createState() => _MapBubbleBuilderState();
}

class _MapBubbleBuilderState extends State<MapBubbleBuilder> {
  late GoogleMapController mapController;

  @override
  void initState() {
    Get.lazyPut(() => MapController());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    Get.delete<MapController>();
    mapController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GetX<MapController>(
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
                        onTap: (value) {
                          LocationPermissionHelper.check(
                            action: () {
                              if (widget.route == kMap) {
                                Get.to(() => MapScreen(mapController: mapController));
                              }
                              if (widget.route == kAddress) {
                                Get.to(() => const MyAddressesScreen());
                                // Get.to(() => const AddNewAddressScreen(), binding: CreateAddressBinding());
                                // Get.to(() => MapScreen(mapController: mapController));
                              }
                            },
                          );
                        },
                        initialCameraPosition: CameraPosition(
                          target: LatLng(controller.mapLat!, controller.mapLng!),
                          zoom: 15,
                        ),
                      ),
                    ),
                    const CustomMarker(color: MyColors.redPrimary),
                  ],
                ),
                DeliveryInfoBox(
                  address: "${controller.mapLocality.value} ${controller.mapSubLocality.value}, ${controller.mapStreet.value}",
                  isVisible: false,
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
