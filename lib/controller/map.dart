import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_google_places/flutter_google_places.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:google_api_headers/google_api_headers.dart' show GoogleApiHeaders;
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:google_maps_webservice/places.dart';
import 'package:takkeh/controller/addresses/my_addresses_ctrl.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/utils/app_constants.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class MapController extends GetxController {
  static MapController get find => Get.find();

  GoogleMapController? mapController;
  double? mapLat;
  double? mapLng;
  final mapSubLocality = ''.obs;
  final mapStreet = ''.obs;
  final mapLocality = ''.obs;

  final regionCtrl = TextEditingController().obs;
  final streetCtrl = TextEditingController().obs;

  Future displayPrediction(Prediction? p) async {
    if (p == null) return;
    GoogleMapsPlaces places = GoogleMapsPlaces(
      apiKey: AppConstants.googleApiKey,
      apiHeaders: await const GoogleApiHeaders().getHeaders(),
    );
    PlacesDetailsResponse detail = await places.getDetailsByPlaceId(p.placeId!);
    final lat = detail.result.geometry!.location.lat;
    final lng = detail.result.geometry!.location.lng;
    mapLat = lat;
    mapLng = lng;
    log("result:: $lat -- $lng");
    animateCamera(lat, lng);
  }

  Future<void> animateCamera(double lat, double lng) async {
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(lat, lng), zoom: 15));
    await mapController!.animateCamera(update);
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
    OverLayLoader.flickrLoading(context);
    await getAddress(mapLat!, mapLng!);
    CameraUpdate update = CameraUpdate.newCameraPosition(CameraPosition(target: LatLng(mapLat!, mapLng!), zoom: 15));
    await mapController.animateCamera(update);
    Loader.hide();
    Get.back();
  }

  Future getAddress(double lat, double lng) async {
    List<Placemark> placeMarks = await placemarkFromCoordinates(lat, lng, localeIdentifier: MySharedPreferences.language);
    mapLocality.value = placeMarks[0].locality ?? '';
    mapSubLocality.value = placeMarks[0].subLocality ?? '';
    mapStreet.value = placeMarks.firstWhere((element) => !element.name!.contains('+')).name ?? '';
    regionCtrl.value.text = '${mapLocality.value} ${mapSubLocality.value}';
    streetCtrl.value.text = mapStreet.value;
    log("placeMarks:: $placeMarks");
    log("address:: ${mapLocality.value} -- ${mapStreet.value}");
    update();
  }

  @override
  void onInit() {
    mapLat = MyAddressesCtrl.find.selectedLat.value;
    mapLng = MyAddressesCtrl.find.selectedLng.value;
    mapLocality.value = MyAddressesCtrl.find.locality.value;
    mapSubLocality.value = MyAddressesCtrl.find.subLocality.value;
    mapStreet.value = MyAddressesCtrl.find.street.value;
    regionCtrl.value = TextEditingController(text: '${mapLocality.value} ${mapSubLocality.value}');
    streetCtrl.value = TextEditingController(text: mapStreet.value);
    super.onInit();
  }

  @override
  void onClose() {
    regionCtrl.value.dispose();
    streetCtrl.value.dispose();
    super.onClose();
  }
}
