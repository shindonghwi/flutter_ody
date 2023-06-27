import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/features/list/glucose/provider/RecordListGlucoseProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseBottomContent extends HookConsumerWidget {
  final DateTime date;

  const RecordGlucoseBottomContent({
    Key? key,
    required this.date,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    bool isRecordButtonVisible = "${date.year}${date.month}${date.day}" == "${now.year}${now.month}${now.day}";

    return Align(
      alignment: Alignment.bottomRight,
      child: isRecordButtonVisible ? const _FloatingButton() : const SizedBox(),
    );
  }
}

class _FloatingButton extends HookConsumerWidget {
  const _FloatingButton({
    super.key,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiStateRead = ref.read(recordListGlucoseProvider.notifier);
    return Container(
      width: 50,
      height: 50,
      margin: const EdgeInsets.only(bottom: 48, right: 24),
      decoration: BoxDecoration(
        color: getColorScheme(context).primary100,
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: getColorScheme(context).primary100.withOpacity(0.2),
            spreadRadius: 2,
            blurRadius: 4,
            offset: const Offset(0, 6), // changes position of shadow
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(100),
          onTap: () async {
            ResponseBioGlucoseModel data = await Navigator.push(
              context,
              nextSlideScreen(RoutingScreen.RecordGlucose.route),
            );
            try {
              if (data.glucose != 0) {
                uiStateRead.addGlucose(data);
              }
            } catch (e) {}
          },
          child: SvgPicture.asset(
            'assets/imgs/icon_plus_btn.svg',
            colorFilter: ColorFilter.mode(
              getColorScheme(context).white,
              BlendMode.srcIn,
            ),
          ),
        ),
      ),
    );
  }
}
