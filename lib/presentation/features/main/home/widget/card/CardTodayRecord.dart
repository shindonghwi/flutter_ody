import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/presentation/features/main/home/model/CalendarSize.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/PainterCircleProgress.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateTransfer.dart';

class CardTodayRecord extends HookConsumerWidget {
  final ResponseBioForDaysModel model;

  const CardTodayRecord({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime currentDateTime = ref.watch(calendarSelectDateProvider);

    bool isToday = DateChecker.isDateToday(currentDateTime);

    return Container(
      width: double.infinity,
      height: 120,
      margin: EdgeInsets.only(top: CalendarSize.underMargin(context)),
      padding: const EdgeInsets.fromLTRB(24, 20, 8, 20),
      decoration: BoxDecoration(
        color: getColorScheme(context).primary100,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: const Color(0xFF8D8D8D).withOpacity(0.1),
            spreadRadius: 0,
            blurRadius: 5,
            offset: const Offset(2, 2), // changes position of shadow
          ),
        ],
      ),
      child: Row(
        children: [
          _percentageCircleProgressBar(context), // 원형 프로그래스바
          Expanded(
            child: Center(
              child: _recordInfo(context, isToday, currentDateTime),
            ),
          ), // 오늘의 기록 정보
        ],
      ),
    );
  }

  int getCompleteCount(ResponseBioForDaysModel model) {
    int completeCount = 0;
    completeCount += model.steps.isNotEmpty ? 1 : 0;
    completeCount += model.bloodPressures.isNotEmpty ? 1 : 0;
    completeCount += model.glucoses.isNotEmpty ? 1 : 0;
    return completeCount;
  }

  String getComment(BuildContext context, ResponseBioForDaysModel model, bool isToday) {
    int completeCount = getCompleteCount(model);
    if (isToday) {
      switch (completeCount) {
        case 0:
          return getAppLocalizations(context).home_today_record_comment_start;
        case 1:
          return getAppLocalizations(context).home_today_record_comment_fighting;
        case 2:
          return getAppLocalizations(context).home_today_record_comment_progress;
        default:
          return getAppLocalizations(context).home_today_record_comment_complete;
      }
    } else {
      switch (completeCount) {
        case 0:
          return getAppLocalizations(context).home_today_record_comment_not_recorded;
        default:
          return getAppLocalizations(context).home_today_record_comment_thank_you;
      }
    }
  }

  Column _recordInfo(BuildContext context, bool isToday, DateTime currentDateTime) {
    int completeCount = getCompleteCount(model);
    String comment = getComment(context, model, isToday);

    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isToday
              ? getAppLocalizations(context).home_today_record_title
              : DateTransfer.dateTimeToMonthDayRecord(currentDateTime),
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).white,
              ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "$completeCount / 3",
                style: getTextTheme(context).b2b.copyWith(
                      color: getColorScheme(context).white,
                    ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 8),
              ),
              TextSpan(
                text: getAppLocalizations(context).home_today_record_comment_complete_count_success,
                style: getTextTheme(context).c2b.copyWith(
                      color: getColorScheme(context).white.withOpacity(0.5),
                    ),
              ),
            ],
          ),
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          comment,
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).white,
              ),
        ),
      ],
    );
  }

  Widget _percentageCircleProgressBar(BuildContext context) {
    double percentage = 0.0;

    switch (getCompleteCount(model)) {
      case 0:
        percentage = 0.0;
        break;
      case 1:
        percentage = 0.3;
        break;
      case 2:
        percentage = 0.7;
        break;
      case 3:
        percentage = 1.0;
        break;
    }

    getCompleteCount(model);

    return SizedBox(
      width: 90,
      height: 90,
      child: Stack(
        children: [
          CustomCircle(
            percentage: percentage,
            activeColor: getColorScheme(context).white,
            defaultColor: getColorScheme(context).white.withOpacity(0.3),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "${(percentage * 100).toInt()}%",
              style: getTextTheme(context).b2b.copyWith(
                    color: getColorScheme(context).white,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
