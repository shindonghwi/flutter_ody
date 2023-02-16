import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

AppLocalizations getApplocalizations(BuildContext context){
  return AppLocalizations.of(context);
}

TextTheme getTextTheme(BuildContext context){
  return Theme.of(context).textTheme;
}

ColorScheme getColorScheme(BuildContext context){
  return Theme.of(context).colorScheme;
}

MediaQueryData getMediaQuery(BuildContext context){
  return MediaQuery.of(context);
}
