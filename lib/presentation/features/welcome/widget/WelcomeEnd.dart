import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/appbar/LeftIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/button/FillButton.dart';
import 'package:odac_flutter_app/presentation/components/common/ShowAnimation.dart';
import 'package:odac_flutter_app/presentation/features/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

/**
 * @feature: 질문 완료 화면
 *
 * @author: 2023/02/21 7:20 PM donghwishin
 */
class WelcomeEnd extends StatelessWidget {
  final Function changePage;

  WelcomeEnd({Key? key, required this.changePage}) : super(key: key);

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
            children: [
              TitleText(context),
              SubTitleText(context),
              CongratulationImage(context),
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
      child: Container(
        width: getMediaQuery(context).size.width,
        child: Text(
          getApplocalizations(context).welcome_text_end_title,
          style: getTextTheme(context).headlineSmall?.copyWith(
                color: getColorScheme(context).onBackground,
                fontWeight: FontWeight.w500,
              ),
          textAlign: TextAlign.center,
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 서브 텍스트 ( 질문영역 )*/
  Widget SubTitleText(BuildContext context) {
    return ShowAnimation(
      child: Container(
        width: getMediaQuery(context).size.width,
        margin: EdgeInsets.only(top: 48, left: 20),
        child: Text(
          // TODO: 사용자 이름 받아오기
          getApplocalizations(context).welcome_text_end_subtitle("운동하는다람쥐"),
          style: getTextTheme(context).titleSmall?.copyWith(
                color: getColorScheme(context).onBackground.withOpacity(0.8),
                fontWeight: FontWeight.w700,
              ),
          textAlign: TextAlign.start,
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 축하 이미지 */
  Widget CongratulationImage(BuildContext context) {
    return ShowAnimation(
      child: Container(
        margin: EdgeInsets.only(top: getMediaQuery(context).size.height * 0.05),
        child: Image.asset(
          "assets/imgs/congratulation.png",
          width: getMediaQuery(context).size.width * 0.8,
          height: getMediaQuery(context).size.width * 0.8,
          fit: BoxFit.fill,
        ),
      ),
      type: ShowAnimationType.UP,
      initDelay: showDuration,
    );
  }

  /** 바텀 버튼 ( 오디 시작하기 ) */
  Widget BottomButton(BuildContext context) {
    return Container(
      color: getColorScheme(context).onPrimary,
      padding: EdgeInsets.only(left: 20, right: 20, bottom: 40),
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          "\"${getApplocalizations(context).appTitle}\" ${getApplocalizations(context).common_start}",
          style: getTextTheme(context).titleLarge?.copyWith(
                color: getColorScheme(context).onPrimary,
              ),
        ),
      ),
    );
  }
}
