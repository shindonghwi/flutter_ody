import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

/**
 * @feature: 소셜 로그인 메뉴 위젯
 *
 * @author: 2023/02/13 8:41 PM donghwishin
 *
 * @description{
 *   카카오, 구글, 애플 로그인 버튼을 표시
 *   상단 텍스트 표시
 * }
 */
class SocialLoginMenu extends StatelessWidget {
  const SocialLoginMenu({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Flexible(
          fit: FlexFit.tight,
          flex: 3,
          child: Container(
            margin: EdgeInsets.only(top: 200),
            child: Text(
              AppLocalizations.of(context).appDescription,
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            width: MediaQuery.of(context).size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Image.asset(
                  "assets/imgs/kakao_login.png",
                  width: 50,
                  height: 50,
                ),
                Image.asset(
                  "assets/imgs/google_login.png",
                  width: 50,
                  height: 50,
                ),
                Container(
                  width: 50,
                  height: 50,
                  child: Image.asset(
                    "assets/imgs/apple_login.png",
                    width: 50,
                    height: 50,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
