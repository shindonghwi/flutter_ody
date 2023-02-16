import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

/**
 * @feature: 앱 소개화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeIntroduce extends StatelessWidget {
  final Function changePage;

  WelcomeIntroduce({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: getColorScheme(context).background,
          padding: EdgeInsets.only(left: 20, right: 20, top: 120),
          width: getMediaQuery(context).size.width,
          child: TitleText(context),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 - 앱 소개 글 */
  Widget TitleText(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ShowAnimation(
          child: Text(
            getApplocalizations(context).welcome_text_greeting,
            style: getTextTheme(context).displaySmall?.copyWith(
                  color: getColorScheme(context).onBackground,
                  fontWeight: FontWeight.w700,
                ),
          ),
          type: ShowAnimationType.UP,
          initDelay: showDuration,
        ),
        SizedBox(height: 80),
        ShowAnimation(
          child: Text(
            getApplocalizations(context).welcome_text_greeting_description,
            style: getTextTheme(context).titleMedium?.copyWith(
                  color: getColorScheme(context).onBackground,
                  fontWeight: FontWeight.w800,
                ),
          ),
          type: ShowAnimationType.UP,
          initDelay: showDuration,
        )
      ],
    );
  }

  /** 바텀 버튼 ( 시작하기 ) */
  Widget BottomButton(BuildContext context) {
    return FillButton(
      onTap: () async => changePage(context, PageAction.NEXT),
      child: Text(
        getApplocalizations(context).welcome_button_start,
        style: getTextTheme(context).titleLarge?.copyWith(
              color: getColorScheme(context).onPrimary,
            ),
      ),
    );
  }
}
