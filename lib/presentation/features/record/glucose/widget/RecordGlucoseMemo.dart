import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/outline/OutlineRoundNeutralButton.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseMemo extends HookWidget {
  const RecordGlucoseMemo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      padding:  EdgeInsets.only(left: 20, top: 22, bottom: 21, right: 14),
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          _PushNotificationTitle(context),
          SizedBox(height: 23),
          _SelectorNotificationTime(),
          SizedBox(height: 35),
          _MemoTitle(context),
        ],
      ),
    );
  }

  /** 푸시 알림 제목 */
  Row _PushNotificationTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).record_glucose_push_notification_title,
          style: getTextTheme(context).t2b.copyWith(
            color: getColorScheme(context).colorText,
          ),
          overflow: TextOverflow.ellipsis,
        ),
        SizedBox(width: 10),
        Text(
          getAppLocalizations(context).record_glucose_push_notification_subtitle,
          style: getTextTheme(context).c2r.copyWith(
            color: getColorScheme(context).neutral70,
          ),
          overflow: TextOverflow.ellipsis,
        ),
      ],
    );
  }

  /** 메모 제목 */
  Widget _MemoTitle(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Text(
        getAppLocalizations(context).record_glucose_memo_title,
        style: getTextTheme(context).t2b.copyWith(
          color: getColorScheme(context).colorText,
        ),
        overflow: TextOverflow.ellipsis,
      ),
    );
  }
}


/** 푸시 알림 시간 선택 */
class _SelectorNotificationTime extends StatelessWidget {
  const _SelectorNotificationTime({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          OutlineRoundNeutralButton(
            text: getAppLocalizations(context).record_glucose_memo_notification_time_10,
            onPressed: () {},
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                state: ButtonState.Default,
              ),
            ),
          ),
          OutlineRoundNeutralButton(
            text: getAppLocalizations(context).record_glucose_memo_notification_time_30,
            onPressed: () {},
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                state: ButtonState.Default,
              ),
            ),
          ),
          OutlineRoundNeutralButton(
            text: getAppLocalizations(context).record_glucose_memo_notification_time_60,
            onPressed: () {},
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                state: ButtonState.Default,
              ),
            ),
          ),
          OutlineRoundNeutralButton(
            text: getAppLocalizations(context).record_glucose_memo_notification_time_120,
            onPressed: () {},
            type: ButtonSizeType.Small,
            buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                  (_) => ButtonNotifier(
                state: ButtonState.Default,
              ),
            ),
          ),
        ],
      ),
    );
  }
}