import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:get_it/get_it.dart';
import 'package:odac_flutter_app/domain/usecases/remote/auth/PostGoogleSignInUseCase.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

/// @feature:  로그인 화면
/// @author: 2023/03/29 6:59 PM donghwishin
class LoginScreen extends HookWidget {
  const LoginScreen({Key? key}) : super(key: key);

  PostGoogleSignInUseCase get _postGoogleSIgnInUseCase =>
      GetIt.instance<PostGoogleSignInUseCase>();

  @override
  Widget build(BuildContext context) {
    final size = getMediaQuery(context).size;

    return Scaffold(
      appBar: AppBar(
        backgroundColor: getColorScheme(context).colorUIBackground,
        elevation: 0,
      ),
      backgroundColor: getColorScheme(context).colorUIBackground,
      body: SafeArea(
        child: loginContent(context, size),
      ),
    );
  }

  Column loginContent(BuildContext context, Size size) {
    return Column(
      children: [
        _AppTitle(context, size),
        _socialIconContainer(context, size.height * 0.48),
      ],
    );
  }

  /// 위젯: 소셜 아이콘 및 로그인하기 타이틀
  Expanded _socialIconContainer(BuildContext context, double height) {
    List<Pair?> socialItems = [
      Pair('assets/imgs/image_kakao.png', () {}),
      null,
      Pair('assets/imgs/image_google.png', () {
        _postGoogleSIgnInUseCase.call();
      }),
      null,
      Pair('assets/imgs/image_apple.png', () {}),
    ];

    final List<String> termList = [
      getAppLocalizations(context).login_signup_description1,
      getAppLocalizations(context).login_signup_description2,
      getAppLocalizations(context).login_signup_description3,
      getAppLocalizations(context).login_signup_description4,
      getAppLocalizations(context).login_signup_description5,
    ];

    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          _snsLoginTitle(context),
          _socialIcons(socialItems),
          _termText(termList, context)
        ],
      ),
    );
  }

  Widget _termText(List<String> termList, BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 48, bottom: 40),
      child: RichText(
        text: TextSpan(
            children: termList
                .asMap()
                .entries
                .map((e) {
              int index = e.key;
              String term = e.value;
              return TextSpan(
                text: term,
                style: getTextTheme(context).c3m.copyWith(
                  color: index % 2 != 0
                      ? getColorScheme(context).neutral80
                      : getColorScheme(context).neutral60,
                  height: 1.1,
                ),
              );
            }).toList()),
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
      ),
    );
  }

  /// 소셜 아이콘 목록: 카카오, 구글, 애플
  Container _socialIcons(List<Pair?> socialItems) {
    return Container(
      margin: const EdgeInsets.only(top: 32),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: socialItems.map((e) {
          if (e == null) {
            return const SizedBox(
              width: 28,
            );
          } else {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                borderRadius: BorderRadius.circular(100),
                onTap: e.second,
                child: Padding(
                  padding: const EdgeInsets.all(2.0),
                  child: Image.asset(
                    e.first,
                  ),
                ),
              ),
            );
          }
        }).toList(),
      ),
    );
  }

  /// 위젯: SNS 계정으로 로그인하기
  Row _snsLoginTitle(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(height: 1.5, width: 20, color: getColorScheme(context).neutral60),
        Container(
          margin: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            getAppLocalizations(context).login_sns,
            style: getTextTheme(context).b3r.copyWith(
              color: getColorScheme(context).neutral60,
            ),
            textAlign: TextAlign.center,
          ),
        ),
        Container(height: 1.5, width: 20, color: getColorScheme(context).neutral60),
      ],
    );
  }

  /// 위젯: 앱 로고 및 타이틀
  Align _AppTitle(BuildContext context, Size size) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Container(
        margin: EdgeInsets.only(
          left: 48,
          top: size.height * 0.075,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset(
              'assets/imgs/logo_ody.png',
            ),
            Container(
              margin: const EdgeInsets.only(top: 24),
              child: Text(
                getAppLocalizations(context).login_title,
                style: getTextTheme(context).h2sb.copyWith(
                  color: getColorScheme(context).colorText,
                  height: 1.25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
