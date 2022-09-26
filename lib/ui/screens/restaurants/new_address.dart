import 'package:flutter/material.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_fab_button.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/gradient_colors_box.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/map_bubble.dart';
import 'package:takkeh/ui/widgets/custom_text_field.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';

class AddNewAddressScreen extends StatefulWidget {
  const AddNewAddressScreen({Key? key}) : super(key: key);

  @override
  State<AddNewAddressScreen> createState() => _AddNewAddressScreenState();
}

class _AddNewAddressScreenState extends State<AddNewAddressScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late TextEditingController regionCtrl;
  late TextEditingController streetCtrl;
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
    regionCtrl = TextEditingController();
    streetCtrl = TextEditingController();
    buildingNumCtrl = TextEditingController();
    floorNumCtrl = TextEditingController();
    apartmentNumCtrl = TextEditingController();
    notesCtrl = TextEditingController();
  }

  @override
  void dispose() {
    super.dispose();
    regionCtrl.dispose();
    streetCtrl.dispose();
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
            if (_formKey.currentState!.validate()) {}
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
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                children: [
                  const MapBubbleBuilder(visible: false),
                  // const SizedBox(height: 15),
                  CustomTextField(
                    controller: regionCtrl,
                    hintText: TranslationService.getString('region_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomTextField(
                      controller: regionCtrl,
                      hintText: TranslationService.getString('street_key'),
                      horizontalPadding: 20,
                      validator: fieldValidator,
                    ),
                  ),
                  CustomTextField(
                    controller: regionCtrl,
                    hintText: TranslationService.getString('building_num_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10.0),
                    child: CustomTextField(
                      controller: regionCtrl,
                      hintText: TranslationService.getString('floor_num_key'),
                      horizontalPadding: 20,
                      validator: fieldValidator,
                    ),
                  ),
                  CustomTextField(
                    controller: regionCtrl,
                    hintText: TranslationService.getString('apartment_num_key'),
                    horizontalPadding: 20,
                    validator: fieldValidator,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 30),
                    child: CustomTextField(
                      controller: regionCtrl,
                      hintText: TranslationService.getString('notes_key'),
                      horizontalPadding: 20,
                    ),
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
