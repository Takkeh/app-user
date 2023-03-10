import 'package:flutter/material.dart';
import 'package:flutter_overlay_loader/flutter_overlay_loader.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/widgets/components/overlay_loader.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';

class LocationPermissionScreen extends StatelessWidget {
  const LocationPermissionScreen({Key? key}) : super(key: key);

  Future submit(BuildContext context) async {
    OverLayLoader.flickrLoading(context);
    await UserLocationCtrl.find.getPermission().then((value) {
      if (value == LocationPermission.unableToDetermine) {
        Loader.hide();
        Fluttertoast.showToast(msg: TranslationService.getString('device_location_service_disabled_key'));
      } else if (value == LocationPermission.deniedForever) {
        Loader.hide();
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: MyColors.primary,
            content: Text(TranslationService.getString('permission_denied_edit_setting_key')),
            action: SnackBarAction(
              label: TranslationService.getString('edit_key'),
              onPressed: () {
                Geolocator.openLocationSettings();
              },
            ),
          ),
        );
      } else if (value == LocationPermission.denied) {
        Loader.hide();
        Fluttertoast.showToast(msg: TranslationService.getString('permission_denied_key'));
      } else {
        Loader.hide();
        Get.back();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      appBar: TransparentAppBar(title: TranslationService.getString('grant_location_key')),
      body: Padding(
        padding: const EdgeInsets.all(30.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Image.asset(MyImages.locationPermission),
              const SizedBox(height: 50.0),
              Text(
                TranslationService.getString('you_must_enable_location_permission_key'),
                style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                textAlign: TextAlign.center,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 8.0, bottom: 60.0),
                child: Text(
                  TranslationService.getString("you_cant_user_app_without_location_permission_key"),
                  style: const TextStyle(fontSize: 20),
                  textAlign: TextAlign.center,
                ),
              ),
              FloatingActionButton.extended(
                heroTag: 'location',
                backgroundColor: MyColors.primary,
                onPressed: () {
                  submit(context);
                },
                label: Text(
                  TranslationService.getString("enable_location_key"),
                  style: const TextStyle(color: MyColors.text),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
