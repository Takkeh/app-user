import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/custom_marker.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';

class MapScreen extends StatelessWidget {
  final GoogleMapController mapController;

  const MapScreen({
    super.key,
    required this.mapController,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.white,
        foregroundColor: MyColors.primary,
        elevation: 0,
        centerTitle: true,
        title: Text(
          'My Location'.tr,
          style: const TextStyle(
            color: MyColors.secondary,
          ),
        ),
        leading: Padding(
          padding: const EdgeInsets.all(10.0),
          child: GestureDetector(
            onTap: () {
              Get.back();
            },
            child: SvgPicture.asset(MyIcons.back),
          ),
        ),
      ),
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 50),
        child: Align(
          alignment: Alignment.bottomCenter,
          child: CustomElevatedButton(
            radius: 11,
            width: double.maxFinite,
            color: MyColors.redD4F,
            textColor: Colors.white,
            title: 'Confirm'.tr,
            onPressed: () async {
              MapController.find.updateLocationDetails(mapController, context);
            },
          ),
        ),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(18.0),
            child: CustomTextField(
              readOnly: true,
              onTap: () {
                MapController.find.showSearchField(context);
              },
              // color: MyColors.textFormColor,
              label: 'Search for the address'.tr,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          //TODO: config for ios runner
          Obx(
            () {
              return Expanded(
                child: Stack(
                  alignment: const Alignment(0, 0),
                  children: [
                    GoogleMap(
                      onMapCreated: (GoogleMapController googleMapController) {
                        MapController.find.mapController = googleMapController;
                      },
                      // markers: MapController.find.markers,
                      // circles: MapController.find.circles,
                      // markers: {
                      //   const Marker(
                      //     markerId: MarkerId("556"),
                      //     position: LatLng(31.98209843785541, 35.87660718709231),
                      //     // position: LocationController.find.pickedLocation(),
                      //   ),
                      // },
                      myLocationButtonEnabled: true,
                      myLocationEnabled: true,
                      initialCameraPosition: CameraPosition(
                        target: LatLng(UserLocationCtrl.find.latitude.value!, UserLocationCtrl.find.longitude.value!),
                        zoom: 15,
                      ),
                      onCameraMove: (CameraPosition position) {
                        log("position:: ${position.target.latitude} -- ${position.target.longitude}");
                        MapController.find.newLat = position.target.latitude;
                        MapController.find.newLng = position.target.longitude;
                      },
                    ),
                    const CustomMarker(color: MyColors.redD4F),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
