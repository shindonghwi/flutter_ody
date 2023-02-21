import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:odac_flutter_app/app/feature/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/app/feature/components/input/OutlineTextField.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

/**
 * @feature: 생년 월 일 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeBirthday extends StatelessWidget {
  final Function changePage;

  WelcomeBirthday({Key? key, required this.changePage}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).background,
      appBar: LeftIconAppBar(
        leftIcon: IconButton(
          icon: Icon(
            Icons.arrow_back,
            size: 20,
            color: getColorScheme(context).onBackground,
          ),
          onPressed: () async => changePage(context, PageAction.PREVIOUS),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: getColorScheme(context).background,
          width: getMediaQuery(context).size.width,
          height: getMediaQuery(context).size.height,
          padding: EdgeInsets.only(top: 48),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              TitleText(context),
              SizedBox(height: 70),
              InputBirthDay(context),
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
        getApplocalizations(context).welcome_text_birthday_title,
        style: getTextTheme(context).headlineSmall?.copyWith(
              color: getColorScheme(context).onBackground,
              fontWeight: FontWeight.w500,
            ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 나이 입력공간 */
  Widget InputBirthDay(BuildContext context) {
    return ShowAnimation(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          InputContent(context, "년"),
          InputContent(context, "월"),
          InputContent(context, "일"),
        ],
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼 ( 다음 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context).common_next,
          style: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).onPrimary,
              ),
        ),
      ),
    );
  }

  Widget InputContent(BuildContext context, String type) {
    double widthRatio = 0.2;
    int maxLength = 4;
    String hintText = "1987";
    TextInputAction keyboardAction = TextInputAction.next;

    switch (type) {
      case "년":
        break;
      case "월":
        widthRatio = 0.15;
        hintText = "06";
        maxLength = 2;
        break;
      case "일":
        widthRatio = 0.15;
        hintText = "12";
        maxLength = 2;
        keyboardAction = TextInputAction.done;
        break;
    }

    return Row(
      children: [
        Container(
          width: getMediaQuery(context).size.width * widthRatio,
          child: OutlineTextField(
            maxLength: maxLength,
            hintText: hintText,
            textCallback: (value) {
              debugPrint("value : $value");
            },
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            keyboardAction: keyboardAction,
            actionCallback: () {
              if (keyboardAction == TextInputAction.done) {
                FocusScope.of(context).unfocus();
              } else {
                FocusScope.of(context).nextFocus();
              }
            },
          ),
        ),
        SizedBox(
          width: 10,
        ),
        Text(
          type,
          style: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).onBackground,
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
