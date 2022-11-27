import 'package:flutter/material.dart';
import 'package:takkeh/controller/help/faq_list_ctrl.dart';
import 'package:takkeh/model/help/faq_list_model.dart';
import 'package:takkeh/translation/service.dart';
import 'package:takkeh/ui/screens/help/widget/faq_loading.dart';
import 'package:takkeh/ui/screens/restaurants/widgets/custom_circular_progress_indicator.dart';
import 'package:takkeh/ui/widgets/failed_widget.dart';
import 'package:takkeh/ui/widgets/transparent_app_bar.dart';
import 'package:takkeh/utils/base/colors.dart';
import 'package:takkeh/utils/base/images.dart';
import 'package:takkeh/utils/shared_prefrences.dart';

class HelpScreen extends StatelessWidget {
  const HelpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyColors.blue6FA,
      appBar: TransparentAppBar(title: TranslationService.getString('help_key')),
      body: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.asset(MyImages.handUpTransparent),
          Column(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0, vertical: 20),
                child: Image.asset(
                  MyImages.help,
                ),
              ),
              Expanded(
                child: FutureBuilder<FaqModel?>(
                  future: FaqCtrl.find.initialize,
                  builder: (context, snapshot) {
                    switch (snapshot.connectionState) {
                      case ConnectionState.waiting:
                        return const FaqLoading();
                      case ConnectionState.done:
                      default:
                        if (snapshot.hasData) {
                          return ListView.separated(
                            separatorBuilder: (context, index) =>
                            const SizedBox(height: 15),
                            padding: const EdgeInsets.all(30),
                            itemCount: snapshot.data!.data!.length,
                            itemBuilder: (context, index) {
                              final data = snapshot.data!.data![index];
                              return ClipRRect(
                                borderRadius: BorderRadius.circular(17),
                                child: Theme(
                                  data: Theme.of(context)
                                      .copyWith(dividerColor: Colors.transparent),
                                  child: ExpansionTile(
                                    expandedAlignment:
                                    MySharedPreferences.language == 'en'
                                        ? Alignment.centerLeft
                                        : Alignment.centerRight,
                                    // expandedCrossAxisAlignment: CrossAxisAlignment.start,
                                    childrenPadding:
                                    const EdgeInsetsDirectional.only(start: 20),
                                    collapsedBackgroundColor: Colors.white,
                                    backgroundColor: Colors.white,
                                    title: Text('${data.question}'),
                                    children: <Widget>[
                                      Text('${data.answer}'),
                                      const SizedBox(
                                        height: 10,
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                          );
                        } else {
                          return const FailedWidget();
                        }
                    }
                  },
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
