import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class HomeUserInfo extends StatelessWidget {
  const HomeUserInfo({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 12, left: 3, bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(left: 3),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "운동하는 다람쥐님",
                  style: getTextTheme(context).h3b.copyWith(
                        color: getColorScheme(context).white,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
                SizedBox(height: 5),
                Text(
                  "오늘도 오디와 함께 건강 기록을 해볼까요?",
                  style: getTextTheme(context).b3r.copyWith(
                        color: getColorScheme(context).white,
                      ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                ),
              ],
            ),
          ),
          Container(
            width: 77,
            height: 77,
            margin: EdgeInsets.only(right: 27),
            decoration: BoxDecoration(
              color: getColorScheme(context).white,
              borderRadius: BorderRadius.circular(100),
            ),
            child: Image.asset(
              'assets/imgs/default_profile.png',
            ),
          )
        ],
      ),
    );
  }
}
