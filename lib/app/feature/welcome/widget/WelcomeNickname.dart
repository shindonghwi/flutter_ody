import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/input/OutlineTextField.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/app/utils/Common.dart';

/**
 * @feature: 닉네임 입력화면
 * @author: 2023/02/14 1:42 PM donghwishin
 */
class WelcomeNickname extends StatelessWidget {
  final Function changePage;

  WelcomeNickname({Key? key, required this.changePage}) : super(key: key);

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
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: WillPopScope(
        onWillPop: () async => changePage(context, PageAction.PREVIOUS),
        child: Container(
          color: getColorScheme(context).background,
          padding: EdgeInsets.only(left: 20, right: 20, top: 48),
          width: getMediaQuery(context).size.width,
          child: Column(
            children: [
              TitleText(context),
              SizedBox(height: 70),
              InputNickname(context),
            ],
          ),
        ),
      ),
      bottomSheet: BottomButton(context),
    );
  }

  /** 상단 텍스트 - 앱 소개 글 */
  Widget TitleText(BuildContext context) {
    return Text(
      getApplocalizations(context).welcome_text_nickname_title,
      style: getTextTheme(context).headlineSmall?.copyWith(
            color: getColorScheme(context).onBackground,
            fontWeight: FontWeight.w500,
          ),
    );
  }

  /** 닉네임 입력공간 */
  Widget InputNickname(BuildContext context) {
    return Container(
      width: getMediaQuery(context).size.width * 0.6,
      child: OutlineTextField(
        maxLength: 7,
        hintText: getApplocalizations(context).common_input_hint,
        textCallback: (value) {
          debugPrint("value : $value");
        },
      ),
    );
  }

  /** 바텀 버튼 ( 시작하기 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context).common_start,
          style: getTextTheme(context).titleMedium?.copyWith(
                color: getColorScheme(context).onPrimary,
                fontWeight: FontWeight.w600,
              ),
        ),
      ),
    );
  }
}
