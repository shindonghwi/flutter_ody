import 'package:flutter/material.dart';
import 'HomeBackgroundArc.dart';
import 'HomeTodayDate.dart';
import 'HomeUserInfo.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      painter: HomeBackgroundArc(),
      child: Container(
        margin: EdgeInsets.only(left: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            HomeTodayDate(),
            HomeUserInfo(),
          ],
        ),
      ),
    );
  }
}
