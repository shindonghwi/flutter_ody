import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/main/my/widget/AdBanner.dart';
import 'package:ody_flutter_app/presentation/features/main/my/widget/MyAlarmSetting.dart';
import 'package:ody_flutter_app/presentation/features/main/my/widget/MyReport.dart';
import 'package:ody_flutter_app/presentation/features/main/my/widget/MyUserInfo.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class MyScreen extends StatelessWidget {
  const MyScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI01,
      appBar: _appBar(context),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            const MyUserInfo(),
            // const AdBanner(),
            _divider(context),
            const MyReport(),
            _divider(context),
            const MyAlarmSetting()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _appBar(BuildContext context) {
    return AppBar(
      backgroundColor: getColorScheme(context).colorUI01,
      leadingWidth: double.infinity,
      leading: Padding(
        padding: const EdgeInsets.only(left: 16.0),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            getAppLocalizations(context).main_tab_my,
            style: getTextTheme(context).t2b.copyWith(
                  color: getColorScheme(context).colorText,
                ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
      bottomOpacity: 0.0,
      elevation: 0.0,
      automaticallyImplyLeading: false,
    );
  }

  Container _divider(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 8,
      color: getColorScheme(context).colorUI03,
    );
  }
}
