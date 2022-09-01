import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart' show GoogleApiHeaders;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:takkeh/controller/user_location.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class MapController extends GetxController {
  static MapController get find => Get.find();

  final markers = <Marker>{}.obs;
  final circles = <Circle>{}.obs;
  GoogleMapController? mapController;

  double? newLat;
  double? newLng;

  void addMarker(LatLng pos) {
    markers.clear();
    markers.add(
      Marker(
        markerId: const MarkerId("1"),
        position: pos,
      ),
    );
  }

  void addCircle(LatLng pos) {
    circles.clear();
    circles.add(
      Circle(
        strokeWidth: 0,
        fillColor: MyColors.primary.withOpacity(0.50),
        circleId: const CircleId("221"),
        center: LatLng(pos.latitude, pos.longitude),
        radius: 300,
      ),
    );
  }

  Future displayPrediction(Prediction? p) async {
    if (p == null) return;
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: AppConstants.googleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    log("result:: $lat -- $lng");
    animateCamera(lat, lng);
    // CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 15));
    // await mapController!.animateCamera(update);
    // addMarker(LatLng(lat, lng));
    // addCircle(LatLng(lat, lng));
  }

  Future animateCamera(lat, lng) async {
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 15));

    await mapController!.animateCamera(update);
    addMarker(LatLng(lat, lng));
    addCircle(LatLng(lat, lng));
  }

  Future<void> showSearchField(BuildContext context) async {
    try {
      Prediction? p = await PlacesAutocomplete.show(
        logo: Container(
          height: 50,
          padding: const EdgeInsets.symmetric(vertical: 8),
          alignment: Alignment.center,
          width: double.infinity,
          child: Image.asset(MyImages.logo),
        ),
        offset: 0,
        radius: 1000,
        strictbounds: false,
        region: "JO",
        context: context,
        types: [
          // "(cities)",
          // "(regions)",
        ],
        hint: "Search for the address",
        apiKey: AppConstants.googleApiKey,
        onError: (PlacesAutocompleteResponse response) {
          log("error:: ${response.errorMessage}");
        },
        mode: Mode.overlay,
        language: "ar",
        components: [Component(Component.country, "JO")],
        startText: "city",
        decoration: InputDecoration(
          hintText: 'Search',
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(20),
            borderSide: const BorderSide(
              color: Colors.white,
            ),
          ),
        ),
      );
      displayPrediction(p);
    } catch (e) {
      log("error:: $e");
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future updateLocationDetails(
    GoogleMapController mapController,
    BuildContext context,
  ) async {
    OverLayLoader.showLoading(context);
    UserLocationCtrl.find.updateLocation(MapController.find.newLat!, MapController.find.newLng!);
    await UserLocationCtrl.find.getAddressDetails(MapController.find.newLat!, MapController.find.newLng!);
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(UserLocationCtrl.find.latitude.value!, UserLocationCtrl.find.longitude.value!), zoom: 15));
    mapController.animateCamera(update);
    Loader.hide();
    Get.back();
  }

  @override
  void onInit() {
    addMarker(LatLng(UserLocationCtrl.find.latitude.value!, UserLocationCtrl.find.longitude.value!));
    addCircle(LatLng(UserLocationCtrl.find.latitude.value!, UserLocationCtrl.find.longitude.value!));
    super.onInit();
  }
}
