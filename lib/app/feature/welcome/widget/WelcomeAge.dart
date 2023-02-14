import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowUp.dart';
import 'package:odac_flutter_app/app/feature/components/picker/WheelNumberPicker.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/l10n/Common.dart';

/**
 * @feature: 나이 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeAge extends StatelessWidget {
  final Function changePage;

  WelcomeAge({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height * 0.7,
          margin: EdgeInsets.only(top: 120, left: 20, right: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              ShowUp(
                child: Text(
                  getApplocalizations(context)?.welcome_text_age_input ?? "",
                  style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Theme.of(context).colorScheme.onBackground,
                        fontWeight: FontWeight.w700,
                      ),
                ),
                delay: 300,
              ),
              SizedBox(height: 80),
              ShowUp(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    WheelNumberPicker(initialValue: 52),
                    Text(
                      "세",
                      style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                            color: Theme.of(context).colorScheme.onBackground,
                            fontWeight: FontWeight.w700,
                          ),
                    ),
                  ],
                ),
                delay: 300,
              )
            ],
          ),
        ),
      ),
      bottomSheet: ShowUp(
        child: FillButton(
          onTap: () {
            debugPrint("Button Clicked");
          },
          child: Text(
            getApplocalizations(context)?.welcome_button_next ?? "",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onPrimary,
                ),
          ),
        ),
        delay: 300,
      ),
    );
  }
}
