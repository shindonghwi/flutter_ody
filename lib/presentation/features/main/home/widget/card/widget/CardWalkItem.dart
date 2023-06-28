import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class CardWalkItem extends StatelessWidget {
  const CardWalkItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
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
              onTap: () {},
              borderRadius: BorderRadius.circular(20),
              child: AspectRatio(
                aspectRatio: desiredRatio,
                child: Container(
                  width: width,
                  padding: const EdgeInsets.fromLTRB(16, 24, 8, 8),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        getAppLocalizations(context).home_today_record_walk,
                        style: getTextTheme(context).b3sb.copyWith(
                              color: getColorScheme(context).neutral70,
                            ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      FittedBox(
                        fit: BoxFit.scaleDown,
                        child: RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: "0",
                                style: getTextTheme(context).t2b.copyWith(
                                      color: getColorScheme(context).colorText,
                                    ),
                              ),
                              const WidgetSpan(
                                child: SizedBox(width: 8),
                              ),
                              TextSpan(
                                text: getAppLocalizations(context).home_today_record_walk_unit,
                                style: getTextTheme(context).c1b.copyWith(
                                      color: getColorScheme(context).neutral60,
                                    ),
                              ),
                            ],
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Expanded(
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            width: 76,
                            height: 76,
                            RecordRangeStatusHelper.getOdyImagePath(
                              RecordType.Walk,
                              RecordRangeStatus.Normal,
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
}
