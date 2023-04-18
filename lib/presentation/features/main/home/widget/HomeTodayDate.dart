import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeTodayDate extends StatelessWidget {
  const HomeTodayDate({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 26),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: getColorScheme(context).secondary100,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        "03월 30일 목요일",
        style: getTextTheme(context).c2b.copyWith(
              color: getColorScheme(context).white,
            ),
      ),
    );
  }
}
