import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/app/env/Environment.dart';
import 'package:ody_flutter_app/firebase/FirebaseRemoteConfigService.dart';
import 'package:ody_flutter_app/presentation/components/popup/PopupUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingEtc extends HookWidget {
  const SettingEtc({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final remoteConfig = FirebaseRemoteConfigService();

    final latestVersion = Platform.isAndroid
        ? remoteConfig.aosVersionFromStore
        : remoteConfig.iosVersionFromStore;

    debugPrint("latestVersion: $latestVersion");

    return Container(
      padding: const EdgeInsets.only(left: 18, right: 24, top: 32, bottom: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // 기타 타이틀
          _title(context),

          // 버전정보
          const SizedBox(height: 24),
          _versionInfo(context, latestVersion: latestVersion),

          // 최신버전
          const SizedBox(height: 6),
          _latestInfo(context, latestVersion: latestVersion),

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

  Widget _versionInfo(BuildContext context, {required String latestVersion}) {
    final currentVersion = useState("");
    final packageName = useState("");

    useEffect(() {
      void getPackageInfo() async {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        packageName.value = packageInfo.packageName;
        currentVersion.value =
            Environment.buildType == BuildType.dev ? packageInfo.version.replaceAll(".dev", "") : packageInfo.version;
      }

      getPackageInfo();
      return null;
    }, []);

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
          Row(
            children: [
              if (currentVersion.value.compareTo(latestVersion) == 0)
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(100),
                    color: getColorScheme(context).primary100,
                  ),
                  margin: const EdgeInsets.only(right: 12),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: () async {
                        final url = Platform.isAndroid
                            ? 'https://play.google.com/store/apps/details?id=${packageName.value}'
                            : 'https://apps.apple.com/us/app/${packageName.value}';
                        launchUrl(Uri.parse(url), mode: LaunchMode.externalApplication);
                      },
                      borderRadius: BorderRadius.circular(100),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6.5),
                        child: Text(
                          getAppLocalizations(context).setting_sub_menu_etc_version_update,
                          style: getTextTheme(context).l3m.copyWith(
                                color: getColorScheme(context).white,
                              ),
                        ),
                      ),
                    ),
                  ),
                ),
              Text(
                "${currentVersion.value} v",
                style: getTextTheme(context).b2b.copyWith(
                      color: getColorScheme(context).primary100,
                    ),
              ),
            ],
          )
        ],
      ),
    );
  }

  Widget _latestInfo(BuildContext context, {required String latestVersion}) {
    return Padding(
      padding: const EdgeInsets.only(left: 8.0),
      child: Text(
        "${getAppLocalizations(context).setting_sub_menu_etc_version_latest} : ${latestVersion}v",
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
          PopupUtil.showLogout(backgroundTouchCloseFlag: true);
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
