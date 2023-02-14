import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odac_flutter_app/app/feature/welcome/WelcomeScreen.dart';

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
  SocialLoginMenu({Key? key}) : super(key: key);

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
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                    color: Theme.of(context).colorScheme.onPrimary,
                  ),
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
                SocialLoginIcon(
                  iconPath: "assets/imgs/kakao_login.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
                SocialLoginIcon(
                  iconPath: "assets/imgs/google_login.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
                SocialLoginIcon(
                  iconPath: "assets/imgs/apple_login.png",
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => WelcomeScreen()),
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class SocialLoginIcon extends StatelessWidget {
  final String iconPath;
  final Function onTap;

  const SocialLoginIcon({Key? key, required this.iconPath, required this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Image.asset(
        iconPath,
        width: 50,
        height: 50,
      ),
    );
  }
}
