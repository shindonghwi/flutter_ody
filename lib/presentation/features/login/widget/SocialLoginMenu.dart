import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/features/welcome/WelcomeScreen.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

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
              getApplocalizations(context).appDescription,
              style: getTextTheme(context).bodyLarge?.copyWith(
                    color: getColorScheme(context).onPrimary,
                  ),
            ),
          ),
        ),
        Flexible(
          fit: FlexFit.tight,
          flex: 1,
          child: Container(
            width: getMediaQuery(context).size.width,
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

  const SocialLoginIcon({Key? key, required this.iconPath, required this.onTap}) : super(key: key);

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
