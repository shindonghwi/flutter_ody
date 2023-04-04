import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/bottom_sheet/CommonBottomSheet.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

/**
 * @feature:  로그인 화면
 * @author: 2023/03/29 6:59 PM donghwishin
 */
class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final size = getMediaQuery(context).size;

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: SafeArea(
        child: Column(
          children: [
            _AppTitle(context, size),
            _SocialIconContainer(context, size.height),
          ],
        ),
      ),
    );
  }

  /** 위젯: 소셜 아이콘 및 로그인하기 타이틀 */
  Expanded _SocialIconContainer(BuildContext context, double height) {
    List<Pair?> socialItems = [
      Pair(
        'assets/imgs/image_kakao.png',
        () => CommonBottomSheet.showBottomSheet(context, height: height, child: Text("1111")),
      ),
      null,
      Pair(
        'assets/imgs/image_google.png',
        () => CommonBottomSheet.showBottomSheet(context, height: height, child: Text("As2222dasd")),
      ),
      null,
      Pair(
        'assets/imgs/image_apple.png',
        () => CommonBottomSheet.showBottomSheet(context, height: height, child: Text("33333")),
      ),
    ];

    return Expanded(
      child: Container(
        margin: EdgeInsets.only(bottom: height * 0.08),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            _SnsLoginTitle(context),
            _SocialIcons(socialItems),
          ],
        ),
      ),
    );
  }

  /** 소셜 아이콘 목록: 카카오, 구글, 애플 */
  Container _SocialIcons(List<Pair?> socialItems) {
    return Container(
      margin: EdgeInsets.only(top: 43),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socialItems.map((e) {
          if (e == null) {
            return SizedBox(
              width: 28,
            );
          } else {
            return InkWell(
              onTap: e.second,
              child: Image.asset(
                e.first,
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  /** 위젯: SNS 계정으로 로그인하기 */
  Row _SnsLoginTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(height: 1, width: 25, color: getColorScheme(context).neutral50),
        Container(
          margin: EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            getAppLocalizations(context).login_sns,
            style: getTextTheme(context).b3.copyWith(
                  color: getColorScheme(context).neutral50,
                ),
          ),
        ),
        Container(height: 1, width: 25, color: getColorScheme(context).neutral50),
      ],
    );
  }

  /** 위젯: 앱 로고 및 타이틀*/
  Align _AppTitle(BuildContext context, Size size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 47,
          top: size.height * 0.17,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/imgs/logo_ody.png',
            ),
            Container(
              margin: EdgeInsets.only(top: 20),
              child: Text(
                getAppLocalizations(context).login_title,
                style: getTextTheme(context).h2.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
