import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeTodayDate extends StatelessWidget {
  const HomeTodayDate({
    super.key,
  });

  String getFormattedDate() {
    // Get the current date
    DateTime now = DateTime.now();

    // Define the format for the date string
    DateFormat formatter = DateFormat('MM월 dd일 EEEE', 'ko');

    // Format the date string
    String formattedDate = formatter.format(now);

    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20),
      padding: EdgeInsets.symmetric(horizontal: 14, vertical: 6),
      decoration: BoxDecoration(
        color: getColorScheme(context).secondary100,
        borderRadius: BorderRadius.circular(100),
      ),
      child: Text(
        getFormattedDate(),
        style: getTextTheme(context).c2b.copyWith(
              color: getColorScheme(context).white,
            ),
      ),
    );
  }
}
