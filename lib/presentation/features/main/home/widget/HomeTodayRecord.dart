import 'package:flutter/material.dart';
import 'package:odac_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Triple.dart';

class HomeTodayRecord extends StatelessWidget {
  const HomeTodayRecord({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    List<Triple> recordList = [
      Triple(
        "assets/imgs/ody_record_walk.png",
        getAppLocalizations(context).home_today_record_walk,
        () {

        },
      ),
      Triple(
        "assets/imgs/ody_record_glucose.png",
        getAppLocalizations(context).home_today_record_glucose,
        () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.RecordGlucose.route),
          );
        },
      ),
      Triple(
        "assets/imgs/ody_record_blood_pressure.png",
        getAppLocalizations(context).home_today_record_blood_pressure,
        () {
          Navigator.push(
            context,
            nextSlideScreen(RoutingScreen.RecordBloodPressure.route),
          );
        },
      ),
    ];

    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 23, top: 42),
            child: Text(
              getAppLocalizations(context).home_today_record_title,
              style: getTextTheme(context).h4b.copyWith(
                    color: getColorScheme(context).colorText,
                  ),
            ),
          ),
          Container(
            height: 205,
            margin: EdgeInsets.only(top: 30),
            child: ListView.separated(
              padding: EdgeInsets.only(left: 23),
              itemCount: 3,
              scrollDirection: Axis.horizontal,
              separatorBuilder: (BuildContext ctx, int idx) {
                return SizedBox(
                  width: 30,
                );
              },
              itemBuilder: (context, index) {
                return Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: recordList[index].third,
                    borderRadius: BorderRadius.circular(20),
                    child: Container(
                      width: 180,
                      padding: EdgeInsets.fromLTRB(18, 24, 12, 9),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        borderRadius: BorderRadius.circular(20),
                        border: Border.all(
                          color: getColorScheme(context).neutral40,
                          width: 2,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              recordList[index].second,
                              style: getTextTheme(context).t2b.copyWith(
                                    color: getColorScheme(context).colorText,
                                  ),
                            ), // The widget you want to place in the bottom right corner
                          ),
                          Align(
                            alignment: Alignment.bottomRight,
                            child: Image.asset(
                              recordList[index].first,
                              width: 63,
                              height: 82,
                            ), // The widget you want to place in the bottom right corner
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          )
        ],
      ),
    );
  }
}
