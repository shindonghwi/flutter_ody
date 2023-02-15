import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowUp.dart';
import 'package:odac_flutter_app/app/feature/components/picker/WheelNumberPicker.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/l10n/Common.dart';

/**
 * @feature: 키, 몸무게 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeHeightWeight extends StatelessWidget {
  final Function changePage;

  WelcomeHeightWeight({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: Theme.of(context).colorScheme.background,
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          padding: EdgeInsets.only(top: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              Pickers(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 - 키와 몸무게를 입력해주세요 */
  Widget TitleText(BuildContext context) {
    return ShowUp(
      child: Text(
        getApplocalizations(context)?.welcome_text_height_weight_input ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onBackground,
              fontWeight: FontWeight.w700,
            ),
      ),
      delay: showUpDuration,
    );
  }

  /** 픽커 - 키와 몸무게 픽커 위젯 모음 */
  Widget Pickers(BuildContext context) {
    return Expanded(
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            HeightPicker(context),
            WeightPicker(context),
          ],
        ),
      ),
    );
  }

  /** 키 픽커 위젯*/
  Widget HeightPicker(BuildContext context) {
    return ShowUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WheelNumberPicker(
            initialValue: 172,
            min: 1,
            max: 230,
          ),
          SizedBox(height: 18),
          Text(
            getApplocalizations(context)?.welcome_text_height_unit ?? "",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
      delay: showUpDuration,
    );
  }

  /** 몸무게 픽커 위젯*/
  Widget WeightPicker(BuildContext context) {
    return ShowUp(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          WheelNumberPicker(
            initialValue: 65,
            min: 1,
            max: 150,
          ),
          SizedBox(height: 18),
          Text(
            getApplocalizations(context)?.welcome_text_weight_unit ?? "",
            style: Theme.of(context).textTheme.headlineLarge?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
          ),
        ],
      ),
      delay: showUpDuration,
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return FillButton(
      onTap: () {
        changePage(context, PageAction.NEXT);
      },
      child: Text(
        getApplocalizations(context)?.welcome_button_next ?? "",
        style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: Theme.of(context).colorScheme.onPrimary,
            ),
      ),
    );
  }
}
