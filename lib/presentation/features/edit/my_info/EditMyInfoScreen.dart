import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

class EditMyInfoScreen extends HookWidget {
  const EditMyInfoScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final itemList = [
      Triple(
        getAppLocalizations(context).edit_my_info_title_nickname,
        "운동하는 다람쥐",
        () {},
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_height,
        "178 cm",
        () {},
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_weight,
        "64 kg",
        () {},
      ),
      Triple(
        getAppLocalizations(context).edit_my_info_title_email,
        "rkgus2598@hanmail.net",
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
                      onTap: action == null ? null : () => action?.call(),
                      borderRadius: BorderRadius.circular(5),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 16.0),
                          child: Text(
                            content,
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
