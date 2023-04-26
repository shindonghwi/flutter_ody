import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:odac_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:odac_flutter_app/presentation/components/button/outline/OutlineRoundNeutralButton.dart';
import 'package:odac_flutter_app/presentation/components/textarea/BasicTextArea.dart';
import 'package:odac_flutter_app/presentation/components/textarea/model/TextAreaModel.dart';
import 'package:odac_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:odac_flutter_app/presentation/features/record/glucose/provider/RecordGlucoseMemoTextFieldProvider.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';
import 'package:odac_flutter_app/presentation/utils/dto/Pair.dart';

class RecordGlucoseMemo extends HookWidget {
  const RecordGlucoseMemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(top: 10, left: 15, right: 15),
      padding: EdgeInsets.only(left: 20, top: 22, bottom: 24, right: 14),
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
          SizedBox(height: 20),
          _MemoTextField()
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

class _MemoTextField extends HookConsumerWidget {
  const _MemoTextField({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final fieldState = ref.watch<TextAreaModel>(RecordGlucoseMemoTextFieldProvider);
    final fieldStateRead = ref.read(RecordGlucoseMemoTextFieldProvider.notifier);

    return BasicTextArea(
      maxLine: 3,
      controller: useTextEditingController(),
      fieldState: fieldState.fieldState,
      onDoneAction: () {
        FocusManager.instance.primaryFocus?.unfocus();
        fieldStateRead.change(fieldState: TextFieldState.Complete);
      },
      limit: 200,
      showCounterText: true,
    );
  }
}

/** 푸시 알림 시간 선택 */
class _SelectorNotificationTime extends HookWidget {
  const _SelectorNotificationTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final List<Pair<String, ValueNotifier>> buttonList = [
      Pair(
        getAppLocalizations(context).record_glucose_memo_notification_time_10,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(
              state: ButtonState.Default,
            ),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_memo_notification_time_30,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(
              state: ButtonState.Default,
            ),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_memo_notification_time_60,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(
              state: ButtonState.Default,
            ),
          ),
        ),
      ),
      Pair(
        getAppLocalizations(context).record_glucose_memo_notification_time_120,
        useState(
          StateNotifierProvider<ButtonNotifier, ButtonState>(
            (_) => ButtonNotifier(
              state: ButtonState.Default,
            ),
          ),
        ),
      ),
    ];

    return Container(
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: buttonList.map((e) {
            return OutlineRoundNeutralButton(
              text: e.first,
              onPressed: () {},
              type: ButtonSizeType.Small,
              buttonProvider: e.second.value,
            );
          }).toList()),
    );
  }
}
