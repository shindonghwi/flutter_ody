import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/components/loading/CircleLoading.dart';
import 'package:ody_flutter_app/presentation/components/toast/Toast.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/GlucoseRecorderNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/notifier/RecordGlucoseUiStateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucose.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseAppBar.dart';
import 'package:ody_flutter_app/presentation/features/record/glucose/widget/RecordGlucoseMemo.dart';
import 'package:ody_flutter_app/presentation/features/record/model/RecordType.dart';
import 'package:ody_flutter_app/presentation/features/record/widget/RecordDateSelector.dart';
import 'package:ody_flutter_app/presentation/models/UiState.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseScreen extends HookConsumerWidget {
  const RecordGlucoseScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch<UIState<String?>>(recordGlucoseUiStateProvider);
    final uiStateRead = ref.read(recordGlucoseUiStateProvider.notifier);
    final glucoseRecorderRead = ref.read(glucoseRecorderProvider.notifier);

    useEffect(() {
      void handleUiStateChange() async {
        await Future(() {
          uiState.when(
            success: (event) async {
              ToastUtil.defaultToast(getAppLocalizations(context).message_record_complete_blood_pressure);
              Navigator.of(context).pop(glucoseRecorderRead.getBioGlucoseModel());
              uiStateRead.init();
              glucoseRecorderRead.init();
            },
            failure: (event) {
              ToastUtil.errorToast( event.errorMessage);
            },
          );
        });
      }
      handleUiStateChange();
      return null;
    }, [uiState]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiStateRead.init();
        glucoseRecorderRead.init();
      });
      return null;
    }, []);

    return Stack(
      children: [
        Scaffold(
          backgroundColor: getColorScheme(context).colorUI03,
          appBar: const RecordGlucoseAppBar(),
          body: const SingleChildScrollView(
            physics: BouncingScrollPhysics(),
            child: SafeArea(
              child: Column(
                children: [
                  RecordDateSelector(type: RecordType.Glucose),
                  RecordGlucose(),
                  RecordGlucoseMemo(),
                ],
              ),
            ),
          ),
        ),
        if (uiState is Loading) const CircleLoading(),
      ],
    );
  }
}
