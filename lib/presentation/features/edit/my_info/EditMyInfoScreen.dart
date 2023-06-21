import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:ody_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:ody_flutter_app/presentation/features/edit/my_nickname/EditMyNicknameScreen.dart';
import 'package:ody_flutter_app/presentation/features/main/my/provider/meInfoProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/dto/Triple.dart';

class EditMyInfoScreen extends HookConsumerWidget {
  const EditMyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final meInfo = ref.watch(meInfoProvider);
    final meInfoRead = ref.read(meInfoProvider.notifier);

    useEffect(() {
      if (meInfo == null) {
        Navigator.pushReplacement(
          context,
          nextSlideScreen(RoutingScreen.Login.route),
        );
      }
    }, []);

    final itemList = [
      Triple(
        getAppLocalizations(context).edit_my_info_title_nickname,
        meInfo?.nick ?? "",
        () async {
          final String callbackNick = await Navigator.push(
            context,
            nextSlideScreen(
              RoutingScreen.EditMyNickname.route,
              parameter: meInfo?.nick.toString() ?? "",
            ),
          );
          meInfoRead.updateMeInfoNick(callbackNick);
        },
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_height,
        meInfo?.profile.height ?? "",
        () async {
          final String callbackHeight = await Navigator.push(
            context,
            nextSlideScreen(
              RoutingScreen.EditMyHeight.route,
              parameter: meInfo?.profile.height?.toString() ?? "0",
            ),
          );
          meInfoRead.updateMeInfoHeight(int.parse(callbackHeight));
        },
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_weight,
        meInfo?.profile.weight ?? "",
        () async {
          final String callbackWeight = await Navigator.push(
            context,
            nextSlideScreen(
              RoutingScreen.EditMyWeight.route,
              parameter: meInfo?.profile.weight?.toString() ?? "0",
            ),
          );
          meInfoRead.updateMeInfoWeight(int.parse(callbackWeight));
        },
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_email,
        meInfo?.email ?? "",
        null,
      )
    ];

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: IconTitleTextAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: getAppLocalizations(context).edit_my_info_title,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Container(
          margin: const EdgeInsets.only(top: 8, left: 24, right: 24, bottom: 40),
          child: Column(
              children: itemList.map((e) {
            final title = e.first;
            final content = e.second;
            final action = e.third;

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Text(
                  title,
                  style: getTextTheme(context).c2r.copyWith(
                        color: getColorScheme(context).colorText,
                      ),
                ),
                const SizedBox(height: 16),
                Container(
                  width: double.infinity,
                  height: 50,
                  decoration: BoxDecoration(
                    color: _isTitleEmail(context, title)
                        ? getColorScheme(context).colorUI03
                        : getColorScheme(context).colorUI01,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: getColorScheme(context).neutral50,
                      width: 1.5,
                    ),
                  ),
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: action == null ? null : () => action.call(),
                      borderRadius: BorderRadius.circular(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            content.toString(),
                            style: getTextTheme(context).b2r.copyWith(
                                  color: getColorScheme(context).colorText,
                                ),
                          ),
                        ),
                      ),
                    ),
                  ),
                )
              ],
            );
          }).toList()),
        ),
      ),
    );
  }

  bool _isTitleEmail(BuildContext context, String title) {
    return title == getAppLocalizations(context).edit_my_info_title_email ? true : false;
  }
}
