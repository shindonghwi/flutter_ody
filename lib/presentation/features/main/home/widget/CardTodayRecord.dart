import 'dart:math' as math;

import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/features/main/home/widget/PainterCircleProgress.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class CardTodayRecord extends HookWidget {
  const CardTodayRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 120,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      padding: const EdgeInsets.fromLTRB(24, 20, 8, 20),
      decoration: BoxDecoration(
        color: getColorScheme(context).neutral50,
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
          _PercentageCircleProgressBar(context), // 원형 프로그래스바
          Expanded(
            child: Center(
              child: _RecordInfo(context),
            ),
          ), // 오늘의 기록 정보
        ],
      ),
    );
  }

  Column _RecordInfo(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).home_today_record_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).white,
              ),
        ),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: "0 / 3",
                style: getTextTheme(context).b2b.copyWith(
                      color: getColorScheme(context).white,
                    ),
              ),
              const WidgetSpan(
                child: SizedBox(width: 8),
              ),
              TextSpan(
                text: "달성했어요",
                style: getTextTheme(context).c2b.copyWith(
                      color: getColorScheme(context).white.withOpacity(0.5),
                    ),
              ),
            ],
          ),
          // textAlign: TextAlign.center,
          overflow: TextOverflow.ellipsis,
        ),
        Text(
          "새로운 기록을 달성해볼까요?",
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).white,
              ),
        ),
      ],
    );
  }

  Widget _PercentageCircleProgressBar(BuildContext context) {
    return SizedBox(
      width: 70,
      height: 70,
      child: Stack(
        children: [
          Transform.rotate(
            angle: math.pi * 7 / 6,
            child: CustomPaint(
              painter: PainterCircleProgress(
                progress: 1,
              ),
              child: Container(),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Text(
              "30%",
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
