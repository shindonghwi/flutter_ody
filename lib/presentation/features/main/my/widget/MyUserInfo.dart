import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class MyUserInfo extends HookWidget {
  const MyUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.fromLTRB(18, 26, 18, 0),
      child: Column(
        children: [
          _nicknameAndSetting(context),
          const SizedBox(height: 2),
          _userEmail(context)
        ],
      ),
    );
  }

  /// 사용자 닉네임 및 설정 아이콘
  Row _nicknameAndSetting(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _nickname(context),
        _setting(context),
      ],
    );
  }

  Widget _nickname(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "운동하는 다람쥐",
                style: getTextTheme(context).t2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: SvgPicture.asset(
                  "assets/imgs/icon_next_1_5.svg",
                  width: 24,
                  height: 24,
                  colorFilter: ColorFilter.mode(
                    getColorScheme(context).neutral60,
                    BlendMode.srcIn,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _setting(BuildContext context) {
    return Expanded(
      child: Material(
        color: Colors.transparent,
        child: Align(
          alignment: Alignment.centerRight,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.all(6.0),
              child: SvgPicture.asset(
                "assets/imgs/icon_setting.svg",
                width: 24,
                height: 24,
              ),
            ),
          ),
        ),
      ),
    );
  }

  /// 사용자 가입 소셜 및 이메일
  Row _userEmail(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Image.asset(
          "assets/imgs/icon_kakao.png",
          width: 24,
          height: 24,
        ),
        const SizedBox(
          width: 8,
        ),
        Text(
          "sdsdsddd@orotcode.com",
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).colorText,
              ),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
