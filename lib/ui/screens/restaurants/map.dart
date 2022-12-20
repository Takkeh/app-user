import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
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
          TranslationService.getString('my_location_key'),
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
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: CustomFABButton(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        title: TranslationService.getString('confirm_key'),
        onPressed: () {
          MapController.find.updateLocationDetails(mapController, context);
        },
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
              label: 'Search for the address'.tr,
              prefixIcon: const Icon(Icons.search),
            ),
          ),
          //TODO: config for ios runner
          Expanded(
            child: Stack(
              alignment: const Alignment(0, 0),
              children: [
                GoogleMap(
                  onMapCreated: (GoogleMapController googleMapController) {
                    MapController.find.mapController = googleMapController;
                  },
                  zoomControlsEnabled: false,
                  myLocationButtonEnabled: true,
                  myLocationEnabled: true,
                  initialCameraPosition: CameraPosition(
                    target: LatLng(MapController.find.mapLat!, MapController.find.mapLng!),
                    zoom: 15,
                  ),
                  onCameraMove: (CameraPosition position) {
                    log("position:: ${position.target.latitude} -- ${position.target.longitude}");
                    MapController.find.mapLat = position.target.latitude;
                    MapController.find.mapLng = position.target.longitude;
                  },
                ),
                const CustomMarker(color: MyColors.redPrimary),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
