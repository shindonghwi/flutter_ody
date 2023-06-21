import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonNotifier.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonSizeType.dart';
import 'package:ody_flutter_app/presentation/components/button/model/ButtonState.dart';
import 'package:ody_flutter_app/presentation/components/button/outline/OutlineRoundNeutralButton.dart';
import 'package:ody_flutter_app/presentation/components/textarea/BasicTextArea.dart';
import 'package:ody_flutter_app/presentation/components/textarea/model/TextAreaModel.dart';
import 'package:ody_flutter_app/presentation/components/textfield/model/TextFieldState.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/RecordGlucoseMemoTextFieldNotifier.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/regex/RegexUtil.dart';

class RecordGlucoseMemo extends HookWidget {
  const RecordGlucoseMemo({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(top: 22, left: 15, right: 15),
      padding: const EdgeInsets.only(left: 24, top: 27, bottom: 21, right: 24),
      decoration: BoxDecoration(
        color: getColorScheme(context).white,
        borderRadius: BorderRadius.circular(5),
      ),
      child: Column(
        children: [
          _pushNotificationTitle(context),
          const SizedBox(height: 16),
          const _SelectorNotificationTime(),
          const SizedBox(height: 32),
          _memoTitle(context),
          const SizedBox(height: 16),
          const _MemoTextField()
        ],
      ),
    );
  }

  /// 푸시 알림 제목
  Row _pushNotificationTitle(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        Text(
          getAppLocalizations(context).record_glucose_push_notification_title,
          style: getTextTheme(context).t2b.copyWith(
                color: getColorScheme(context).colorText,
              ),
        ),
        const SizedBox(width: 8),
        Text(
          getAppLocalizations(context).record_glucose_push_notification_subtitle,
          style: getTextTheme(context).c2r.copyWith(
                color: getColorScheme(context).neutral70,
              ),
        ),
      ],
    );
  }

  /// 메모 제목
  Widget _memoTitle(BuildContext context) {
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
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    final fieldState = ref.watch<TextAreaModel>(recordGlucoseMemoTextFieldProvider);
    final fieldStateRead = ref.read(recordGlucoseMemoTextFieldProvider.notifier);

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
      onChanged: (value) {
        glucoseRecorderRead.updateMemo(value);
      },
    );
  }
}

/// 푸시 알림 시간 선택
class _SelectorNotificationTime extends HookConsumerWidget {
  const _SelectorNotificationTime({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    final remindTimeList = [
      getAppLocalizations(context).record_glucose_memo_notification_time_10,
      getAppLocalizations(context).record_glucose_memo_notification_time_30,
      getAppLocalizations(context).record_glucose_memo_notification_time_60,
      getAppLocalizations(context).record_glucose_memo_notification_time_120,
    ];

    final remindTimeState = useState<int?>(null);

    return SizedBox(
      width: double.infinity,
      child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: remindTimeList.map((e) {
            return SizedBox(
              width: 68,
              child: OutlineRoundNeutralButton(
                  text: e,
                  onPressed: () {
                    final remindTime = RegexUtil.extractIntegers(e);

                    if (remindTimeState.value == remindTime) {
                      remindTimeState.value = null;
                      glucoseRecorderRead.updateRemindTime(0);
                    }else{
                      remindTimeState.value = remindTime;
                      glucoseRecorderRead.updateRemindTime(remindTime);
                    }
                  },
                  type: ButtonSizeType.XSmall,
                  buttonProvider: StateNotifierProvider<ButtonNotifier, ButtonState>(
                    (_) => ButtonNotifier(
                      state: remindTimeState.value == RegexUtil.extractIntegers(e)
                          ? ButtonState.Activated
                          : ButtonState.Default,
                    ),
                  )),
            );
          }).toList()),
    );
  }
}
