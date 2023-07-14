import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioBloodPressureModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioForDaysModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioStepModel.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardBpItem.dart';
import 'package:ody_flutter_app/presentation/features/main/home/widget/card/widget/CardGlucoseItem.dart';

class CardRecordItems extends HookConsumerWidget {
  final ResponseBioForDaysModel model;

  const CardRecordItems({
    super.key,
    required this.model,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final List<ResponseBioStepModel> stepDataList = model.steps;
    final List<ResponseBioBloodPressureModel> bpDataList = model.bloodPressures;
    final List<ResponseBioGlucoseModel> glucoseDataList = model.glucoses;

    return Container(
      margin: const EdgeInsets.only(bottom: 48),
      child: Column(
        children: [
          const SizedBox(
            height: 16,
          ),
          Row(
            children: [
              // const Flexible(
              //   fit: FlexFit.tight,
              //   flex: 1,
              //   child: CardWalkItem(),
              // ),
              // const SizedBox(width: 20),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardBpItem(
                  bpDataList: bpDataList,
                ),
              ),
              const SizedBox(width: 20),
              Flexible(
                fit: FlexFit.tight,
                flex: 1,
                child: CardGlucoseItem(
                  glucoseDataList: glucoseDataList,
                ),
              ),
            ],
          ),
          // const SizedBox(height: 16),
          // Row(
          //   children: [
          //     Flexible(
          //       fit: FlexFit.tight,
          //       flex: 1,
          //       child: CardGlucoseItem(
          //         glucoseDataList: glucoseDataList,
          //       ),
          //     ),
          //     const SizedBox(width: 20),
          //     const Flexible(
          //       fit: FlexFit.tight,
          //       flex: 1,
          //       child: CardEmotionItem(),
          //     ),
          //   ],
          // )
        ],
      ),
    );
  }
}
