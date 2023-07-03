import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class ReportWalk extends HookWidget {
  const ReportWalk({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 43, 16, 0),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset(
                'assets/imgs/icon_shoes.png',
                width: 24,
                height: 24,
              ),
              const SizedBox(width: 8),
              Text(
                "걸음 수",
                style: getTextTheme(context).t1b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
            ],
          ),
          const SizedBox(height: 32),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "153,685",
                style: getTextTheme(context).t2b.copyWith(
                      color: getColorScheme(context).colorText,
                    ),
              ),
              const SizedBox(width: 8),
              Text(
                getAppLocalizations(context).common_walk,
                style: getTextTheme(context).b2b.copyWith(
                      color: getColorScheme(context).neutral70,
                    ),
              ),
            ],
          ),
          const SizedBox(
            height: 16,
          ),
          Container(
            height: 10,
            width: double.infinity,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  getColorScheme(context).primary100,
                  getColorScheme(context).colorPrimaryDisable,
                ],
                stops: [0.4, 0.4],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
              borderRadius: BorderRadius.circular(100.0),
            ),
          ),
          const SizedBox(
            height: 16,
          ),
          Align(
            alignment: Alignment.centerRight,
            child: Text(
              getAppLocalizations(context).report_walking_description("280,000"),
              style: getTextTheme(context).c3m.copyWith(
                    color: getColorScheme(context).neutral60,
                  ),
            ),
          )
        ],
      ),
    );
  }
}
