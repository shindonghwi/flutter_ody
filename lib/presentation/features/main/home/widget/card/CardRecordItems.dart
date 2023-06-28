import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStepModel.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardBpItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardEmotionItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardGlucoseItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardWalkItem.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/utils/CollectionUtil.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/snackbar/SnackBarUtil.dart';

class CardRecordItems extends HookConsumerWidget {
  const CardRecordItems({
    super.key,
  });

  void movePage(BuildContext context, String title, DateTime currentDateTime) {
    if (title == getAppLocalizations(context).home_today_record_walk) {
      // 걸음수 화면
    } else if (title == getAppLocalizations(context).home_today_record_blood_pressure) {
    } else if (title == getAppLocalizations(context).home_today_record_glucose) {
      Navigator.push(
        context,
        nextSlideScreen(
          RoutingScreen.RecordedListGlucose.route,
          parameter: currentDateTime,
        ),
      );
    } else {}
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(forDaysBioInfoProvider);

    final ValueNotifier<List<ResponseBioStepModel>?> stepDataListState = useState([]);
    final ValueNotifier<List<ResponseBioBloodPressureModel>?> bpDataListState = useState([]);
    final ValueNotifier<List<ResponseBioGlucoseModel>?> glucoseDataListState = useState([]);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        uiState.when(
          success: (event) async {
            if (!CollectionUtil.isNullorEmpty(event.value?.steps)) {
              event.value?.steps.first;
            } else {}

            stepDataListState.value = event.value?.steps;
            bpDataListState.value = event.value?.bloodPressures;
            glucoseDataListState.value = event.value?.glucoses;
          },
          failure: (event) {
            SnackBarUtil.show(context, event.errorMessage);
          },
        );
      });
    }, [uiState]);

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardWalkItem(),
              ),
              const SizedBox(width: 20),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardBpItem(
                  bpDataList: bpDataListState.value,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardGlucoseItem(
                  glucoseDataList: glucoseDataListState.value,
                ),
              ),
              const SizedBox(width: 20),
              const Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardEmotionItem(),
              ),
            ],
          )
        ],
      ),
    );
  }
}
