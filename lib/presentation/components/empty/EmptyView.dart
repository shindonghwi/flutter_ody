import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:odac_flutter_app/presentation/navigation/Route.dart';
import 'package:odac_flutter_app/presentation/ui/colors.dart';
import 'package:odac_flutter_app/presentation/ui/typography.dart';
import 'package:odac_flutter_app/presentation/utils/Common.dart';

class EmptyView extends HookWidget {
  final RoutingScreen screen;
  final VoidCallback? onPressed;

  const EmptyView({
    Key? key,
    required this.screen,
    required this.onPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String? getImagePath() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return 'assets/imgs/icon_record_2.svg';
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return 'assets/imgs/icon_record_2.svg';
      }
      return null;
    }

    String? getEmptyMessage() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return getAppLocalizations(context).empty_record;
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return getAppLocalizations(context).empty_record;
      }
      return null;
    }

    String? getButtonText() {
      if (screen == RoutingScreen.RecordedListBloodPressure) {
        return getAppLocalizations(context).empty_button_record;
      } else if (screen == RoutingScreen.RecordedListGlucose) {
        return getAppLocalizations(context).empty_button_record;
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
                  height: 1.25,
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
