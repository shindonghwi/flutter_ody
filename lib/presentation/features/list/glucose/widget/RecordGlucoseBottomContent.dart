import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/data/models/bio/ResponseBioGlucoseModel.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarSelectDateNotifier.dart';
import 'package:ody_flutter_app/presentation/features/main/provider/ForDaysBioInfoProvider.dart';
import 'package:ody_flutter_app/presentation/navigation/PageMoveUtil.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class RecordGlucoseBottomContent extends HookConsumerWidget {

  const RecordGlucoseBottomContent({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final now = DateTime.now();
    DateTime date = ref.watch(calendarSelectDateProvider);
    bool isRecordButtonVisible = "${date.year}${date.month}${date.day}" == "${now.year}${now.month}${now.day}";

    return Align(
      alignment: Alignment.bottomRight,
      child: isRecordButtonVisible ? _FloatingButton(date: date,) : const SizedBox(),
    );
  }
}

class _FloatingButton extends HookConsumerWidget {
  final DateTime date;

  const _FloatingButton({
    super.key,
    required this.date,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final uiState = ref.watch(forDaysBioInfoProvider);
    final uiStateRead = ref.read(forDaysBioInfoProvider.notifier);
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
                uiStateRead.addGlucoseBioInfo(data);
              }
            } catch (e) {
              debugPrint("glucose update fail: ${e.toString()}");
            }
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
