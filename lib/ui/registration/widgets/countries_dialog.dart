import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:takkeh/controller/registration/send_otp.dart';
import 'package:takkeh/model/registration/countries_model.dart';
import 'package:takkeh/ui/registration/widgets/flags_widgets.dart';
import 'package:takkeh/ui/widgets/custom_elevated_button.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';

class CountriesDialog extends StatefulWidget {
  final String chosenCountry;

  const CountriesDialog({
    Key? key,
    required this.chosenCountry,
  }) : super(key: key);

  @override
  CountriesDialogState createState() => CountriesDialogState();
}

class CountriesDialogState extends State<CountriesDialog> {
  @override
  void initState() {
    CountriesController.countriesData = CountriesController.fetchCountriesData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 400,
      width: Get.width - 100,
      child: Column(
        children: [
          FutureBuilder<CountriesModel?>(
            future: CountriesController.countriesData,
            builder: (context, snapshot) {
              switch (snapshot.connectionState) {
                case ConnectionState.waiting:
                  return const SizedBox(
                    height: 300,
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                case ConnectionState.done:
                default:
                  if (snapshot.hasData) {
                    return SizedBox(
                      height: 300,
                      child: ListView.builder(
                        itemCount: 15,
                        itemBuilder: (context, index) {
                          return FlagsWidget(
                            title: "Jordan",
                            url: 'https://www.edarabia.com/wp-content/uploads/2019/10/jordan-flag.jpg',
                            onTap: () {},
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const FailedWidget();
                  } else {
                    return const FailedWidget();
                  }
              }
            },
          ),
          const SizedBox(height: 30),
          CustomElevatedButton(
            title: "تأكيد",
            onPressed: () {},
          ),
        ],
      ),
    );
  }
}
