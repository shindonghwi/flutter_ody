import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/components/picker/WheelNumberPicker.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

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
          color: getColorScheme(context).background,
          width: getMediaQuery(context).size.width,
          height: getMediaQuery(context).size.height,
          padding: EdgeInsets.only(top: 120),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              AgePicker(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 ( 질문영역 )*/
  Widget TitleText(BuildContext context) {
    return ShowAnimation(
      child: Text(
        getApplocalizations(context).welcome_text_age_input,
        style: getTextTheme(context).titleLarge?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w700,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 나이 선택기 위젯 */
  Widget AgePicker(BuildContext context) {
    return Expanded(
      child: Container(
        width: getMediaQuery(context).size.width,
        child: ShowAnimation(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              WheelNumberPicker(initialValue: 52),
              Text(
                getApplocalizations(context).welcome_text_age_unit,
                style: getTextTheme(context).headlineLarge?.copyWith(
                      color: getColorScheme(context).onBackground,
                      fontWeight: FontWeight.w700,
                    ),
              ),
            ],
          ),
          type: ShowAnimationType.UP,
          initDelay: showDuration,
        ),
      ),
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return FillButton(
      onTap: () {
        changePage(context, PageAction.NEXT);
      },
      child: Text(
        getApplocalizations(context).welcome_button_next,
        style: getTextTheme(context).titleLarge?.copyWith(
              color: getColorScheme(context).onPrimary,
            ),
      ),
    );
  }
}
