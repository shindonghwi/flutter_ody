import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleIconAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/IconTitleTextAppBar.dart';
import 'package:odac_flutter_app/presentation/components/appbar/model/AppBarIcon.dart';
import 'package:odac_flutter_app/presentation/components/empty/EmptyView.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordedListBloodPressureScreen extends StatelessWidget {
  const RecordedListBloodPressureScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: IconTitleIconAppBar(
        leadingIcon: AppBarIcon(
          path: 'assets/imgs/icon_back.svg',
          onPressed: () => Navigator.of(context).pop(),
        ),
        title: getAppLocalizations(context).list_record_blood_pressure_title,
        // actionIcon: AppBarIcon(
        //   path: 'assets/imgs/icon_record.svg',
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       nextSlideScreen(RoutingScreen.RecordBloodPressure.route),
        //     );
        //   },
        // )
      ),
      backgroundColor: getColorScheme(context).colorUI01,
      body: Center(
        child: EmptyView(
          screen: RoutingScreen.RecordedListBloodPressure,
          onPressed: () {
            Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.RecordBloodPressure.route),
            );
          },
        ),
      ),
    );
  }
}
