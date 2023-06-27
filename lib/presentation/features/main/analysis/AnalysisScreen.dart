import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/features/main/analysis/widget/AnalysisTabItemTitle.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';

// Navigator.push(
// context,
// nextSlideScreen(RoutingScreen.AnalysisGlucose.route),
// );

class AnalysisScreen extends HookConsumerWidget {
  const AnalysisScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentPageDatetime = ref.watch<DateTime>(calendarPageProvider);
    final uiState = ref.watch(forDaysBioInfoProvider);

    return Scaffold(
      backgroundColor: getColorScheme(context).colorUI02,
      body: Stack(
        children: [
          Container(
            color: getColorScheme(context).colorUI02,
            margin: EdgeInsets.only(top: CalendarSize.underMargin(context), left: 20, right: 20),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    DateTransfer.dateTimeToYearMonthDayYoil(currentPageDatetime),
                    style: getTextTheme(context).t2b.copyWith(
                          color: getColorScheme(context).colorText,
                        ),
                  ),
                  const SizedBox(
                    height: 22,
                  ),
                  AnalysisTabItemTitle(title: getAppLocalizations(context).home_today_record_walk),
                  AnalysisTabItemTitle(
                    title: getAppLocalizations(context).home_today_record_blood_pressure,
                    movePage: () {
                      Navigator.push(
                        context,
                        nextSlideScreen(RoutingScreen.AnalysisBloodPressure.route),
                      );
                    },
                  ),
                  AnalysisTabItemTitle(
                    title: getAppLocalizations(context).home_today_record_glucose,
                    movePage: () {
                      Navigator.push(
                        context,
                        nextSlideScreen(RoutingScreen.AnalysisGlucose.route),
                      );
                    },
                  ),
                ],
              ),
            ),
          ),
          if (uiState is Loading) const CircleLoading()
        ],
      ),
    );
  }
}
