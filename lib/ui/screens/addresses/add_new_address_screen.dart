import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/addresses/create_address_ctrl.dart';
import 'package:takkeh/controller/map.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/map_bubble.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/app_constants.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController titleCtrl;
  late TextEditingController buildingNumCtrl;
  late TextEditingController floorNumCtrl;
  late TextEditingController apartmentNumCtrl;
  late TextEditingController notesCtrl;

  String? fieldValidator(value) {
    if (value!.isEmpty) {
      return TranslationService.getString('required_field_key');
    }
    return null;
  }

  @override
  void initState() {
    super.initState();
    titleCtrl = TextEditingController();
    buildingNumCtrl = TextEditingController();
    floorNumCtrl = TextEditingController();
    apartmentNumCtrl = TextEditingController();
    notesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    titleCtrl.dispose();
    buildingNumCtrl.dispose();
    floorNumCtrl.dispose();
    apartmentNumCtrl.dispose();
    notesCtrl.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: CustomFABButton(
          title: TranslationService.getString('save_address_key'),
          onPressed: () {
            if (_formKey.currentState!.validate()) {
              FocusManager.instance.primaryFocus?.unfocus();
              CreateAddressCtrl.find.fetchData(
                name: titleCtrl.text,
                region: MapController.find.regionCtrl.value.text,
                street: MapController.find.streetCtrl.value.text,
                buildingNum: buildingNumCtrl.text,
                additionalTips: notesCtrl.text,
                floor: floorNumCtrl.text,
                apartmentNum: apartmentNumCtrl.text,
                //TODO: ask about these
                city: 'city',
                phone: '+962791595029',
                context: context,
              );
            }
          },
        ),
      ),
      extendBodyBehindAppBar: true,
      appBar: TransparentAppBar(
        title: TranslationService.getString('address_key'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            const GradientColorsBox(height: 136),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 60),
                children: [
                  const MapBubbleBuilder(route: kMap),
                  // const SizedBox(height: 15),
                  CustomTextField(
                    padding: const EdgeInsets.only(bottom: 10.0),
                    controller: titleCtrl,
                    hintText: TranslationService.getString('address_title_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  GetX<MapController>(
                    builder: (controller) {
                      return CustomTextField(
                        controller: controller.regionCtrl.value,
                        hintText: TranslationService.getString('region_key'),
                        horizontalPadding: 20,
                        validator: fieldValidator,
                      );
                    },
                  ),
                  GetX<MapController>(
                    builder: (controller) {
                      return CustomTextField(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        controller: controller.streetCtrl.value,
                        hintText: TranslationService.getString('street_key'),
                        horizontalPadding: 20,
                        validator: fieldValidator,
                      );
                    },
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: buildingNumCtrl,
                    hintText: TranslationService.getString('building_num_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    controller: floorNumCtrl,
                    hintText: TranslationService.getString('floor_num_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  CustomTextField(
                    keyboardType: TextInputType.number,
                    controller: apartmentNumCtrl,
                    hintText: TranslationService.getString('apartment_num_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  CustomTextField(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                    controller: notesCtrl,
                    hintText: TranslationService.getString('notes_key'),
                    horizontalPadding: 20,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
