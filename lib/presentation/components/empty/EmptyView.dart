import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:ody_flutter_app/presentation/features/main/home/notifier/CalendarPageNotifier.dart';
import 'package:ody_flutter_app/presentation/navigation/Route.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';
import 'package:ody_flutter_app/presentation/utils/date/DateChecker.dart';

class EmptyView extends HookConsumerWidget {
  final RoutingScreen screen;
  final VoidCallback? onPressed;

  const EmptyView({
    Key? key,
    required this.screen,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    DateTime currentDateTime = ref.read(calendarPageProvider.notifier).getCurrentDateTime();
    final comparisonValue = useState(0);

    useEffect(() {
      WidgetsBinding.instance.addPostFrameCallback((_) async {
        comparisonValue.value = DateChecker.isDateComparisonFromToday(currentDateTime);
      });
    }, [currentDateTime]);

    String? getImagePath() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return comparisonValue.value == 0 ? 'assets/imgs/icon_record_2.svg' : 'assets/imgs/icon_failed_to_record.svg';
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return comparisonValue.value == 0 ? 'assets/imgs/icon_record_2.svg' : 'assets/imgs/icon_failed_to_record.svg';
      } else if (screen == RoutingScreen.MedicationList) {
        return 'assets/imgs/icon_alarm_2.svg';
      } else if (screen == RoutingScreen.MainAnalysis) {
        return null;
      }
      return null;
    }

    String? getEmptyMessage() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return comparisonValue.value == 0
            ? getAppLocalizations(context).empty_record
            : comparisonValue.value > 0
                ? getAppLocalizations(context).empty_record_pre_disable
                : getAppLocalizations(context).empty_record_post_disable;
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return comparisonValue.value == 0
            ? getAppLocalizations(context).empty_record
            : comparisonValue.value > 0
                ? getAppLocalizations(context).empty_record_pre_disable
                : getAppLocalizations(context).empty_record_post_disable;
      } else if (screen == RoutingScreen.MedicationList) {
        return getAppLocalizations(context).empty_alarm;
      } else if (screen == RoutingScreen.MainAnalysis) {
        return getAppLocalizations(context).empty_report;
      }
      return null;
    }

    String? getButtonText() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return comparisonValue == 0
            ? getAppLocalizations(context).empty_button_record
            : getAppLocalizations(context).empty_button_go_home;
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return comparisonValue == 0
            ? getAppLocalizations(context).empty_button_record
            : getAppLocalizations(context).empty_button_go_home;
      } else if (screen == RoutingScreen.MedicationList) {
        return getAppLocalizations(context).empty_button_alarm_add;
      } else if (screen == RoutingScreen.MainAnalysis) {
        return getAppLocalizations(context).empty_button_go_home;
      }
      return null;
    }

    final imagePath = getImagePath();
    final message = getEmptyMessage();
    final buttonText = getButtonText();

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        if (imagePath != null)
          SvgPicture.asset(
            imagePath,
            fit: BoxFit.cover,
            width: 100,
            height: 100,
          ),
        if (imagePath != null) const SizedBox(height: 32),
        if (message != null)
          Text(
            message,
            style: getTextTheme(context).l2m.copyWith(
                  color: getColorScheme(context).neutral70,
                  height: 1.2,
                ),
            textAlign: TextAlign.center,
          ),
        if (message != null) const SizedBox(height: 32),
        if (buttonText != null)
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: getColorScheme(context).colorPrimaryFocus,
                width: 1.5,
              ),
              borderRadius: BorderRadius.circular(100),
            ),
            child: Material(
              color: Colors.transparent,
              child: InkWell(
                onTap: () => onPressed?.call(),
                borderRadius: BorderRadius.circular(100),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 27, vertical: 9),
                  child: Text(
                    buttonText,
                    style: getTextTheme(context).l3m.copyWith(
                          color: getColorScheme(context).colorPrimaryFocus,
                        ),
                  ),
                ),
              ),
            ),
          )
      ],
    );
  }
}
