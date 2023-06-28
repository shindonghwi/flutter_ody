import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordRangeStatus.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class CardEmotionItem extends HookConsumerWidget {
  const CardEmotionItem({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return LayoutBuilder(
      builder: (BuildContext context, BoxConstraints constraints) {
        double width = constraints.maxWidth;
        double desiredRatio = 0.89;

        return Container(
          decoration: BoxDecoration(
            color: getColorScheme(context).neutral40,
            borderRadius: BorderRadius.circular(20),
          ),
          child: AspectRatio(
            aspectRatio: desiredRatio,
            child: SizedBox(
              width: width,
              child: IgnorePointer(
                child: SizedBox(
                  width: width,
                  height: double.infinity,
                  child: Stack(
                    children: [
                      Container(
                        padding: const EdgeInsets.fromLTRB(16, 24, 16, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              getAppLocalizations(context).home_today_record_emotion,
                              style: getTextTheme(context).b3sb.copyWith(
                                    color: getColorScheme(context).neutral80.withOpacity(0.5),
                                  ),
                            ),
                            const SizedBox(
                              height: 16,
                            ),
                            Text(
                              getAppLocalizations(context).home_today_record_ment_prepare,
                              style: getTextTheme(context).b2b.copyWith(
                                    color: getColorScheme(context).neutral70,
                                  ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        margin: const EdgeInsets.only(right: 8, bottom: 8),
                        child: Align(
                          alignment: Alignment.bottomRight,
                          child: Image.asset(
                            width: 76,
                            height: 76,
                            RecordRangeStatusHelper.getOdyImagePath(
                              RecordType.Emotion,
                              RecordRangeStatus.None,
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
