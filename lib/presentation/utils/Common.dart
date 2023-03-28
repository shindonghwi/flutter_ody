import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:odac_flutter_app/presentation/ui/theme.dart';

AppLocalizations getAppLocalizations(BuildContext context) {
  return AppLocalizations.of(context);
}

TextTheme getTextTheme(BuildContext context) {
  return Theme.of(context).textTheme;
}

ColorScheme getColorScheme(BuildContext context) {
  return getMediaQuery(context).platformBrightness == Brightness.dark
      ? AppTheme.darkTheme.colorScheme
      : AppTheme.lightTheme.colorScheme;
}

MediaQueryData getMediaQuery(BuildContext context) {
  return MediaQuery.of(context);
}
