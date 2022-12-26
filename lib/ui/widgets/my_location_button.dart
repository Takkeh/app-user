import 'package:flutter/material.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/controller/user_location_ctrl.dart';

class MyLocationButton extends StatelessWidget {
  const MyLocationButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.topRight,
      child: ElevatedButton(
        onPressed: () {
          MapController.find.animateCamera(UserLocationCtrl.find.latitude.value, UserLocationCtrl.find.longitude.value);
        },
        style: ElevatedButton.styleFrom(
          shape: const CircleBorder(),
        ),
        child: const Icon(Icons.my_location),
      ),
    );
  }
}
