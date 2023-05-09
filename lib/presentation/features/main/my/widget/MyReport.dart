import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

class MyReport extends HookWidget {
  const MyReport({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Triple> reportItems = [
      Triple(
        "assets/imgs/icon_weekly_report.png",
        "주간 보고서",
        () {},
      ),
      Triple(
        "assets/imgs/icon_monthly_report.png",
        "월간 보고서",
        () {},
      ),
    ];

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "보고서",
            style: getTextTheme(context).t2b.copyWith(
                  color: getColorScheme(context).colorText,
                ),
          ),
          const SizedBox(height: 16),
          Column(
              children: reportItems.map((e) {
            return Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => e.third(),
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  child: Row(
                    children: [
                      Image.asset(
                        e.first,
                        width: 24,
                        height: 24,
                      ),
                      const SizedBox(width: 10),
                      Text(
                        e.second,
                        style: getTextTheme(context).t4m.copyWith(
                              color: getColorScheme(context).colorText,
                            ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.centerRight,
                          child: SvgPicture.asset(
                            "assets/imgs/icon_next_1_5.svg",
                            width: 24,
                            height: 24,
                            colorFilter: ColorFilter.mode(
                              getColorScheme(context).neutral60,
                              BlendMode.srcIn,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            );
          }).toList())
        ],
      ),
    );
  }
}
