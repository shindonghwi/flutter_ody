import 'package:flutter/material.dart';
import 'package:odac_flutter_app/app/feature/components/button/FillButton.dart';
import 'package:odac_flutter_app/app/feature/components/common/ShowUp.dart';
import 'package:odac_flutter_app/app/feature/welcome/model/PageAction.dart';
import 'package:odac_flutter_app/l10n/Common.dart';

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
          padding: EdgeInsets.only(left: 20, right: 20, top: 120),
          width: MediaQuery.of(context).size.width,
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
        ShowUp(
          child: Text(
            getApplocalizations(context)?.welcome_text_greeting ?? "",
            style: Theme.of(context).textTheme.displaySmall?.copyWith(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontWeight: FontWeight.w700,
                ),
          ),
          delay: 300,
        ),
        SizedBox(height: 80),
        ShowUp(
          child: Text(
            getApplocalizations(context)?.welcome_text_greeting_description ?? "",
            style: Theme.of(context).textTheme.titleMedium?.copyWith(
                color: Theme.of(context).colorScheme.onBackground, fontWeight: FontWeight.w800),
          ),
          delay: 400,
        )
      ],
    );
  }

  /** 바텀 버튼 ( 시작하기 ) */
  Widget BottomButton(BuildContext context) {
    return ShowUp(
      child: FillButton(
        onTap: () async => changePage(context, PageAction.NEXT),
        child: Text(
          getApplocalizations(context)?.welcome_button_start ?? "",
          style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.onPrimary,
              ),
        ),
      ),
      delay: 300,
    );
  }
}
