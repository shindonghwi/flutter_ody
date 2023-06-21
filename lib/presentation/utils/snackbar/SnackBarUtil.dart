import 'package:flutter/material.dart';
import 'package:ody_flutter_app/presentation/ui/colors.dart';
import 'package:ody_flutter_app/presentation/ui/theme.dart';
import 'package:ody_flutter_app/presentation/ui/typography.dart';
import 'package:ody_flutter_app/presentation/utils/Common.dart';

class SnackBarUtil {
  static void show(BuildContext context, String message) {
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: getTextTheme(context).b2r.copyWith(
                color: ThemeMode.system == ThemeMode.dark
                    ? AppTheme.darkTheme.colorScheme.white
                    : AppTheme.lightTheme.colorScheme.black,
              ),
        ),
      ),
    );
  }
}
