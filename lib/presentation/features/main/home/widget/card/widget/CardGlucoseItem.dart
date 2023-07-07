import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';

class CardGlucoseItem extends HookConsumerWidget {
  final List<ResponseBioGlucoseModel>? glucoseDataList;

  const CardGlucoseItem({
    Key? key,
    required this.glucoseDataList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime currentDateTime = ref.read(calendarPageProvider.notifier).getCurrentDateTime();
    bool isToday = false;

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        isToday = DateChecker.isDateToday(currentDateTime);
      });
    }, [currentDateTime]);

    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double desiredRatio = 0.89;

        return Container(
          decoration: BoxDecoration(
            color: getColorScheme(context).white,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () {
                Navigator.push(
                  context,
                  nextSlideScreen(
                    RoutingScreen.RecordedListGlucose.route,
                    parameter: currentDateTime,
                  ),
                );
              },
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: desiredRatio,
                child: SizedBox(
                  width: width,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getAppLocalizations(context).home_today_record_glucose,
                              style: getTextTheme(context).b3sb.copyWith(
                                color: getColorScheme(context).neutral70,
                              ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            !CollectionUtil.isNullorEmpty(glucoseDataList)
                                ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: RichText(
                                    text: TextSpan(
                                      children: [
                                        TextSpan(
                                          text: "${glucoseDataList!.last.glucose}",
                                          style: getTextTheme(context).t2b.copyWith(
                                            color: getGlucoseTextColor(context),
                                          ),
                                        ),
                                        const WidgetSpan(
                                          child: SizedBox(width: 8),
                                        ),
                                        TextSpan(
                                          text: getAppLocalizations(context).home_today_record_glucose_unit,
                                          style: getTextTheme(context).c1b.copyWith(
                                            color: getColorScheme(context).neutral60,
                                          ),
                                        ),
                                      ],
                                    ),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            )
                                : Text(
                              isToday
                                  ? getAppLocalizations(context).home_today_record_ment_default
                                  : getAppLocalizations(context).home_today_record_ment_empty,
                              style: getTextTheme(context).b2b.copyWith(
                                color: getColorScheme(context).colorText,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            width: 76,
                            height: 76,
                            RecordRangeStatusHelper.getOdyImagePath(
                              RecordType.Glucose,
                              CollectionUtil.isNullorEmpty(glucoseDataList)
                                  ? RecordRangeStatus.None
                                  : RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(
                                glucoseDataList!.last.status.code,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Color getGlucoseTextColor(BuildContext context) {
    final status = RecordRangeStatusHelper.getGlucoseRecordRangeStatusFromCode(glucoseDataList!.last.status.code);

    if (status == RecordRangeStatus.Normal) {
      return getColorScheme(context).colorText;
    }
    else if (status == RecordRangeStatus.Warn || status == RecordRangeStatus.Alert) {
      return getColorScheme(context).colorError;
    } else {
      return getColorScheme(context).neutral70;
    }
  }

}
