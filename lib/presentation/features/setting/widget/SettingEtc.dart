import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class SettingEtc extends HookWidget {
  const SettingEtc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 18, right: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 기타 타이틀
          _title(context),

          // 버전정보
          const SizedBox(height: 24),
          _versionInfo(context),

          // 최신버전
          const SizedBox(height: 6),
          _latestInfo(context, latestVersion: "0.0.1v"),

          // 로그아웃
          const SizedBox(height: 24),
          _logout(context),

          // 탈퇴하기
          const SizedBox(height: 16),
          _withdrawal(context),
        ],
      ),
    );
  }

  Text _title(BuildContext context) {
    return Text(
      getAppLocalizations(context).setting_sub_menu_etc,
      style: getTextTheme(context).t2b.copyWith(
            color: getColorScheme(context).colorText,
          ),
    );
  }

  Widget _versionInfo(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            getAppLocalizations(context).setting_sub_menu_etc_version,
            style: getTextTheme(context).t4m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          Text(
            "0.0.1 v",
            style: getTextTheme(context).b2b.copyWith(
                  color: getColorScheme(context).primary100,
                ),
          ),
        ],
      ),
    );
  }

  Widget _latestInfo(BuildContext context, {required String latestVersion}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "${getAppLocalizations(context).setting_sub_menu_etc_version_latest} : $latestVersion",
        style: getTextTheme(context).c2r.copyWith(
              color: getColorScheme(context).neutral70,
            ),
      ),
    );
  }

  Widget _logout(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.Withdrawal.route),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getAppLocalizations(context).setting_sub_menu_etc_logout,
            style: getTextTheme(context).t4m.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
        ),
      ),
    );
  }

  Widget _withdrawal(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.Withdrawal.route),
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            getAppLocalizations(context).setting_sub_menu_etc_withdrawal,
            style: getTextTheme(context).c2b.copyWith(
                  color: getColorScheme(context).neutral70,
                ),
          ),
        ),
      ),
    );
  }
}
