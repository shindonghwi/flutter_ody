import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/domain/models/auth/LoginPlatform.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class MyUserInfo extends HookConsumerWidget {
  const MyUserInfo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.read(meInfoProvider);

    useEffect(() {
      if (meInfo == null) {
        Navigator.pushReplacement(
          context,
          nextSlideScreen(RoutingScreen.Login.route),
        );
      }
    }, []);

    return meInfo != null
        ? Container(
            margin: const EdgeInsets.fromLTRB(18, 26, 18, 0),
            child: Column(
              children: [
                _nicknameAndSetting(context, meInfo.nick),
                const SizedBox(height: 2),
                _userEmail(context, meInfo.email,),
              ],
            ),
          )
        : const CircleLoading();
  }

  /// 사용자 닉네임 및 설정 아이콘
  Row _nicknameAndSetting(BuildContext context, String nick) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        _nickname(context, nick),
        _setting(context),
      ],
    );
  }

  Widget _nickname(BuildContext context, String nick) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.EditMyInfo.route),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                nick,
                style: getTextTheme(context).t2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              Container(
                margin: const EdgeInsets.only(left: 4),
                child: SvgPicture.asset(
                  "assets/imgs/icon_next_1_5_large.svg",
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
            onTap: () {
              Navigator.push(
                context,
                nextSlideScreen(RoutingScreen.Setting.route),
              );
            },
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

  /// 사용자 이메일
  Widget _userEmail(BuildContext context, String email) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Align(
        alignment: Alignment.centerLeft,
        child: Text(
          email,
          style: getTextTheme(context).c2r.copyWith(
            color: getColorScheme(context).colorText,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
