import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:takkeh/ui/widgets/custom_network_image.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/icons.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class DrawerProfileInfo extends StatelessWidget {
  const DrawerProfileInfo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsetsDirectional.fromSTEB(10, 50, 0, 30),
      child: Row(
        children: [
          Stack(
            clipBehavior: Clip.none,
            children: [
              Container(
                margin: const EdgeInsetsDirectional.fromSTEB(0, 0, 15, 0),
                height: 100,
                width: 100,
                decoration: BoxDecoration(
                  color: MyColors.grey070,
                  borderRadius: BorderRadius.circular(17),
                ),
                child: CustomNetworkImage(url: MySharedPreferences.image, radius: 17),
              ),
              Positioned(
                top: -2.2,
                left: MySharedPreferences.language == "ar" ? 13 : null,
                right: MySharedPreferences.language == "en" ? 13 : null,
                child: Container(
                  alignment: Alignment.center,
                  height: 22,
                  width: 22,
                  decoration: BoxDecoration(
                    color: MyColors.primary,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                      topRight: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                      bottomLeft: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                      bottomRight: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                    ),
                  ),
                  child: Container(
                    margin: const EdgeInsets.all(2),
                    alignment: Alignment.center,
                    height: 20,
                    width: 20,
                    decoration: BoxDecoration(
                      color: MyColors.grey5B7,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                        topRight: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                        bottomLeft: Radius.circular(MySharedPreferences.language == 'en' ? 5 : 0),
                        bottomRight: Radius.circular(MySharedPreferences.language == 'ar' ? 5 : 0),
                      ),
                    ),
                    child: SvgPicture.asset(
                      MyIcons.edit,
                    ),
                  ),
                ),
              ),
            ],
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MySharedPreferences.name,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Text(
                MySharedPreferences.phone,
                style: const TextStyle(
                  fontSize: 18,
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
